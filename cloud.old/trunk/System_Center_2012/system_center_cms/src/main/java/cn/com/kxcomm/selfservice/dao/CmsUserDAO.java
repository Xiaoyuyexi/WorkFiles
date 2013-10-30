package cn.com.kxcomm.selfservice.dao;


import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import cn.com.kxcomm.base.dao.CommonDAO;
import cn.com.kxcomm.selfservice.entity.TbCmsUser;

/**
 *
* 功能描述:登陆用户dao
* @author chenliang 新增日期：2013-1-14
* @since mms-cms-unicom
 */
@Repository
public class CmsUserDAO extends CommonDAO<TbCmsUser>{
	
	private static Logger log = Logger.getLogger(CmsUserDAO.class);

	/**
	 * 登录判断是否有此用户
	 * @return
	 */
	public boolean login(String accouont,String passWord){
		boolean flag = false;
		TbCmsUser tbuser= new TbCmsUser();
		tbuser.setAccouont(accouont);
		tbuser.setPassword(passWord);
		List a = this.findByExample(tbuser);
		if(a.size()>0)flag=true;
		return flag;
	}
	
	public boolean loginHql(String accouont,String passWord){
		boolean flag = false;
        String hql="from TbCmsUser where accouont=? and password=?";
        String[] values=new String[2];
        values[0]=accouont;values[1]=passWord;
        List a=this.find(hql, values);	
		if(a.size()>0)flag=true;
		return flag;
	}
	
	/**
	 * 
	 * 执行hql
	 * @author chenl 新增日期＄1�712-1-22
	 * @param criteria 带查询条件的DetachedCriteria
	 * @param hql  执行的1�7   
	 * @return
	 */
	public List executeHql(String hql,Object ...objects){
		Session  sessionUse = this.getSession();
		SQLQuery sq=sessionUse.createSQLQuery(hql);
		int j=0;
		for (int i = 0; i < objects.length; i++) {
			log.debug("objects["+i+"]"+objects[i]);
			if(null!=objects[i] && !"".equals(objects[i])){
				sq.setParameter(j, objects[j]);
				j++;
			}
		}
		List lista = sq.list();
		return lista;
	}
	
	
}