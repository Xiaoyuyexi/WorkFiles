package com.xdd.dao;
import java.util.List;
import com.xdd.po.User;


public interface UserDao {
	//�����û�ʵ�弯��
	public List<User> queryUserList();
	//�������������û�ʵ��
	public User queryUserByCondition(String condition);
}
