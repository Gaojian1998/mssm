package com.hxzy.service.impl;

import com.hxzy.bean.Option;
import com.hxzy.bean.Question;
import com.hxzy.bean.Type;
import com.hxzy.dao.IGeneraPaperMapper;
import com.hxzy.service.IGeneraPaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class GeneraPaperServiceImpl implements IGeneraPaperService{
	
    @Autowired
	IGeneraPaperMapper generaPaperMapper;
	
	@Override
	public List<Type> togetQueryBytid(String tid) {
		List<Type> listType= generaPaperMapper.togetQueryBytid(tid);
		return listType;
	}

	@Override
	public List<Question> randomSelTop(Map<String, Object> map) {
		List<Question> listQuestion=generaPaperMapper.randomSelTop(map);
		for(Question question:listQuestion){
			List<Option> listOption= generaPaperMapper.getQueryOption(question.getId());
			question.setOptions(listOption);
		}
		return listQuestion;
	}

}
