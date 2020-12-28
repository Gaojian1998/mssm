package com.hxzy.dao;

import com.hxzy.bean.Question;
import com.hxzy.bean.Option;


public interface IAddQuestMapper {

	/**
	 * 增加试卷
	 * @param question
	 * @return
	 */
	public int insertQuestion(Question question);
	/**
	 * 增加选项
	 * @param option
	 * @return
	 */
	public int addchoose(Option option);
}
