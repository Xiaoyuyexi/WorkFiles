package cn.com.mmsweb.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unicom.mms.entity.TbCardType;
import com.unicom.mms.entity.TbSendMmsQueue;
import com.unicom.mms.entity.TbSendedMmsRecs;
import com.unicom.mms.entity.TbTemplateCard;

import cn.com.common.Page;
import cn.com.mmsweb.dao.CommonDAO;
import cn.com.mmsweb.dao.SendRecsDAO;
import cn.com.mmsweb.dao.SendedRecsDAO;
import cn.com.mmsweb.service.SendRecsService;
import cn.com.mmsweb.vo.SendRecsVo;
import cn.com.mmsweb.vo.TemplateCardtVo;

@Service("sendRecsService")
public class SendRecsServiceImpl extends CommonServiceImpl<TbSendedMmsRecs> implements SendRecsService{

	private static Logger log = Logger.getLogger(SendRecsServiceImpl.class);
	@Autowired(required = true)
	private SendedRecsDAO sendedRecsDAO;
	@Autowired(required = true)
	private SendRecsDAO sendRecsDAO;
	@Override
	public CommonDAO<TbSendedMmsRecs> getBindDao() {
		return sendedRecsDAO;
	}
	
	@Override
	 public List<SendRecsVo> queryByPage (int pageSize, int pageNow,String sponsor) {
		List<SendRecsVo> voList=new ArrayList<SendRecsVo>();
		 List<TbSendedMmsRecs> sendedMmsRecsList=sendedRecsDAO.queryByPage(pageSize, pageNow,sponsor);
		 for(TbSendedMmsRecs sendedMmsRecs:sendedMmsRecsList)
		 {
			 SendRecsVo sendRecsVo=new SendRecsVo();
			 sendRecsVo.setId(""+sendedMmsRecs.getId());
	    	   sendRecsVo.setMusicUrl(sendedMmsRecs.getMusicUrl());
	    	   sendRecsVo.setPicUrl(sendedMmsRecs.getPicUrl());
	    	   sendRecsVo.setReciver(sendedMmsRecs.getReciver());
	    	   sendRecsVo.setTitle(sendedMmsRecs.getTitle());
	    	   sendRecsVo.setUserName(sendedMmsRecs.getSponsor());
	    	   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm");  
	    	   sendRecsVo.setSendTime(sdf.format(sendedMmsRecs.getSendTime()));
	    	   sendRecsVo.setStruts("已发送");
	    	   voList.add(sendRecsVo);
		 }
		 List<TbSendMmsQueue> sendMmsQueuesList=sendRecsDAO.queryByPage(pageSize, pageNow,sponsor);
		 for(TbSendMmsQueue sendMmsQueue:sendMmsQueuesList)
		 {
			 SendRecsVo sendRecsVo=new SendRecsVo();
			 sendRecsVo.setId(""+sendMmsQueue.getId());
	    	   sendRecsVo.setMusicUrl(sendMmsQueue.getMusicUrl());
	    	   sendRecsVo.setPicUrl(sendMmsQueue.getPicUrl());
	    	   sendRecsVo.setReciver(sendMmsQueue.getReciver());
	    	   sendRecsVo.setTitle(sendMmsQueue.getTitle());
	    	   sendRecsVo.setUserName(sendMmsQueue.getSponsor());
	    	   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm");  
	    	   sendRecsVo.setSendTime(sdf.format(sendMmsQueue.getSendTime()));
	    	   sendRecsVo.setStruts("待发送");
	    	   voList.add(sendRecsVo);
		 }
		 return voList;
	 }
	
	@Override
	 public int maxPage(int pageSize, int pageNow,String sponsor)
	 {
		 return sendedRecsDAO.maxPage(pageSize, pageNow,sponsor);
	 }
	
}