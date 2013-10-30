package com.unicom.mms.cms.service.ipml;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.unicom.mms.base.constants.BusinessConstants;
import com.unicom.mms.cms.action.util.FileUtil;
import com.unicom.mms.cms.dao.CommonDAO;
import com.unicom.mms.cms.dao.JobPolicDAO;
import com.unicom.mms.cms.dao.PushMdnDAO;
import com.unicom.mms.cms.service.JobPolicService;
import com.unicom.mms.cms.vo.PolicEntity;
import com.unicom.mms.common.BlankUtil;
import com.unicom.mms.constants.SharePublicContants;
import com.unicom.mms.entity.TbMdnType;
import com.unicom.mms.entity.TbPolic;
/**
 * 
* 功能描述:策略任务管理业务类
* @author chenliang 新增日期：2013-3-3
* @since mms-cms-unicom
 */
@Service("jobPolicService")
public class JobPolicServiceImpl extends CommonServiceImpl<TbPolic> implements JobPolicService{
	public static Logger log = Logger.getLogger(JobPolicServiceImpl.class);

	@Autowired(required = true)
	private JobPolicDAO jobPolicDAO;
	@Autowired(required = true)
	private PushMdnDAO pushMdnDAO;
	
	@Override
	public CommonDAO<TbPolic> getBindDao() {
		return jobPolicDAO;
	}

	@Override
	public void saveJobPolic(TbPolic model, HashMap<String, Object> map) {
		PolicEntity entity = (PolicEntity) map.get("policEntity");
		TbPolic policEntity = new TbPolic();
		//判断是彩信还是短信
		if(SharePublicContants.SMS == model.getMsgType()){ //保存短信策略
			//设置保存值
			setValue(model,entity,policEntity);
		}else if(SharePublicContants.MMS == model.getMsgType()){//保存彩信策略
			//设置保存值
			setValue(model,entity,policEntity);
			//上传彩信文件
			File file = (File) map.get("file");
			String fileName = (String) map.get("fileName");
			String mmsUrl = (String) map.get("mmsUrl");
			FileUtil.bakTemplatesDoc(file, mmsUrl, fileName, false, 0);
			//设置彩信文件地址
			//TODO 需要调用图片服务器
			policEntity.setMmsUrl(mmsUrl);
		}
		jobPolicDAO.save(policEntity);
	}
	
	/**
	 * 
	* 方法用途和描述: 设置保存值
	* @author chenliang 新增日期：2013-6-27
	* @param polic 传入值对象
	* @param entity 传入值时间对象
	* @param policEntity 传出值保存对象
	* @since mms-cms
	 */
	private void setValue(TbPolic polic ,PolicEntity entity,TbPolic policEntity){
		try {
			policEntity.setContent(polic.getContent()); //短信内容
			policEntity.setCreateTime(new Date()); //创建时间
			policEntity.setCreator(polic.getCreator()); //创建者
			policEntity.setFaildNum(0);  //失败数，默认为0
			policEntity.setLastSendTime(null); //最后发送时间
			TbMdnType mdnType = new TbMdnType(); 
			mdnType.setId(polic.getMdnType().getId());
			policEntity.setMdnType(mdnType);  //号码类型
			policEntity.setMsgType(polic.getMsgType()); //mms类型
			policEntity.setPolicName(polic.getPolicName()); //策略名称
			policEntity.setRemark(polic.getRemark()); //备注
			policEntity.setStauts(SharePublicContants.JOB_STATUES_STOP); //状态
			policEntity.setRunStauts(SharePublicContants.JOB_NOTRUN);
			policEntity.setSuccesNum(0); //成功数
			//设置开始发送时间
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

			String st = entity.getStartSendDate()+" "+entity.getStartTime();
			Date startSendTime = sdf.parse(st);
			policEntity.setStartSendTime(startSendTime);
			
			//设置结束发送时间
			String et = entity.getEndSendDate()+" "+entity.getEndTime();
			Date endSendTime = sdf.parse(et);
			policEntity.setEndSendTime(endSendTime);
			
			//根据号码类型查询该类型的所有数量
			String hql = "select count(*) from TbPushMdn pm where pm.mdnType.id = ?";
			int totalnum = pushMdnDAO.findTotalCount(hql, policEntity.getMdnType().getId());
			policEntity.setTotalNum(totalnum);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 启动或停止
	 */
	@Override
	public void startOrStop(String id,int state) {
		Integer pkid = 0;
		if(!BlankUtil.isBlank(id)){
			pkid = Integer.parseInt(id);
		}
		String  hql = "update TbPolic tb set tb.stauts = ? where tb.id = ? ";
		jobPolicDAO.executeByHQL(hql, state,pkid);
	}

	@Override
	public void updateJobPolic(TbPolic model, PolicEntity policEntity) {
		try {
			//根据主键id查询
			TbPolic policModel = jobPolicDAO.findById(model.getId());
			//设置内容
			policModel.setContent(model.getContent());
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			//设置开始发送时间
			String st = policEntity.getStartSendDate()+" "+policEntity.getStartTime();
			Date startSendTime = sdf.parse(st);
			policModel.setStartSendTime(startSendTime);
			
			//设置结束发送时间
			String et = policEntity.getEndSendDate()+" "+policEntity.getEndTime();
			Date endSendTime = sdf.parse(et);
			policModel.setEndSendTime(endSendTime);
			
			//设置推送号码类型
			TbMdnType mdnType = new TbMdnType();
			mdnType.setId(model.getMdnType().getId());
			policModel.setMdnType(mdnType);
			//msg类型
			policModel.setMsgType(model.getMsgType());
			//备注
			policModel.setRemark(model.getRemark());
			//设置策略名称
			policModel.setPolicName(model.getPolicName());
			
			jobPolicDAO.merge(policModel);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}