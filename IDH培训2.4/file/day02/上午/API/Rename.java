package HDFSDemo.API;

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
       
  
        
        
    }
}