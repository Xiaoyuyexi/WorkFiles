import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class MakeBigData {
	/** 
	 * ��ȡ������� 
	 * @param begindate ��ʼ���ڣ���ʽΪ��yyyy-mm-dd 
	 * @param enddate �������ڣ���ʽΪ��yyyy-mm-dd 
	 * @return 
	 */
	private static String randomdate(String begindate,String  enddate ){ 
		try { 
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			Date start = format.parse(begindate);//���쿪ʼ���� 
			Date end = format.parse(enddate);//����������� 
			//gettime()��ʾ������ 1970 �� 1 �� 1 �� 00:00:00 gmt ������ date �����ʾ�ĺ������� 
			if(start.getTime() >= end.getTime()){ 
				return null; 
			} 
			long date = random(start.getTime(),end.getTime()); 
			return format.format(new Date(date)); 
		} catch (Exception e) { 
			e.printStackTrace();
		} 
		return null; 
	} 
	private static long random(long begin,long end){ 
		long rtn = begin + (long)(Math.random() * (end - begin)); 
		//������ص��ǿ�ʼʱ��ͽ���ʱ�䣬��ݹ���ñ������������ֵ 
		if(rtn == begin || rtn == end){  
			return random(begin,end); 
		} 
		return rtn; 
	} 

	/**
	 * @author DongGod
	 * �����ģ�������   ����,URL,ʱ��,2Gor3G,iemi��,content_type,����״̬��404֮��,�ļ���С
	 * @param args
	 * @throws IOException
	 */
	public static void main(String args[]) throws IOException {
//		for(int i=0;i<100;i++){
//								System.out.println(MakeBigData.randomdate("2013-01-01 00:00:00", "2013-04-03 23:59:59"));
//							    System.out.println((int) (Math.random() * 5000));
//		}

		File file = new File("E://haha.txt");	
		BufferedWriter fileWriter = null;
		try {
			fileWriter = new BufferedWriter(
					new FileWriter(file, true));
			Long number=13000000000l;//����
			String url="http://www.baidu.com";
			String onlineType="2G";
			Long imei=460030912121001l;
			String content_type="text/html;charset=GBK";
			String state_code="404";
			for(int i=0;i<10000000;i++){
				if(i%2==0){
					onlineType="2G";
				}else{
					onlineType="3G";
				}
				if(i%3==0){
					url="www.163.com";
				}
				else if(i%4==0){
					url="http://www.126.com";
					content_type="text/html;charset=UTF8";
					state_code="500";
				}
				else if(i%5==0){
					url="http://www.17173.com";
					content_type="no way";
					state_code="302";
				}
				fileWriter.write(number+",");
				fileWriter.write(MakeBigData.randomdate("2013-01-01 00:00:00", "2013-04-03 23:59:59")+",");
				fileWriter.write(url+",");
				fileWriter.write(onlineType+",");
			    fileWriter.write(imei+",");
			    fileWriter.write(content_type+",");
			    fileWriter.write(state_code+",");
				fileWriter.write((int) (Math.random() * 5000)+"");
				fileWriter.newLine();
				imei++;
				number++;
			}
			fileWriter.flush();
		} catch (IOException e) {

			fileWriter.close();
			e.printStackTrace();
		}

	}
}
