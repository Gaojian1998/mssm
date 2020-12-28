package com.hxzy.controller;

import com.alibaba.fastjson.JSON;
import com.hxzy.bean.Option;
import com.hxzy.bean.Question;
import com.hxzy.service.IAddQuestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/addQuestion")
public class AddQuestController {
	 
	 //自动装配实例化servic层对象
	 @Autowired
	 IAddQuestService addQuestService;
	 
	 int id=0;
	 
	 @RequestMapping("/toaddQuest")
     public void toaddQuest(HttpServletRequest request,HttpServletResponse response ){
		 try {
			 String qanswer=request.getParameter("qanswer").toString();
			 String qname = request.getParameter("qname");
			 String qscore = request.getParameter("qscore");
			 String qtype = request.getParameter("qtype");
			 String qcourse = request.getParameter("qcourse");
			 String qstage = request.getParameter("qstage");
			 Question question=new Question();
			 question.setQanswer(qanswer);
			 question.setQname(qname);
			 question.setQscore( Double.valueOf(qscore));
			 question.setQtype(qtype);
			 question.setQcourse(qcourse);
			 question.setQstage(qstage);
			 int k = addQuestService.insertQuestion(question);
			 if(k>0){
				 id = question.getId();
				 String json = JSON.toJSONString(String.valueOf(id));
				 response.getWriter().write(json);
			 }
		} catch (Exception e) {
			e.printStackTrace();
		}
     }
	 @RequestMapping("/toaddChoose")
	 @ResponseBody
	 public void toaddChoose(HttpServletRequest request){
		 //String mainid= request.getParameter("mainid").toString();
		 String achoose= request.getParameter("achoose");
		 String bchoose=request.getParameter("bchoose");
		 String cchoose=request.getParameter("cchoose");
		 String dchoose=request.getParameter("dchoose");
		 Option option=new Option();
		 option.setOpcontent("A、"+achoose);
		 option.setQid(id);
		 int m=0;
		 int k= addQuestService.addchoose(option);
		 if(k>0){
			 Option option2=new Option();
			 option2.setOpcontent("B、"+bchoose);
			 option2.setQid(id);
			 int j=addQuestService.addchoose(option2);
			 if(j>0){
				 Option option3=new Option();
				 option3.setOpcontent("C、"+cchoose);
				 option3.setQid(id);
				 int l=addQuestService.addchoose(option3);
				 if(l>0){
					 Option option4=new Option();
					 option4.setOpcontent("D、"+dchoose);
					 option4.setQid(id);
					 m=addQuestService.addchoose(option4);
				 }
			 }
		 }
		 if(m>0){
			 JSON.toJSONString(String.valueOf(m));
		 }
	 }
    
	 @RequestMapping("/toaddJudge")
	 @ResponseBody
	 public void toaddJudgeChoose(HttpServletRequest request){
		 String yeschoose= request.getParameter("yeschoose");
		 String nochoose=request.getParameter("nochoose");
		 Option option=new Option();
		 option.setOpcontent(yeschoose);
		 option.setQid(id);
		 int m=0;
		 int k= addQuestService.addchoose(option);
		 if(k>0){
			 Option option2=new Option();
			 option2.setOpcontent(nochoose);
			 option2.setQid(id);
			 int j=addQuestService.addchoose(option2);
			 if(j>0){
				 JSON.toJSONString(String.valueOf(m));
		      }
	     }
       }
}