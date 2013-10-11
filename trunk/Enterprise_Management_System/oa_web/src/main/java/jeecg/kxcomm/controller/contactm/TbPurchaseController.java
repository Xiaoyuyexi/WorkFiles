package jeecg.kxcomm.controller.contactm;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import jeecg.system.pojo.base.TSDepart;
import jeecg.system.pojo.base.TSUser;
import jeecg.system.service.SystemService;
import org.jeecgframework.core.util.MyBeanUtils;

import jeecg.kxcomm.entity.contactm.TbOrderDetailEntity;
import jeecg.kxcomm.entity.contactm.TbOrderEntity;
import jeecg.kxcomm.entity.contactm.TbPurchaseContractEntity;
import jeecg.kxcomm.entity.contactm.TbPurchaseEntity;
import jeecg.kxcomm.entity.hrm.TbCheckingInstanceEntity;
import jeecg.kxcomm.entity.hrm.TbEmployeeEntity;
import jeecg.kxcomm.service.contactm.TbOrderDetailCopyServiceI;
import jeecg.kxcomm.service.contactm.TbPurchaseServiceI;

/**   
 * @Title: Controller
 * @Description: 采购订单
 * @author zhangdaihao
 * @date 2013-09-24 16:46:46
 * @version V1.0   
 *
 */
@Controller
@RequestMapping("/tbPurchaseController")
public class TbPurchaseController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(TbPurchaseController.class);

	@Autowired
	private TbPurchaseServiceI tbPurchaseService;
	private TbOrderDetailCopyServiceI tbOrderDetailService;
	@Autowired
	private SystemService systemService;
	private String message;
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}


	/**
	 * 采购订单列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "tbPurchase")
	public ModelAndView tbPurchase(HttpServletRequest request) {
		String id = request.getParameter("id");
		request.setAttribute("id",id);
		return new ModelAndView("jeecg/kxcomm/contactm/tbPurchaseList");
	}

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@RequestMapping(params = "datagrid")
	public void datagrid(TbPurchaseEntity tbPurchase,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TbPurchaseEntity.class, dataGrid);
		
		String id = request.getParameter("orderDetailId");
		
		cq.createAlias("tbOrderDetail", "tbOrderDetail");	
		cq.eq("tbOrderDetail.id", id);
		cq.add();
		
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, tbPurchase);
		this.tbPurchaseService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除采购订单
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(TbPurchaseEntity tbPurchase, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		tbPurchase = systemService.getEntity(TbPurchaseEntity.class, tbPurchase.getId());
		message = "删除成功";
		tbPurchaseService.delete(tbPurchase);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加采购订单
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(TbPurchaseEntity tbPurchase, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(tbPurchase.getId())) {
			message = "更新成功";
			TbPurchaseEntity t = tbPurchaseService.get(TbPurchaseEntity.class, tbPurchase.getId());
			TbOrderDetailEntity tbOrderDetail = systemService.get(TbOrderDetailEntity.class, t.getTbOrderDetail().getId());
		
			if(t.getTbPurchaseContract()!=null){
				TbPurchaseContractEntity tbPurchaseContract = systemService.get(TbPurchaseContractEntity.class, t.getTbPurchaseContract().getId());
				tbPurchase.setTbPurchaseContract(tbPurchaseContract);
			}else{
				tbPurchase.setTbPurchaseContract(null);
			}
				
			//t.setTbOrderDetail(tbOrderDetail);
			tbPurchase.setTbOrderDetail(tbOrderDetail);
			
			try {
				MyBeanUtils.copyBeanNotNull2Bean(tbPurchase, t);
				
				tbPurchaseService.saveOrUpdate(t);
				systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			String id = request.getParameter("orderDetailId");			
//			
//			TbOrderDetailEntity orderDetailEntity = new TbOrderDetailEntity();
//			orderDetailEntity.setId(id);
			TbOrderDetailEntity t = systemService.getEntity(TbOrderDetailEntity.class, id);				
			
			tbPurchase.setTbOrderDetail(t);
			tbPurchase.setTbPurchaseContract(null);
			//-------------------------------
			message = "添加成功";
			TSUser user= ResourceUtil.getSessionUserName();
			tbPurchase.setPurchaser(user.getRealName());
			tbPurchaseService.save(tbPurchase);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		
		return j;
	}

	/**
	 * 采购订单列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(TbPurchaseEntity tbPurchase, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(tbPurchase.getId())) {
			tbPurchase = tbPurchaseService.getEntity(TbPurchaseEntity.class, tbPurchase.getId());
			
			String id = req.getParameter("id");
			req.setAttribute("id",id);
			
			TSUser user= ResourceUtil.getSessionUserName();
			req.setAttribute("purchaser",user.getRealName());
			req.setAttribute("tbPurchasePage", tbPurchase);
			
		}
		return new ModelAndView("jeecg/kxcomm/contactm/tbPurchase");
	}
	
}
