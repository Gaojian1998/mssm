package com.hxzy.service.impl;

import com.hxzy.bean.Option;
import com.hxzy.bean.Paper;
import com.hxzy.bean.Question;
import com.hxzy.dao.IPaperManagerMapper;
import com.hxzy.service.IPaperManagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class PaperManagServiceImpl implements IPaperManagService{
    
	@Autowired
	IPaperManagerMapper paperManagerMapper;
	
	@Override
	public int allCount() {
		int allCount= paperManagerMapper.allCount();
		return allCount;
	}

	@Override
	public List<Paper> getPaperInfo(Map<String,Object> map) {
		List<Paper> listpaper= paperManagerMapper.getPaperInfo(map);
		return listpaper;
	}

	@Override
	public List<Question> getQuestionByPid(String qids) {
		List<Question> listquest= paperManagerMapper.getQuestionByPid(qids);
		for(Question question:listquest){
			List<Option> listoption= paperManagerMapper.getOptionByPid(question.getId());
			question.setOptions(listoption);
		}
		return listquest;
	}
	
}
