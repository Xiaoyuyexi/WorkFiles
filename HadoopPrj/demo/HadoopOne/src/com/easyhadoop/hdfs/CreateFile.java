package com.easyhadoop.hdfs;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;

public class CreateFile {
 
    public static void main(String[] args) throws Exception {
       /* 
    	Configuration conf=new Configuration();
        FileSystem hdfs=FileSystem.get(conf);
        byte[] buff="hello hadoop world!\n".getBytes();
        Path dfs=new Path("/TestDir/test");
        FSDataOutputStream outputStream=hdfs.create(dfs);
        outputStream.write(buff,0,buff.length);
        
         //��ϰһ
        Configuration conf1=new Configuration();
        FileSystem system1=FileSystem.get(conf1);
        Path path=new Path("/TestDir/ko");
        byte[] name="wo jiao han xiao jiao �Ǻ�".getBytes();
        FSDataOutputStream oututstream= system1.create(path);
        oututstream.write(name, 0, name.length);
        */
        //��ϰ��
        Configuration conf2=new Configuration();
        FileSystem system2=FileSystem.get(conf2);
        Path path2=new Path("/TestDir/a/b/c/d/hello.txt");
        byte[] names="���\n�ҽк�С�".getBytes();
       FSDataOutputStream outputstream=system2.create(path2);
       outputstream.write(names, 0, names.length);
        /*//��ϰ��
       Configuration conf3=new Configuration();
       FileSystem system3=FileSystem.get(conf3);
       Path path3=new Path("/TestDir/aa");
       byte[] name3="���\n�ҽк�С�".getBytes();
       FSDataOutputStream OutputStream =system3.create(path3);
       OutputStream.write(name3,0,name3.length);
       
        Configuration conf4=new Configuration();
        FileSystem system4=FileSystem.get(conf4);
        Path path4=new Path("/TestDir/aa");
        byte name4[]="��\n��\n��\n��\n��\nС\n�".getBytes();
        FSDataOutputStream OutputStream4 =system4.create(path4);
        OutputStream4.write(name4,0,name4.length);*/
    }
}