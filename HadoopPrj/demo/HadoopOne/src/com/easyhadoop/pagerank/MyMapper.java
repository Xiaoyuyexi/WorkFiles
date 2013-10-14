package com.easyhadoop.pagerank;

import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public  class MyMapper extends
			Mapper<Object, Text, IntWritable, Text> {

		//�洢��ҳID
		private IntWritable id;
		//�洢��ҳPRֵ
		private String pr;
		//�洢��ҳ������������Ŀ
		private int count;
		//��ҳ��ÿ���ⲿ���ӵ�ƽ������ֵ
		private float average_pr;
		//���ݻ�ԭ
		//2012112200001 24 10 

		public void map(Object key, Text value, Context context) {
			StringTokenizer str = new StringTokenizer(value.toString());
			if (str.hasMoreTokens()) {
				// �õ���ҳID
				id = new IntWritable(Integer.parseInt(str.nextToken()));
			} else {
				return;
			}
			// �õ���ҳpr
			pr = str.nextToken();
			// �õ�����������Ŀ
			count = str.countTokens();
			// ��ÿ���ⲿ����ƽ������ֵ
			average_pr = Float.parseFloat(pr) / count;
			// �õ���ҳ����������ID�����
			while (str.hasMoreTokens()) {
				try {
					String nextId = str.nextToken();
					//����ҳ�������ӵ�ID�ԡ�@+�õ�����ֵ����ʽ���
					Text t = new Text("@" + average_pr);
					context.write(id, t);
					// ����ҳID��PRֵ���
					Text tt = new Text("&" + nextId);
					context.write(id, tt);
				} catch (IOException e) {
					e.printStackTrace();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}

	}
