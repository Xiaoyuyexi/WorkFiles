package com.unicom.mms.pushjob.service;

import java.rmi.RemoteException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.xml.rpc.ServiceException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.unicom.mms.common.Response;
import com.unicom.mms.constants.SharePublicContants;
import com.unicom.mms.entity.TSignOrder;
import com.unicom.mms.entity.TbSendMmsQueue;
import com.unicom.mms.entity.TbSendSmsQueue;
import com.unicom.mms.gateway.PostcardMMS;
import com.unicom.mms.mcp.webservice.Mcp;
import com.unicom.mms.mcp.webservice.McpServiceLocator;
import com.unicom.mms.pushjob.dao.SendMmsQueueDAO;
import com.unicom.mms.pushjob.dao.SendSmsQueueDAO;

/**
 * 
* 功能描述:待发送彩信业务实体类
* 版权所有：康讯通讯
* 未经本公司许可，不得以任何方式复制或使用本程序任何部分
* @author chenliang 新增日期：2013-9-27
* @author chenliang 修改日期：2013-9-27
* @since mms-task
 */
@Service("sendMmsQueueService")
public class SendMmsQueueService {

	private static final Logger LOGGER = LoggerFactory.getLogger(SendMmsQueueService.class);
	
	@Autowired( required = true )
	private SendMmsQueueDAO sendMmsQueueDAO;
	@Autowired(required = true)
	private UserServiceImpl userService;
	
	/**
	 * 
	* 方法用途和描述: 批量保存待发送短信
	* @param smsList
	* @author chenliang 新增日期：2013-9-27
	* @since mms-task
	 */
	public void saveBatchSendSms(List<TbSendMmsQueue> smsList){
		sendMmsQueueDAO.saveBatchSendSms(null, smsList);
	}
	
	/**
	 * 
	* 方法用途和描述: 定时发送彩信任务
	* @author chenliang 新增日期：2013-10-26
	 * @throws ServiceException 
	 * @throws RemoteException 
	* @since mms-task
	 */
	public void inTimeSendMmsWork() throws ServiceException, RemoteException{
		//查询彩信待发送表中的数据，等级为1，渠道为web
		String hql = "from TbSendMmsQueue where sendLevel=1 and channel=1 and toBeSendTime is not null and states = 1"; 
		List<TbSendMmsQueue> queueList = sendMmsQueueDAO.find(hql);
		try {
			if(null != queueList && queueList.size()>0 ){
				Mcp mcp = new McpServiceLocator().getMcpPort();
				Gson gson = new Gson();
				String param = "";
				LOGGER.info("开始定时发送彩信任务.");
				Date now = new Date();
				for (int i = 0; i < queueList.size(); i++) {
					TbSendMmsQueue sendMmsQueue = queueList.get(i);
					if(now.after(sendMmsQueue.getToBeSendTime())){
						PostcardMMS cardmms = new PostcardMMS();
						cardmms.setSender(sendMmsQueue.getSponsor()); //发起人
						cardmms.setReceiver(sendMmsQueue.getReciver()); //接收人
						cardmms.setContent(sendMmsQueue.getMsgBody()); //内容
						cardmms.setChannel(""+sendMmsQueue.getChannel()); //渠道
						cardmms.setMsgType(sendMmsQueue.getMsgType()); //消息类型
						cardmms.setMsgSn(sendMmsQueue.getTransationId());  //消息id
						cardmms.setSubject(sendMmsQueue.getTitle());
						cardmms.setImagePath(sendMmsQueue.getPicUrl()); //图片地址
						cardmms.setMusicPath(sendMmsQueue.getMusicUrl()); //音乐地址
						
						//根据发起人号码，查询产品号码
						TSignOrder signOrder = userService.findProductByMdn(sendMmsQueue.getSponsor());
						cardmms.setProductCode(signOrder.getProductId()); //产品id
						
						//调用接口
						param = gson.toJson(cardmms); 
						String response = mcp.sendPostcardMms(param);
						Response resp = gson.fromJson(response, new TypeToken<Response>(){}.getType());
						LOGGER.info("接口调用接口["+resp.getMsg()+"].");
					}
				}
			}else{
				LOGGER.info("没有定时发送彩信任务.");
			}
		} catch (RemoteException e) {
			LOGGER.error("定时发送彩信任务异常.",e);
			throw e;
		}
	}
	
}