package com.hxzy.service;

import com.hxzy.bean.User;

import java.util.List;
import java.util.Map;

public interface IUserService {
	/**
	 * 
	 * @param map
	 * @return
	 */
	public List<User> query(Map<String, Object> map);
	/**
	 * 查询总记录数
	 * @return
	 */
	public int count(Map<String, Object> map);
	/**
	 * 增加
	 * @param map
	 * @return
	 */
	public int add(Map<String, Object> map);
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	public int del(String id);
	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	public int delMore(String ids);
	/**
	 * 查询单条
	 * @param ids
	 * @return
	 */
	public User getObjById(String ids);
}
