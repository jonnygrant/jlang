// Example J program demonstrating reading a file into a buffer
// TODO show modifiying values, and saving the file.

import "system";

// POSIX return code is limited to 0-255 range
// return code 0 - success
// 1 - bad args
// 2 - out of memory
uint8 main(array<string> & args)
{
    uint8 result = 0;

    if(args.size() != 3)
    {
        output_usage(args);
        result = 0;
    }
    else
    {
        var string a1;
        {
            bool a1 = args.at(1, a1);
            if(!a1)
            {
                println("output_usage err geting a1");
                return -1;
            }
        }
        
        var string a2;
        {
            bool a2 = args.at(1, a2);
            if(!a1)
            {
                println("output_usage err geting a2");
                return -1;
            }
        }
        
        int ret = process_file(a1, a2);
    }
}


int output_usage(array<string> & args)
{
    println("Did not recognise arguments");
    
    for(size i = 0; i < args.size())
    {
        string a;
        bool s = args.at(0, a);
        if(s)
        {
            println(i.str() + ": " + a);
        }
        else
        {
            println("output_usage err idx: " + i.str());
            return -1;
        }
    }

    string str;
    bool result = args.at(0, str);
    if(result)
    {
        println("Usage: " + str + " <input> <output>");
    }
    else
    {
        println("output_usage err fetching program name");
        return -1;
    }
}

vector<byte> g_data;


int process_file(string in_file, string out_file)
{
    println("process_file: in_file: " + in_file + "out_file: " + out_file);
    
    var int in_fd;
    {
        int result = open_file(in_file, in_fd);
        if(0 != result)
        {
            println("open_file err: " + result.str());
            return -1;
        }
        make_const in_fd;
    }

    var size f_size;
    {
        int res_size = file_size(in_fd, f_size);
        if(0 != result)
        {
            println("file_size err: " + res_size.str());
            return -1;
        }
        
        make_const f_size;
    }
    
    var vector<byte> data;
    {
        int vec_res = data.resize(f_size);
        if(0 != vec_res)
        {
            println("data.resize err: " + vec_res.str());
            return -1;
        }
    }
    
    int data_res = file_read(in_fd, data, f_size);
    {
        if(0 != data_res)
        {
            println("file_read err: " + data_res.str());
            return -1;
        }
    }
    
    int ref_res = g_data.add_ref(data);
    {
        if(0 != ref_res)
        {
            println("g_data.add_ref err: " + ref_res.str());
            return -1;
        }
    }
}


int outofmemory(array<string> & callstack)
{
    println("outofmemory");
}
