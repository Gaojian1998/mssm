package com.hxzy.service.impl;

import com.hxzy.bean.User;
import com.hxzy.dao.IUserMapper;
import com.hxzy.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
@Service
public class UserServiceImpl implements IUserService{
	@Autowired
	private IUserMapper userMapper;
	//
	public List<User> query(Map<String,Object> map){
		List<User> list=userMapper.query(map);
		return list;
	}
	//
	@Override
	public int count(Map<String,Object> map) {
		int connt=userMapper.count(map);
		return connt;
	}
	@Override
	public int add(Map<String, Object> map) {
		if(map.get("id")!=null && !"".equals(map.get("id"))){
			int k=userMapper.modify(map);
			return k;
		}else{
			int k=userMapper.add(map);
			return k;
		}
	}
	@Override
	public int del(String id) {
		int del=userMapper.del(id);
		return del;
	}
	@Override
	public int delMore(String ids) {
		/*Map<String, Object> map=new HashMap<String,Object>();
		map.put("ids", ids);*/
		int delMore=userMapper.delMore(ids);
		return delMore;
	}
	@Override
	public User getObjById(String id) {
		User getObjById =userMapper.getObjById(id);
		return getObjById;
	}
}
