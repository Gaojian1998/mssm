package com.hxzy.service.impl;

import com.hxzy.bean.Menu;
import com.hxzy.dao.IMainMapper;
import com.hxzy.service.IMainServcie;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MainServcieImpl implements IMainServcie,InitializingBean{
    @Autowired
	private IMainMapper mainMapper;
	
	@Override
	public List<Menu> getMenuByPid(String pid) {
		//一级菜单
		List<Menu> list=mainMapper.getMenuByPid(pid);
		if(list!=null && list.size()>0){
			//二级菜单
			for(Menu menu:list){
				//递归
				List<Menu> chlidlist= getMenuByPid(menu.getId());
				menu.setChildren(chlidlist);
			}
		}
		return list;
	}
    //题型分析
	@Override
	public List<Map<String, Object>> questionTypeAnaly() {
		List<Map<String,Object>> list=mainMapper.questionTypeAnaly();
		return list;
	}
	@Override
	public List<Map<String, Object>> scoresTop10() {
		List<Map<String,Object>> list=mainMapper.scoresTop10();
		return list;
	}
	/**
	 * 定时更新过期的试卷，设置状态为0 （无效）
	 */
	@Scheduled(cron="0 0 0/1 * * ? ")
	public void upStatusByScheduled() {
		 int k=mainMapper.upStatusByScheduled();
		 System.out.println("更新了"+k+"条");
	}

	@Override
	public List<Map<String, Object>> seltCoursesNum() {
		List<Map<String, Object>> listCoursesNum= mainMapper.seltCoursesNum();
		return listCoursesNum;
	}


	@Override
	public void afterPropertiesSet() throws Exception {

	}
}
