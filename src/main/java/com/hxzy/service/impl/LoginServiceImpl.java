package com.hxzy.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hxzy.bean.User;
import com.hxzy.dao.ILoginMapper;
import com.hxzy.service.ILoginService;
@Service
public class LoginServiceImpl implements ILoginService{
	@Autowired
    private ILoginMapper loginMapper;
	@Override
	public User checkLogin(User user) {
		User u=loginMapper.checkLogin(user);
		return u;
	}
    
}
