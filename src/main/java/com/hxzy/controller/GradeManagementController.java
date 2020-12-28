package com.hxzy.controller;



import com.alibaba.fastjson.JSON;
import com.hxzy.bean.Paper;
import com.hxzy.bean.Question;
import com.hxzy.bean.Scores;
import com.hxzy.bean.User;
import com.hxzy.service.IExamIndexService;
import com.hxzy.service.IGradeManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 成绩管理控制层
 * @author home
 *
 */
@Controller
@RequestMapping("/grademanagement")
public class GradeManagementController {
	@Autowired
	private IGradeManagementService gradeManagementService;
	@Autowired
	private IExamIndexService examIndexService;
	/**
	 * 查询成绩信息
	 * @return
	 */
	@RequestMapping("/queryScores")
	@ResponseBody
    public String queryScoresInfo(String name,String pname,String currentpage) {
		Map<String ,Object> map=new HashMap<String,Object>();
		Map<String ,Object> data=new HashMap<String,Object>();
		/*
		 * SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd"); Date date=null;
		 * //有问题 try { if(begintime!=null||(!("".equals(begintime)))){
		 * date=sdf.parse(begintime); }
		 * 
		 * } catch (ParseException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 */
		//查询条件
		map.put("name", name);
		map.put("pname",pname);
		if(currentpage==null||"".equals(currentpage)){
			currentpage="1";
		}
		//获取当前页
		int current=Integer.parseInt(currentpage);
		if(current<=1){
			current=1;
		}
		//页面容量
		int pagesize=10;
		//总记录数
		
		int count=gradeManagementService.count(map);
		//获取总页数
		int pagenum=count%pagesize==0?count/pagesize:count/pagesize+1;
		if(current>=pagenum){
			current=pagenum;
		}
		//获取当前页开始位置
		int startnum=(current-1)*pagesize+1;
		//获取当前也结束位置
		int  endnum=current*pagesize;
		map.put("startrow", startnum);
		map.put("endrow",endnum);
		//查询数据
		List<Map<String,Object>> list=gradeManagementService.queryScoreInfo(map);
		
		data.put("list", list);
		data.put("count", count);
		data.put("pagesize",pagesize);
		data.put("pagenum", pagenum);
		data.put("current", current);
		String json=JSON.toJSONString(data);
    	return json;
    }
	/**
	 * 获取成绩信息
	 * @param scid
	 * @return
	 */
	@RequestMapping("/getScoresByScid")
	@ResponseBody
	public String getScoresByScid(String scid) {
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		Scores s=gradeManagementService.getScoresByScid(scid);
		//Map<String ,Object> map=new HashMap<String,Object>();
		//答案加id的数组
		String [] str=s.getMyanswer().split(",");
		//考试例题号
		String [] ids=new String[str.length];
		//存放我的答案
		String [] answers=new String[str.length];
		String qids="";
		//获取题号
		for(int i=0;i<str.length;i++) {
			
			ids[i]=str[i].substring(0,str[i].indexOf("-"));
			answers[i]=str[i].substring(str[i].indexOf("-")+1,str[i].length());
			qids+=str[i].substring(0,str[i].indexOf("-"))+",";
		}
		qids=qids.substring(0, qids.lastIndexOf(","));
		List<Question> list1=gradeManagementService.getQuestionByQids(qids);
		if(list1!=null) {
			for(int j=0;j<ids.length;j++) {
				for(int k=0;k<list1.size();k++) {
					if(list1.get(k).getId()==(Integer.parseInt(ids[j]))) {
						Map<String,Object> map=new HashMap<String,Object>();
						//试题名称
						map.put("content", list1.get(k).getQname());
						//试题正确答案
						map.put("corrAnswer", list1.get(k).getQanswer());
						//我的答案
						map.put("myAnswer", answers[j]);
						//试题的选项
						map.put("options",list1.get(k).getOptions());
						//试题的类型
						map.put("type", list1.get(k).getQtype());
						list.add(map);
						list1.remove(k);
						break;
					}
				}
			}
		}
		String json=JSON.toJSONString(list);
		return json;
	}
	/*
	 * 修改考生成绩
	 * @param id
	 * @param grade
	 * @return
	 */
	@RequestMapping("/updateScores")
	@ResponseBody
	public String updateScore(String id,String grade) {
		int n=gradeManagementService.updateScore(id, grade);
		return n+"";
	}
	/**
	 * 清空数据
	 * @return
	 */
	@RequestMapping("/clear")
	@ResponseBody
	public String clear() {
		int n=gradeManagementService.clear();
		String flat="false";
		if(n>0) {
			flat="true";
		}
		
	return flat;	
	}
	/**
	 * 批量删除数据
	 * @param ids 
	 * @return
	 */
	@RequestMapping("/delMore")
	@ResponseBody
	public String delMore(String ids) {
		String idx=ids.substring(0, ids.lastIndexOf(","));
		int n=gradeManagementService.delMore(idx);
		return n+"";
	}
	/**
	 * 添加成绩信息
	 * @param score
	 * @return
	 */
	@RequestMapping("/addScore")
	@ResponseBody
	public String addScore(Scores score) {
		String flat="true";
		//判断用户是否存在：不存在返回，插入失败
		String userid=gradeManagementService.getUserIdByUsername(score.getUser().getUsername());
		if(userid==null||"".equals(userid)) {
			return "false1";
		}
		User u=new User();
		u.setId(Integer.parseInt(userid));
		score.setUser(u);
		//判断试卷是否存在：不存在插入失败
		Paper p=gradeManagementService.getPidByPname(score.getPaper().getPname());
		if(p==null) {
			return "false2";
		}
		//默认手动插入的数据。用时为考试时长
		String time=(p.getPtimes()/1)+"时"+(p.getPtimes()%1)*60+"分";
		score.setUsetimes(time);
		score.setPaper(p);
		Scores s=examIndexService.getExamScore(p.getPid()+"", userid);
		//判断该考试此次试卷是否考过
		if(s!=null) {
			return "false3";
		}
		int n=gradeManagementService.addScore(score);
		if(n<=0) {
			return "false4";
		}
		return "true";
	}
}

