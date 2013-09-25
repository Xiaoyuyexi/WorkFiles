package cn.com.kxcomm.woyun.web.action;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import org.apache.struts2.ServletActionContext;

import cn.com.kxcomm.common.util.BlankUtil;
import cn.com.kxcomm.common.util.Page;
import cn.com.kxcomm.woyun.service.CommonService;
import cn.com.kxcomm.woyun.vo.NowUseTentidVo;
import cn.com.kxcomm.woyun.web.util.SessionUtils;
import cn.com.woyun.keystone.model.Access;

import com.googlecode.jsonplugin.annotations.JSON;
import com.opensymphony.xwork2.ActionSupport;
/**
 * 
 * 功能描述:Action基类,所有的业务Action类应继承该基类
 * <p>
 * 版权所有：康讯通讯
 * <p>
 * 未经本公司许可，不得以任何方式复制或使用本程序任何部分
 * 
 * @author dengcd 新增日期：2012-11-26
 * @author 你的姓名 修改日期：2012-11-26
 * @since wapportal_manager version(2.0)
 */
@SuppressWarnings("unchecked")
public abstract class BaseAction<T,PK extends Serializable> extends ActionSupport {

	protected  static final Logger log = Logger.getLogger(BaseAction.class);

	/**
	 * 说明清楚此属性的业务含义
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 总记录数
	 */
	public final String TOTAL_ROWS = "totalRows";

	/**
	 * 查询全部
	 */
	public static final String LIST = "list";

	public boolean success;
	public String msg;
	/**
	 * 分页对象
	 */
	protected Page<T> pageList;
	/**
	 * 实体对象,用于显示和接收数据
	 */
	protected T model;
	/**
	 * 主键ID列表
	 */
	protected PK[] ids;
	/**
	 * 数据列表.用户查询列表数据用.如:combobox需要的数据.
	 */
	protected List<T> list;
	
	public boolean isSuccess() {
		return success;
	}


	public void setSuccess(boolean success) {
		this.success = success;
	}


	public String getMsg() {
		return msg;
	}


	public void setMsg(String msg) {
		this.msg = msg;
	}

	public List<T> getList() {
		return list;
	}


	public void setList(List<T> list) {
		this.list = list;
	}

	public Page<T> getPageList() {
		return pageList;
	}


	public void setPageList(Page<T> pageList) {
		this.pageList = pageList;
	}


	/**
	 * 从request中取分页信息
	 * 
	 * @return
	 */
	protected Page<T> getPageInfo() {
		return new Page(ServletActionContext.getRequest());
	}

	/*************************************
	 *  fast return methods
	 ***********************************/

	/**
	 * 
	 * 设置success和msg属性并返回成功
	 * 
	 * @author chenxinwei 新增日期：2012-3-4
	 * @return
	 */
	@JSON(serialize = false)
	public String setAndReturnSuccess() {
		this.success = true;
		this.msg = "操作成功";
		return SUCCESS;
	}
	/**
	 * 设置并返回信息,如:{success:true,msg:"成功"}
	 * @param success
	 * @param msg 
	 */
	public String info(boolean success,String msg){
		this.success = success;
		this.msg = msg;
		return SUCCESS;
	}

	/**
	 * 设置并返回成功信息,如:{success:true,msg:"操作成功"}
	 * @param msg 为null时.返回默认值"操作成功"  
	 */
	public String successInfo(String msg){
		this.success = true;		
		this.msg = msg==null ? "操作成功" : msg;
		return SUCCESS;
	}

	/**
	 * 设置并返回失败信息,如:{success:false,msg:"操作失败"}
	 * @param msg 为null时.返回默认值"操作失败"  
	 */
	public String failInfo(String msg){
		this.success = false;		
		this.msg = msg==null ? "操作失败" : msg;
		return SUCCESS;
	}

	/**
	 * 
	 * 方法用途和描述: 从object数组的list中获取第一个元素
	 * @param sourceList
	 * @return
	 * @author chuzq 新增日期：2008-11-24
	 * @author 你的姓名 修改日期：2008-11-24
	 * @since wapportal_manager version(2.0)
	 */
	public List getFirstElementOfList(List<Object[]> sourceList) {

		List result = new ArrayList();
		if (sourceList == null || sourceList.size() == 0)
			return result;
		for (Object[] objArr : sourceList) {
			result.add(objArr[0]);
		}
		return result;

	}

	/*************************************
	 *  abstract methods
	 ***********************************/

	/**
	 * 返回绑定实体的相关Service
	 * 
	 * @return
	 */
	public abstract CommonService getCommonService();

	/**
	 * 在子类中具体化,这样struts组装时,类型才能正确!!<br>
	 * <p style='color:red'>注意:该方法不要返回空对象</p>.如参考如下示例写法:
	 * <pre>
		if(this.model==null){
			this.model = new CmsRight();
		}
		return this.model;
	 * </pre>
	 * @return
	 */
	public abstract T getModel();

	/**
	 * 在子类中具体化,这样struts组装时,类型才能正确!!
	 * @param model
	 */
	public abstract void setModel(T model);

	/**
	 * 在子类中具体化,这样struts组装时,类型才能正确!!
	 * @return
	 */
	public abstract PK[] getIds();

	/**
	 * 在子类中具体化,这样struts组装时,类型才能正确!!
	 * @param ids
	 */
	public abstract void setIds(PK[] ids);

	

	/**
	 * 获取HttpRequest对象
	 * 
	 * @return
	 */
	public static HttpServletRequest getHttpRequest() {
		HttpServletRequest request = ServletActionContext.getRequest();
		return request;
	}

	private final String getClientAddress(HttpServletRequest request) {    

		String address = request.getHeader("X-Forwarded-For");    

		if (address != null ) {    

			return address;    

		}    

		return request.getRemoteAddr();    

	}   

	/**
	 * 获取HttpSession对象
	 * 
	 * @return
	 */
	public static HttpSession getHttpSession() {
		HttpSession session=ServletActionContext.getRequest().getSession();
		return session;
	}

	/**
	 * 获取HttpServletResponse对象
	 * 
	 * @return
	 */
	public static HttpServletResponse getHttpResponse() {
		HttpServletResponse response = ServletActionContext.getResponse();
		return response;
	}
	
	/**
	 * 
	* 方法用途和描述: 获取登陆之后当前租户的Access
	* @return
	* @author chenliang 新增日期：2012-11-27
	* @since WoYun_Web
	 */
	public Access getAccess(){
		NowUseTentidVo nowUser = (NowUseTentidVo) getHttpSession().getAttribute(SessionUtils.NOW_USER);
		if(!BlankUtil.isBlank(nowUser)){
			return nowUser.getAccess();
		}
		return null;
	}
}
