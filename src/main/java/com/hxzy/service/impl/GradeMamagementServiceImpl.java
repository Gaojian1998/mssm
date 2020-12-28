package com.hxzy.service.impl;

import com.hxzy.bean.Paper;
import com.hxzy.bean.Question;
import com.hxzy.bean.Scores;
import com.hxzy.dao.IGradeManagementMapper;
import com.hxzy.service.IGradeManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
/**
 * 成绩管理
 * @author home
 *
 */
@Service
public class GradeMamagementServiceImpl implements IGradeManagementService{
	@Autowired
	private IGradeManagementMapper gradeManagementMapper;

	@Override
	public List<Map<String,Object>> queryScoreInfo(Map<String, Object> map) {
		List<Map<String,Object>> list=gradeManagementMapper.queryScoreInfo(map);
		return list;
	}

	@Override
	public int count(Map<String, Object> map) {
		int count=gradeManagementMapper.count(map);
		return count;
	}

	@Override
	public int clear() {
		int n=gradeManagementMapper.clear();
		return n;
	}

	@Override
	public int delMore(String ids) {
		int n=gradeManagementMapper.delMore(ids);
		return n;
	}

	@Override
	public Paper getPidByPname(String pname) {
		Paper p=gradeManagementMapper.getPidByPname(pname);
		return p;
	}

	@Override
	public String getUserIdByUsername(String username) {
		String userId=gradeManagementMapper.getUserIdByUsername(username);
		return userId;
	}

	@Override
	public int addScore(Scores scores) {
		int n=gradeManagementMapper.addScore(scores);
		return n;
	}

	@Override
	public Scores getScoresByScid(String id) {
		Scores s=gradeManagementMapper.getScoresByScid(id);
		return s;
	}

	@Override
	public int updateScore(String scid, String grade) {
		int n=gradeManagementMapper.updateScore(scid, grade);
		return n;
	}

	@Override
	public List<Question> getQuestionByQids(String qids) {
		List<Question> list=gradeManagementMapper.getQuestionByQids(qids);
		return list;
	}

}
