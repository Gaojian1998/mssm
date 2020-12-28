package com.hxzy.service;

import com.hxzy.bean.Option;
import com.hxzy.bean.Question;

public interface IAddQuestService {
	//插入数据
	public int insertQuestion(Question question);
	//增加选项
	public int addchoose(Option option);
}
