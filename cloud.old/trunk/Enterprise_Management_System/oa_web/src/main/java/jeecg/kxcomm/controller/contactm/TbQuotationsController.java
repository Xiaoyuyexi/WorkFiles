package jeecg.kxcomm.controller.contactm;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.hibernate.qbc.HqlQuery;
import org.jeecgframework.core.common.hibernate.qbc.PageList;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import jeecg.system.service.SystemService;
import org.jeecgframework.core.util.MyBeanUtils;

import jeecg.kxcomm.entity.contactm.TbConfigModelsEntity;
import jeecg.kxcomm.entity.contactm.TbOrderDetailEntity;
import jeecg.kxcomm.entity.contactm.TbQuotationsEntity;
import jeecg.kxcomm.entity.systemmanager.TbProductTypeEntity;
import jeecg.kxcomm.service.contactm.TbQuotationsServiceI;
import jeecg.kxcomm.util.ExportQuotations;
import jeecg.kxcomm.util.PathConstants;
import jeecg.kxcomm.vo.systemmanager.DataBean;
import jeecg.kxcomm.vo.systemmanager.TbDataRecordVo;

/**   
 * @Title: Controller
 * @Description: 报价表
 * @author zhangdaihao
 * @date 2013-10-23 09:56:47
 * @version V1.0   
 *
 */
@Controller
@RequestMapping("/tbQuotationsController")
public class TbQuotationsController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(TbQuotationsController.class);

	@Autowired
	private TbQuotationsServiceI tbQuotationsService;
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
	 * 报价表列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "tbQuotations")
	public ModelAndView tbQuotations(HttpServletRequest request) {
		return new ModelAndView("jeecg/kxcomm/contactm/tbQuotationsList");
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
	public void datagrid(TbQuotationsEntity tbQuotations,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TbQuotationsEntity.class, dataGrid);
		//查询条件组装器
		//org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, tbQuotations);
		//this.tbQuotationsService.getDataGridReturn(cq, true);
		//TagUtil.datagrid(response, dataGrid);
		HqlQuery hqlQuery = new HqlQuery("TbQuotationsEntity.do?datagrid");
		hqlQuery.setCurPage(dataGrid.getPage());
		hqlQuery.setPageSize(dataGrid.getRows());
		hqlQuery.setDataGrid(dataGrid);
		PageList pagelist = this.tbQuotationsService.getPageList(hqlQuery, true,tbQuotations);
		
		dataGrid.setPage(pagelist.getCurPageNO());
		dataGrid.setTotal(pagelist.getCount());
		dataGrid.setReaults(pagelist.getResultList());
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除报价表
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(TbQuotationsEntity tbQuotations, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		tbQuotations = systemService.getEntity(TbQuotationsEntity.class, tbQuotations.getId());
		message = "删除成功";
		tbQuotationsService.delete(tbQuotations);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加报价表
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(TbQuotationsEntity tbQuotations, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(tbQuotations.getId())) {
			message = "更新成功";
			TbQuotationsEntity t = tbQuotationsService.get(TbQuotationsEntity.class, tbQuotations.getId());
			try {
				MyBeanUtils.copyBeanNotNull2Bean(tbQuotations, t);
				tbQuotationsService.saveOrUpdate(t);
				systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			message = "添加成功";
			String fileName = System.currentTimeMillis()+".xlsx";
			tbQuotations.setDownUrl(fileName);
			tbQuotations.setCreateTime(new Date());
			tbQuotationsService.save(tbQuotations);
			
			HttpSession session =  request.getSession();
			session.setAttribute("quotationId", tbQuotations.getId());
			
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		return j;
	}

	/**
	 * 报价表列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(TbQuotationsEntity tbQuotations, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(tbQuotations.getId())) {
			tbQuotations = tbQuotationsService.getEntity(TbQuotationsEntity.class, tbQuotations.getId());
			req.setAttribute("tbQuotationsPage", tbQuotations);
		}
		return new ModelAndView("jeecg/kxcomm/contactm/tbQuotations");
	}
	
	@RequestMapping(params = "check")
	public ModelAndView check(HttpServletRequest req) {
		String id = req.getParameter("id");
		req.setAttribute("quotation", id);
//		String hql0 = "from TbConfigModelsEntity where 1 = 1 AND tbQuotations.id = ? ";
//	    List<TbConfigModelsEntity> tbConfigModelsList = systemService.findHql(hql0,id);
//		req.setAttribute("volist", tbConfigModelsList);
		return new ModelAndView("jeecg/kxcomm/contactm/tbConfigModelsList");
	}
	
	@RequestMapping(params = "download")
	@ResponseBody
	public String download(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		TbQuotationsEntity tbQuotations = systemService.getEntity(TbQuotationsEntity.class, id);
		String hql = "from TbConfigModelsEntity where tbQuotations = ? ";
		List<TbConfigModelsEntity> configModelsList = systemService.findHql(hql, tbQuotations);
		
		List<List<TbDataRecordVo>> dataRecordList = tbQuotationsService.listConfigModelData(configModelsList);
			
		try {
			ExportQuotations ex = new ExportQuotations();
			
			String templatesDoc =  PathConstants.CurrentDirectory+"/templatesDoc/quotations_templates.xlsx";
			System.out.println("***************templatesDoc:"+templatesDoc);
			
			String exportDoc =PathConstants.CurrentDirectory+PathConstants.ExportQuotations+tbQuotations.getDownUrl();
			System.out.println("***************exportDoc:"+exportDoc);
			
			List<TbProductTypeEntity> productType = systemService.getList(TbProductTypeEntity.class);
			ex.export(templatesDoc, exportDoc, dataRecordList,productType);
			
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String urlPath = PathConstants.ExportQuotations;
		String fileName = tbQuotations.getDownUrl();
	    return PathConstants.basePath+urlPath+fileName;
	}
}