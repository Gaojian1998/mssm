package com.hxzy.service.impl;

import com.hxzy.bean.Question;
import com.hxzy.bean.Scores;
import com.hxzy.dao.IExamPaperMapper;
import com.hxzy.service.IExamPaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 考试
 * @author home
 *
 */
@Service
public class ExamPaperServiceImpl implements IExamPaperService{
	@Autowired
	private IExamPaperMapper examPaperMapper;

	@Override
	public List<Question> getExamContent(String qids) {
		List<Question> list=examPaperMapper.getExamContent(qids);
		return list;
	}

	@Override
	public String getFilePath(String pid) {
		String filePath=examPaperMapper.getFilePath(pid);
		return filePath;
	}

	@Override
	public int saveScore(Scores s) {
		int n=examPaperMapper.saveScore(s);
		return n;
	}


}
