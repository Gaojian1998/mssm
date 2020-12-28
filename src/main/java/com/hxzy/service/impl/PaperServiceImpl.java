package com.hxzy.service.impl;

import com.hxzy.bean.Option;
import com.hxzy.bean.Paper;
import com.hxzy.bean.Question;
import com.hxzy.dao.IPaperMapper;
import com.hxzy.service.IPaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class PaperServiceImpl implements IPaperService {

	// 通过类型自动装配
	@Autowired
	private IPaperMapper paperDao;

	// 开启事务
	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {
			Exception.class, RuntimeException.class })
	public int save(Paper paper) {
		int k = paperDao.add(paper);
		return k;
	}

	@Override
	public List<Question> getListByMap(Map<String, Object> map) {
		int qsingle=map.get("qsingle")==null?20:Integer.parseInt((String)map.get("qsingle"));
		if(qsingle>=20 || qsingle<0){
			qsingle=20;
		}
		map.put("qsingle", qsingle);
		int qmultiple=map.get("qmultiple")==null?10:Integer.parseInt((String)map.get("qmultiple"));
		if(qmultiple>=5 || qmultiple<0){
			qmultiple=5;
		}
		map.put("qmultiple", qmultiple);
		int qjudge=map.get("qjudge")==null?20:Integer.parseInt((String)map.get("qjudge"));
		if(qjudge>=10 || qjudge<0){
			qjudge=10;
		}
		map.put("qjudge", qjudge);
		List<Question> question = paperDao.getListByMap(map);
		return question;
	}

	@Override
	public List<Option> getListById(String qid) {
		List<Option> option = paperDao.getListById(qid);
		return option;
	}

}
