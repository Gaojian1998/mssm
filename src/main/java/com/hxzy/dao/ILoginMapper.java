package com.hxzy.dao;

import com.hxzy.bean.User;

public interface ILoginMapper {
	/**
	 * 检验用户名和密码是否存在
	 * @param user
	 * @return 返回用户信息
	 */
   public User checkLogin(User user);
}
