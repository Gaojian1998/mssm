package com.hxzy.service.impl;

import com.hxzy.bean.Option;
import com.hxzy.bean.Question;
import com.hxzy.bean.Type;
import com.hxzy.dao.IQuestionMapper;
import com.hxzy.service.IQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class QuestionServiceImpl implements IQuestionService {
    
	//类型自动装配实例化dao层对象
	@Autowired
	private IQuestionMapper questionMapper;
	
	//下拉栏
	@Override
	public List<Type> profeQuery(String m) {
		
		List<Type> listprofe= questionMapper.profeQuery(m);
		
		return listprofe;
	}
    //条件查询获取总计录数
	@Override
	public int getQustionCount(Map<String, Object> map) {
		int count = questionMapper.getQustionCount(map);
		return count;
	}
	//条件查询获取指定试题
	@Override
	public List<Question> getQustion(Map<String, Object> map) {
		List<Question> listquestion = questionMapper.getQustion(map);
		return listquestion;
	}
	//删除单条数据
	@Override
	public int toDel(String id) {
		int k = questionMapper.toDel(id);
		return k;
	}
	//删除多条数据
	@Override
	public int toDelMore(String ids) {
		int k = questionMapper.toDelMore(ids);
		return k;
	}
	@Override
	public List<Option> toQueryChoose(int qid) {
		List<Option> listChoose = questionMapper.toQueryChoose(qid);
		return listChoose;
	}
	@Override
	public Question getObjByid(String qid) {
		Question question= questionMapper.getObjByid(qid);
		return question;
	}
	
}
