package com.hxzy.service;

import com.hxzy.bean.Option;
import com.hxzy.bean.Question;
import com.hxzy.bean.Type;

import java.util.List;
import java.util.Map;


public interface IQuestionService {
	
	 //下拉栏
	 public List<Type> profeQuery(String m);
	 // 条件查询获取总计录数
	 public int getQustionCount(Map<String, Object> map);
	 //条件查询获取指定试题
	 public List<Question> getQustion(Map<String, Object> map);
	 //删除单条数据
	 public int toDel(String id);
	 //删除多条数据
	 public int toDelMore(String ids);
	 //查看选项
	 public List<Option> toQueryChoose(int qid);
	 //修改前根据id查询
	 public Question getObjByid(String qid);
}
