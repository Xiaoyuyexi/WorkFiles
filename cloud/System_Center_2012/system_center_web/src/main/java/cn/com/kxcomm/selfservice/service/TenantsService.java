package cn.com.kxcomm.selfservice.service;

import cn.com.kxcomm.entity.TenantsEntity;

/**
 * 
* 功能描述:租户业务接口
* @author chenliang 新增日期：2013-9-9
* @since system_center_web
 */
public interface TenantsService {

	/**
	 * 
	* 方法用途和描述: 登陆
	* @author chenliang 新增日期：2013-9-10
	* @since system_center_web
	 */
	public boolean searchLogin(TenantsEntity entity);
	
}
