package cn.com.base.constants;
/**
 * 
* 功能描述:定义业务常量
* <p>版权扄1�7�1�7�：北京康讯通讯
* <p>未经本公司许可，不得以任何方式复制或使用本程序任何部刄1�7�1�7
*
* @author chenliang 新增日期＄1�713-1-14
* @since mms-cms-unicom
 */
public class BusinessConstants {
	
	//项目编码
	public static final String PROJECT_ENCODE = "UTF-8";
	
	//错误代码
	//操作类型
	public static final int ERRORCODE_OPERTYPE_ADD=1; //添加
	public static final int ERRORCODE_OPERTYPE_EDIT=2; //修改
	//失败原因
	public static final int FAILURE_REASON_CONNECTIONOUTTIME=1;//连接超时
	public static final int FAILURE_REASON_POLICYIDOCCU=2;//policy id被占甄1�7�1�7
	public static final int FAILURE_REASON_OTHER=3;//其它原因
	
	//mms发送类型
	public static final int send_mms_type = 1;//
	
	//时间发送类型
	public static final int send_time_type = 1;//
	
	//相框存放的东西的类型
	public static final int type_stamp = 1;  	//邮票
	public static final int type_wish = 2;  	//祝福语
	public static final int type_postmast = 3;  //邮戳
	public static final int type_photo = 4;		//照片
	
	//消息类型
	public static final int msg_type_templatecard = 1; //模板明信片发送
	public static final int msg_type_diycard = 2; //diy明信片发送
	
}