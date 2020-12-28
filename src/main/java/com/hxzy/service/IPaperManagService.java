package com.hxzy.service;

import com.hxzy.bean.Paper;
import com.hxzy.bean.Question;

import java.util.List;
import java.util.Map;

public interface IPaperManagService {
	 //查询试卷的总计录数
	  public int allCount();
	 //获取试卷信息
	 public List<Paper> getPaperInfo(Map<String, Object> map);
	 //查询试卷试题
	 public List<Question>getQuestionByPid(String qids);
}
