package com.hxzy.dao;

import com.hxzy.bean.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface IUserMapper {
	/**
	 * 查询数据拼表格
	 * @return
	 */
	public List<User> query(Map<String, Object> map);
	/**
	 * 查询总计录数
	 * @param map
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
	public int delMore(@Param(value = "ids") String ids);
	/**
	 * 修改
	 * @param map
	 * @return
	 */
	public int modify(Map<String, Object> map);
	/**
	 * 查询单条
	 * @param id
	 * @return
	 */
	public User getObjById(String id);
}
