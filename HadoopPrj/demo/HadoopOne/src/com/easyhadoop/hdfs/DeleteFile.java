package com.easyhadoop.hdfs;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;

public class DeleteFile {
 
    public static void main(String[] args) throws Exception {
    	 
        Configuration conf=new Configuration();
        FileSystem hdfs=FileSystem.get(conf);
        Path delef=new Path("/user/hadoop/outputsum");
        //ɾ��һ���ļ������������ļ���
        //boolean isDeleted=hdfs.delete(delef,false);
        //�ݹ�ɾ��
        boolean isDeleted=hdfs.delete(delef,true);
        System.out.println("Delete?"+isDeleted);
        
       /*
         //��ϰһ
        Configuration conf1=new Configuration();
        FileSystem system=FileSystem.get(conf1);
        Path path=new Path("/user/hadoop/output7");
        boolean bool= system.delete(path,true);
        if (bool)
        {
        	System.out.print("ɾ���ɹ���");
        }
        else
        {
        	System.out.print("ɾ��ʧ�ܣ�");
        }
        //��ϰ��
    	Configuration conf2=new Configuration();
    	FileSystem system2=FileSystem.get(conf2);
    	Path path2=new Path("/user/hadoop/input/load");
    	//Ĭ��Ϊtrue
    	boolean bool2=system2.delete(path2);
    	if (bool2)
        {
        	System.out.print("ɾ���ɹ���");
        }
        else
        {
        	System.out.print("ɾ��ʧ�ܣ�");
        }
         //��ϰ��
        Configuration conf3=new Configuration();
    	FileSystem system3=FileSystem.get(conf3);
    	Path path3=new Path("/user/hadoop/input/load/aa");
    	//Ĭ��Ϊtrue
    	boolean bool3=system3.delete(path3,true);
    	if (bool3)
        {
        	System.out.print("ɾ���ɹ���");
        }
        else
        {
        	System.out.print("ɾ��ʧ�ܣ�");
        }
       
        Configuration conf4=new Configuration();
    	FileSystem system4=FileSystem.get(conf4);
    	Path path4=new Path("/TestDir");
    	//Ĭ��Ϊtrue
    	boolean bool4=system4.delete(path4);
    	if (bool4)
        {
        	System.out.print("ɾ���ɹ���");
        }
        else
        {
        	System.out.print("ɾ��ʧ�ܣ�");
        }*/
    }
}
 