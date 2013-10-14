package com.easyhadoop.pagerank;

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class MainClass {

	public static void main(String[] args) throws IOException,
			InterruptedException, ClassNotFoundException {

		Configuration conf = new Configuration();
		String pathIn1 = "hdfs://192.168.195.140:9000/user/hadoop/input/pagerank/";// ����·��
		String pathOut = "hdfs://192.168.195.140:9000/user/hadoop/output/";// ���·��
		// ����10��
		for (int i = 0; i < 10; i++) {
			System.out.println("xunhuan cishu=" + i);
			Job job = new Job(conf, "MapReduce pagerank");
			pathOut = pathIn1 + i;
			job.setJarByClass(MainClass.class);
			job.setMapperClass(MyMapper.class);
			job.setReducerClass(MyReducer.class);
			job.setOutputKeyClass(IntWritable.class);
			job.setOutputValueClass(Text.class);
			FileInputFormat.addInputPath(job, new Path(pathIn1));
			FileOutputFormat.setOutputPath(job, new Path(pathOut));
			pathIn1 = pathOut;
			job.waitForCompletion(true);

		}

	}

}
