package cn.com.mmsweb.action.web;

import java.rmi.RemoteException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.xml.rpc.ServiceException;


import org.apache.log4j.Logger;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;

import cn.com.common.Response;
import cn.com.mmsweb.action.util.SessionUtils;
import cn.com.mmsweb.service.CommonService;
import cn.com.mmsweb.service.ContactService;
import cn.com.mmsweb.service.GroupContactsService;
import cn.com.mmsweb.service.GroupsService;
import cn.com.mmsweb.vo.ContractsVo;
import cn.com.mmsweb.vo.GroupContactsVo;
import cn.com.mmsweb.vo.GroupsVo;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.unicom.mms.entity.TbCollect;
import com.unicom.mms.entity.TbContacts;
import com.unicom.mms.entity.TbGroupContacts;
import com.unicom.mms.entity.TbGroups;
import com.unicom.mms.entity.TbTemplateCard;
import com.unicom.mms.entity.TbUsers;
import com.unicom.mms.mcp.webservice.Mcp;
import com.unicom.mms.mcp.webservice.McpServiceLocator;

/**
 * @author Lu
 *
 */
/**
 * @author Lu
 *
 */
public class ContactAction extends BaseAction<TbContacts, String>{
	private static Logger log = Logger.getLogger(ContactAction.class);
	@Autowired(required = true)
	private ContactService contactService;
	@Autowired(required = true)
	private  GroupsService groupsService;
	private int pageNow=1;
	private int pageSize=10;
	private List<GroupContactsVo> listContacts;
	private int maxPage;   //最大页数
	private GroupContactsVo groupContactsVo;
	private List<TbGroups> listGroups;
	private String id;
	private String groupsId;
	private String groupName;
	private GroupContactsService groupContactsService;
  private List<ContractsVo> groupList;
  
  


	public List<ContractsVo> getGroupList() {
	return groupList;
}

public void setGroupList(List<ContractsVo> groupList) {
	this.groupList = groupList;
}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getGroupsId() {
		return groupsId;
	}

	public void setGroupsId(String groupsId) {
		this.groupsId = groupsId;
	}

	public GroupsService getGroupsService() {
		return groupsService;
	}

	public void setGroupsService(GroupsService groupsService) {
		this.groupsService = groupsService;
	}

	public int getPageNow() {
		return pageNow;
	}

	public void setPageNow(int pageNow) {
		this.pageNow = pageNow;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public List<GroupContactsVo> getListContacts() {
		return listContacts;
	}

	public void setListContacts(List<GroupContactsVo> listContacts) {
		this.listContacts = listContacts;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public List<TbGroups> getListGroups() {
		return listGroups;
	}

	public void setListGroups(List<TbGroups> listGroups) {
		this.listGroups = listGroups;
	}

	public ContactService getContactService() {
		return contactService;
	}

	public void setContactService(ContactService contactService) {
		this.contactService = contactService;
	}

	public GroupContactsVo getGroupContactsVo() {
		return groupContactsVo;
	}

	public void setGroupContactsVo(GroupContactsVo groupContactsVo) {
		this.groupContactsVo = groupContactsVo;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String findContactById()
	{
		groupContactsVo=contactService.findContactById(model.getId());
		
		return successInfo("ok");
	}
	
	  /*
     * 分页查询我的联系人
     */
	 public String listContract()
	 {
		 HttpSession session = getHttpSession();
		 TbUsers users = (TbUsers) session.getAttribute(SessionUtils.USER);
		 if(groupsId==null)
		 {
			 this.listContacts=contactService.queryByPage(pageSize, pageNow,null,users.getId());
			 maxPage=contactService.maxPage(pageSize, pageNow,null,users.getId());
		 }else {
			 this.listContacts=contactService.queryByPage(pageSize, pageNow,groupsId,users.getId());
			  groupName=groupsService.groupsName(groupsId);
			 maxPage=contactService.maxPage(pageSize, pageNow,groupsId,users.getId());
		}
		 listGroups=groupsService.findAll();
		 return SUCCESS;
	 }
	 
	  /*
	     * 删除
	     */
	public String deleteById()
		{	
		 HttpSession session = getHttpSession();
		 TbUsers users = (TbUsers) session.getAttribute(SessionUtils.USER);
		try {
			List<TbContacts> list=new ArrayList<TbContacts>();
			TbContacts contacts=new TbContacts();
			Mcp mcp = new McpServiceLocator().getMcpPort();
			Gson gson = new Gson();
			String[] ids = id.split(",");
			 String res= "";
			for (String strId : ids) {
				if(null!=strId)
				{
					String arr[] = strId.split("_");
					
					contacts=contactService.getByPk(Integer.parseInt(arr[0]));
					TbContacts contacts2=new TbContacts();
                     contacts2.setId(Integer.parseInt(arr[0]));
                     contacts2.setBirthday(contacts.getBirthday());
                     contacts2.setEmail(contacts.getEmail());
                     contacts2.setMdn(contacts.getMdn());
                     contacts2.setName(contacts.getName());
                     TbUsers user=new TbUsers();
                     user.setId(contacts.getUsers().getId());
                     contacts2.setUsers(user);
                     String jsonStr = gson.toJson(contacts2);
                     System.out.println(arr[1]+" "+users.getMdn());
                      res= mcp.contactManage(jsonStr, arr[1].equals("0")?0:Integer.parseInt(arr[1]), 2, "web", users.getMdn());
				}
			}
			  Response response =  gson.fromJson(res,   
		                new TypeToken<Response>() {   
		            }.getType());  
			  if(response.getResultCode()==0)
			  {
				  return successInfo("ok");
			  }else {
				return successInfo("error");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
		}
	
	/**
	 * 
	* 方法用途和描述:添加联系人
	* @return
	* @author lujia 新增日期：2013-2-22
	* @since ContractManage
	 */
	public String addContact()
	{
		String msg="";
		HttpSession session = getHttpSession();
		 TbUsers users = (TbUsers) session.getAttribute(SessionUtils.USER);
		TbContacts contacts=new TbContacts();
		try {
			Mcp mcp = new McpServiceLocator().getMcpPort();
			Gson gson = new Gson();
			 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
			try {
				if(groupContactsVo.getBirthday()==null || groupContactsVo.getBirthday().equals(""))
				{
					contacts.setBirthday(null);	
				}else {
					contacts.setBirthday(sdf.parse(groupContactsVo.getBirthday()));
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			contacts.setEmail(groupContactsVo.getEmail());
			contacts.setMdn(groupContactsVo.getMsn());
			contacts.setName(groupContactsVo.getContactsName());
			
			TbUsers users1 = new TbUsers();
			users1.setMdn(users.getMdn());
			users1.setId(users.getId());
			contacts.setUsers(users1);
			String jsonStr = gson.toJson(contacts);		
		try {
			 String res= mcp.contactManage(jsonStr, Integer.parseInt(groupContactsVo.getGroupsId()),1, "web", users1.getMdn());
			  Response response =  gson.fromJson(res,   
		                new TypeToken<Response>() {   
		            }.getType());  
			  if(response.getResultCode()==0)
			  {
				  msg="ok";
			//	  return successInfo(msg);
			  }else {
				  msg="error";
		//		return successInfo(msg);
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return successInfo(msg);
	}
	
    /**
	    * 
	   * 方法用途和描述: 修改联系人信息
	   */
	public String updateContact() 
	{
		HttpSession session = getHttpSession();
		 TbUsers users = (TbUsers) session.getAttribute(SessionUtils.USER);
		List<TbContacts> list=new ArrayList<TbContacts>();
		TbContacts contacts=new TbContacts();
		try {
			Mcp mcp = new McpServiceLocator().getMcpPort();
			Gson gson = new Gson();
			int id=Integer.parseInt(groupContactsVo.getContactsId());
		  contacts.setId(id);
		  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
			try {
				if(groupContactsVo.getBirthday()==null || groupContactsVo.getBirthday().equals(""))
				{
					contacts.setBirthday(null);	
				}else {
				contacts.setBirthday(sdf.parse(groupContactsVo.getBirthday()));
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			contacts.setEmail(groupContactsVo.getEmail());
			contacts.setMdn(groupContactsVo.getMsn());
			contacts.setName(groupContactsVo.getContactsName());
			TbUsers users1 = new TbUsers();
			users1.setMdn(users.getMdn());
			users1.setId(users.getId());
			contacts.setUsers(users1);
			String jsonStr = gson.toJson(contacts);	
				 String res = mcp.contactManage(jsonStr, groupsId==null?0:Integer.parseInt(groupContactsVo.getGroupsId()), 1, "web", users.getMdn());
				 Response response =  gson.fromJson(res,   
			                new TypeToken<Response>() {   
			            }.getType());  
				  if(response.getResultCode()==0)
				  {
					  return successInfo("ok");
				  }else {
					return successInfo("error");
				}
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
			 
		return successInfo("ok");
	}
    /**
	    * 
	   * 方法用途和描述: 添加联系人分组
	   */
	public String addGroup() 
	{
		HttpSession session = getHttpSession();
		 TbUsers users = (TbUsers) session.getAttribute(SessionUtils.USER);
		List<TbContacts> list=new ArrayList<TbContacts>();
		TbContacts contacts=new TbContacts();
		try {
			Mcp	mcp = new McpServiceLocator().getMcpPort();
			Gson gson = new Gson();
			String[] ids = id.split(",");
			for (String strId : ids) {
				if(null!=strId)
				{
					Integer id = 0;
				if(strId.equals("")||strId==null){
					id = 0;
				}else{
					id = Integer.parseInt(strId);
				}
				contacts=contactService.getByPk(id);
				if(contacts!=null){
					TbContacts contacts2=new TbContacts();
		            contacts2.setId(contacts.getId());
		            contacts2.setBirthday(contacts.getBirthday());
		            contacts2.setEmail(contacts.getEmail());
		            contacts2.setMdn(contacts.getMdn());
		            contacts2.setName(contacts.getName());
		            TbUsers user=new TbUsers();
		            user.setId(contacts.getUsers().getId());
				    list.add(contacts2);
				}
			}
			}
			String contactList = gson.toJson(list);	
			TbGroups groups=new TbGroups();
			groups.setName(groupName);
			TbUsers user=new TbUsers();
			user.setId(users.getId());
			groups.setUsers(user);
			String groupsList = gson.toJson(groups);	
			try {
				String res= mcp.groupManage(groupsList, contactList, 1, "web", users.getMdn());
				 Response response =  gson.fromJson(res,   
			                new TypeToken<Response>() {   
			            }.getType());  
				  if(response.getResultCode()==0)
				  {
					  return successInfo("ok");
				  }else {
					return successInfo("error");
				}
			} catch (RemoteException e) {
				e.printStackTrace();
			}
		} catch (ServiceException e1) {
			e1.printStackTrace();
		}
		return successInfo("ok");
	}
/*
 * 修改分组
 */
	public String updateGroup()
	{
		HttpSession session = getHttpSession();
		 TbUsers users = (TbUsers) session.getAttribute(SessionUtils.USER);
		List<TbContacts> list=new ArrayList<TbContacts>();
		TbContacts contacts=new TbContacts();
		List<TbGroupContacts> list2=contactService.getContactsByGroupId(groupsId);
		try {
			Mcp	mcp = new McpServiceLocator().getMcpPort();
			Gson gson = new Gson();
			String[] ids = id.split(",");
			for (String strId : ids) {
				if(null!=strId)
				{
					int id = 0;
				if(strId.equals("")||strId==null){
					id = 0;
				}else{
					id = Integer.parseInt(strId);
				}
				boolean flat = true;
				for(TbGroupContacts groupContacts:list2)
				{
				  int contactId=groupContacts.getContacts().getId();
				  if(id==contactId) {
					  flat = false;
					  break;
				  }
				}
				if(flat){
					contacts=contactService.getByPk(id);
					if(contacts!=null){
						TbContacts contacts2=new TbContacts();
			            contacts2.setId(contacts.getId());
			            contacts2.setBirthday(contacts.getBirthday());
			            contacts2.setEmail(contacts.getEmail());
			            contacts2.setMdn(contacts.getMdn());
			            contacts2.setName(contacts.getName());
			            TbUsers user=new TbUsers();
			            user.setId(contacts.getUsers().getId());
					    list.add(contacts2);
					}
				}
			}
			}
			String contactList = gson.toJson(list);	
			Integer gid=0;
			if(groupsId!=null)
			{
				gid=Integer.parseInt(groupsId);
			}
			TbGroups groups=new TbGroups(); //groupsService.getByPk(gid);
			groups.setId(gid);
			groups.setName(groupName);
			TbUsers user=new TbUsers();
			user.setId(users.getId());
			groups.setUsers(user);
			String groupsList = gson.toJson(groups);	
			try {
				String res= mcp.groupManage(groupsList, contactList, 1, "web", users.getMdn());
				 Response response =  gson.fromJson(res,   
			                new TypeToken<Response>() {   
			            }.getType());  
				  if(response.getResultCode()==0)
				  {
					  return successInfo("ok");
				  }else {
					return successInfo("error");
				}
			} catch (RemoteException e) {
				e.printStackTrace();
			}
		} catch (ServiceException e1) {
			e1.printStackTrace();
		}
		return successInfo("ok");
	}
	
	/*
	 * 删除组
	 */
	public String delGroups()
	{
		HttpSession session = getHttpSession();
		 TbUsers users = (TbUsers) session.getAttribute(SessionUtils.USER);
		List<TbContacts> list=new ArrayList<TbContacts>();
		TbContacts contacts=new TbContacts();
		try {
			Mcp	mcp = new McpServiceLocator().getMcpPort();
			Gson gson = new Gson();
			String[] ids = id.split(",");
			for (String strId : ids) {
				if(null!=strId)
				{
					Integer id = 0;
				if(strId.equals("")||strId==null){
					id = 0;
				}else{
					id = Integer.parseInt(strId);
				}
				contacts=contactService.getByPk(id);
				if(contacts!=null){
					TbContacts contacts2=new TbContacts();
		            contacts2.setId(contacts.getId());
		            contacts2.setBirthday(contacts.getBirthday());
		            contacts2.setEmail(contacts.getEmail());
		            contacts2.setMdn(contacts.getMdn());
		            contacts2.setName(contacts.getName());
		            TbUsers user=new TbUsers();
		            user.setId(contacts.getUsers().getId());
				    list.add(contacts2);
				}
			}
			}
			String contactList = gson.toJson(list);	
			Integer gid=0;
			if(groupsId!=null)
			{
				gid=Integer.parseInt(groupsId);
			}
			TbGroups groups=groupsService.getByPk(gid);
			TbUsers user=new TbUsers();
			user.setId(users.getId());
			groups.setUsers(user);
			String groupsList = gson.toJson(groups);	
			try {
				String res= mcp.groupManage(groupsList, null, 2, "web", users.getMdn());
				 Response response =  gson.fromJson(res,   
			                new TypeToken<Response>() {   
			            }.getType());  
				  if(response.getResultCode()==0)
				  {
					  return successInfo("ok");
				  }else {
					return successInfo("error");
				}
			} catch (RemoteException e) {
				e.printStackTrace();
			}
		} catch (ServiceException e1) {
			e1.printStackTrace();
		}
		return successInfo("ok");
	}
	
	/**
	 * 
	* 方法用途和描述: 查询没有分组的联系人
	* @return
	* @since mms-web
	 */
	public String getContactsByNotGroups()
	{
		groupList=this.contactService.getContactsByNotGroups();
		log.debug("list:"+groupList);
		return successInfo("ok");
	}
	@Override
	public CommonService getCommonService() {
		return contactService;
	}

	@Override
	public TbContacts getModel() {
		if(null==this.model){
			this.model = new TbContacts();
		}
		return this.model;
	}

	@Override
	public void setModel(TbContacts model) {
		this.model = model;
	}

	@Override
	public String[] getIds() {
		return this.ids;
	}

	@Override
	public void setIds(String[] ids) {
		this.ids = ids;
	}

}