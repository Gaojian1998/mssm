package com.hxzy.service.impl;

import com.hxzy.bean.Paper;
import com.hxzy.bean.Scores;
import com.hxzy.dao.IExamIndexMapper;
import com.hxzy.service.IExamIndexService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ExamIndexServiceImpl implements IExamIndexService{
	@Autowired
	private IExamIndexMapper examIndexMapper;
	/**
	 * 获取考试信息
	 * @param current 用户登录的当前时间
	 * @return 考试信息
	 */
	@Override
	public List<Paper> getExamInfo(String current) {
		List<Paper> papers=examIndexMapper.getExamInfo(current);
		
		return papers;
	}
	@Override
	public Scores getExamScore(String pid, String userid) {
		Scores s=examIndexMapper.getExamScore(pid, userid);
		return s;
	}

}
