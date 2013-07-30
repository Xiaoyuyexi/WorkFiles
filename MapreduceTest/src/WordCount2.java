  
  
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.FileInputFormat;
import org.apache.hadoop.mapred.FileOutputFormat;
import org.apache.hadoop.mapred.JobClient;
import org.apache.hadoop.mapred.JobConf;
  
/* 
 *@author huangdou 
 *created on 2011-4-1����03:20:11 
 */  
public class WordCount2 {  
  
  
    public static void main(String[] args) throws Exception {  
        //������һ�������ᵼ�µײ��޷�����setJarByClass����,����ʱClassNotFound  
        JobConf conf = new JobConf(WordCount2.class);     
        //����map��  
        conf.setMapperClass(WordCountMapper.class);  
        //����reduce��  
        conf.setReducerClass(WordCountReducer.class);  
        //�����������  
        conf.setOutputKeyClass(Text.class);  
        conf.setOutputValueClass(IntWritable.class);  
  
        String[] test={"CAO","NI","MA"};
        //������������һ���ⶼ��input path,���һ����output path  
        for (int i = 0; i < test.length - 1; i++) {  
            FileInputFormat.addInputPath(conf, new Path(test[i]));  
        }  
  
        FileOutputFormat.setOutputPath(conf, new Path(test[test.length - 1]));  
  
        JobClient.runJob(conf);  
    }  
}  
