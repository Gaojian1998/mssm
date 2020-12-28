package com.hxzy.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hxzy.bean.Option;
import com.hxzy.bean.Question;
import com.hxzy.dao.IAddQuestMapper;
import com.hxzy.service.IAddQuestService;

@Service
public class AddQuestServiceImpl implements IAddQuestService{
	
	//自动装配实例化dao层
	@Autowired
	IAddQuestMapper addQuestMapper;

	@Override
	public int insertQuestion(Question question) {
		int k = addQuestMapper.insertQuestion(question);
		return k;
	}
    //增加选项
	@Override
	public int addchoose(Option option) {
		int k = addQuestMapper.addchoose(option);
		return k;
	}

}
