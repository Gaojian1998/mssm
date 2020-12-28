package com.hxzy.dao;

import com.hxzy.bean.Option;
import com.hxzy.bean.Question;
import com.hxzy.bean.Type;

import java.util.List;
import java.util.Map;

public interface IGeneraPaperMapper {
    
	//查询下拉框
	public List<Type>togetQueryBytid(String tid);
	//随机抽取题目
	public List<Question>randomSelTop(Map<String, Object> map);
	//查询题目的答案
	public List<Option> getQueryOption(int qid);
}
