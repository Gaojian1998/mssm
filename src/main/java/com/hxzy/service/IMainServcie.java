package com.hxzy.service;

import com.hxzy.bean.Menu;

import java.util.List;
import java.util.Map;

public interface IMainServcie {
	
	public List<Menu> getMenuByPid(String pid);
	public List<Map<String,Object>> questionTypeAnaly();
	public List<Map<String,Object>> scoresTop10();
	public List<Map<String,Object>> seltCoursesNum();
	public void upStatusByScheduled();
	

}
