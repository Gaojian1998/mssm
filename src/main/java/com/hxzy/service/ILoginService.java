package com.hxzy.service;

import com.hxzy.bean.User;

/**
 * 登录的服务
 * @author tiantian
 *
 */

public interface ILoginService {
	/**
	 * 检验用户登录信息是否正确
	 * @param user
	 * @return
	 */
	public User checkLogin(User user) ;
    
}
