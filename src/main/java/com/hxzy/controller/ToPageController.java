package com.hxzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 跳转页面类
 * @author tinatian
 * 
 *
 */
@Controller
@RequestMapping("/page")

public class ToPageController {
	 
	@RequestMapping("/toExam_index")
    public String toPage() {
    	return "exam_index";
    }
	@RequestMapping("/toExamPaper")
    public String toPage2() {
    	return "exampaper";
    }
	@RequestMapping("/toLogin")
    public String toPage3() {
    	return "login";
    }

	@RequestMapping("/toGrade_man")
    public String toPage4() {
    	return "grade_management";
    }

	@RequestMapping("/toQuestion")
	public String toQuestion(){
		return "questionManager";
	}

	@RequestMapping("/toAdd")
    public String toAdd(){
    	return "addquestion";
    }
	@RequestMapping("/toPaperManager")
	public  String toPaperManager(){
		return "paperManager";
	}
	
	@RequestMapping("/toMain")
	public String toMain(){
		return "main";
	}
	
	@RequestMapping("/toTop")
	public String toTop(){
		return "top";
	}
	@RequestMapping("/toQue")
	public String toQue(){
		return "question";
	}
	@RequestMapping("/toPaper")
	public String toPaper(){
		return "Paper";
	}
    
	@RequestMapping("/toGeneraPaper")
	public String toGeneraPaper(){
		return "GeneraTestPaper";
	}
}
