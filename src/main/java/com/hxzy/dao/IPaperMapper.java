package com.hxzy.dao;

import com.hxzy.bean.Option;
import com.hxzy.bean.Paper;
import com.hxzy.bean.Question;

import java.util.List;
import java.util.Map;

public interface IPaperMapper {
	//添加试卷信息数据
	public int add(Paper paper);
	//查询问题
	public List<Question> getListByMap(Map<String, Object> map);
	//根据qid查询选项
	public List<Option> getListById(String qid);

}
