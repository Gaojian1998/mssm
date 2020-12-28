package com.hxzy.service;

import com.hxzy.bean.Question;
import com.hxzy.bean.Type;

import java.util.List;
import java.util.Map;

public interface IGeneraPaperService {
	//查询下拉框
	public List<Type>togetQueryBytid(String tid);
	//随机抽取题目
    public List<Question>randomSelTop(Map<String, Object> map);
}
