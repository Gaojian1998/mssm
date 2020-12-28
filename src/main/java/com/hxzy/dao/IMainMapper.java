package com.hxzy.dao;

import com.hxzy.bean.Menu;

import java.util.List;
import java.util.Map;

public interface IMainMapper {

	public List<Menu> getMenuByPid(String pid);
	public List<Map<String,Object>> questionTypeAnaly();
	public List<Map<String,Object>> scoresTop10();
	public List<Map<String,Object>> seltCoursesNum();
	public int upStatusByScheduled();
	
}
