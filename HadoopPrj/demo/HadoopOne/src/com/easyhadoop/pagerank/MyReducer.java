package com.easyhadoop.pagerank;

import java.io.IOException;
import java.util.ArrayList;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class MyReducer extends Reducer<IntWritable, Text, IntWritable, Text>{

	@Override
	protected void reduce(IntWritable key, Iterable<Text> values,
			Context context)
			throws IOException, InterruptedException {
		
		// ����һ���洢��ҳ����ID�Ķ���
		ArrayList<String> ids = new ArrayList<String>();
		// �����е�����ID��String��ʽ����
		String lianjie = "  ";
		// ����һ��������ҳPRֵ�ı���
		float pr = 0;
        //����
		for(Text id : values) {
			  String idd = id.toString();
			//�ж�value�ǹ���ֵ�������ⲿ������
			  if (idd.substring(0, 1).equals("@")) {
				// ����ֵ
				pr += Float.parseFloat(idd.substring(1));
			} else if (idd.substring(0, 1).equals("&")) {
				// ����id
				String iddd = idd.substring(1);
				System.out.println("idddd= " + iddd);
				ids.add(iddd);
			}
		}
		// ��������pr
		pr = pr * 0.85f + 0.15f;
		// �õ���������ID��String��ʽ
		for (int i = 0; i < ids.size(); i++) {
			lianjie += ids.get(i) + "  ";
		}
		// ���pr+lianjie��ԭ�ļ��ĸ�ʽ����
		String result = pr + lianjie;
		System.out.println("Reduce    result=" + result);
		try {
			context.write(key, new Text(result));
			System.out.println("reduce ִ����ϡ���������");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
	}
	
}