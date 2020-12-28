package com.hxzy.service;

import com.hxzy.bean.Option;
import com.hxzy.bean.Paper;
import com.hxzy.bean.Question;

import java.util.List;
import java.util.Map;

public interface IPaperService {
	//保存试卷
	public int save(Paper paper);
	//查询题目根据Map
	public List<Question> getListByMap(Map<String, Object> map);
	//根据查询到的题目qid查询选项
	public List<Option> getListById(String qid);

}
