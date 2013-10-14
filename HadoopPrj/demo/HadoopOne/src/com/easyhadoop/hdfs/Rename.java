package com.easyhadoop.hdfs;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;

public class Rename{
    public static void main(String[] args) throws Exception {
    	
        Configuration conf=new Configuration();
        FileSystem hdfs=FileSystem.get(conf);
        Path frpaht=new Path("/TestDir");    //�ɵ��ļ���
        Path topath=new Path("/Test");    //�µ��ļ���
        boolean isRename=hdfs.rename(frpaht, topath);
        String result=isRename?"�ɹ�":"ʧ��";
        System.out.println("�ļ����������Ϊ��"+result);
       
    	/*
    	Configuration conf1=new Configuration();
    	FileSystem system=FileSystem.get(conf1);
    	Path Bpath=new Path("/Test");
    	Path Apath=new Path("/TestFile");
    	boolean bool=system.rename(Bpath, Apath);
    	if (bool)
    	{
    		System.out.print("�������ɹ���");
    	}
    	else
    	{
    		System.out.print("������ʧ�ܣ�");
    	}
    	
        Configuration conf3=new Configuration();
    	FileSystem system3=FileSystem.get(conf3);
    	Path Bpath3=new Path("/Test");
    	Path Apath3=new Path("/TestFile");
    	boolean bool3=system3.rename(Bpath3, Apath3);
    	if (bool3)
    	{
    		System.out.print("�������ɹ���");
    	}
    	else
    	{
    		System.out.print("������ʧ�ܣ�");
    	}
        */
        
        
        
    }
}