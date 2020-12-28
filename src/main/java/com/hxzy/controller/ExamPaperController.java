package com.hxzy.controller;

import com.alibaba.fastjson.JSON;
import com.hxzy.bean.Paper;
import com.hxzy.bean.Question;
import com.hxzy.bean.Scores;
import com.hxzy.bean.User;
import com.hxzy.service.IExamPaperService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;
import java.util.List;
/**
 * 试卷
 * @author home
 *
 */
@Controller
@RequestMapping("/examPaper")
public class ExamPaperController {
	@Autowired
	private IExamPaperService examPaperService;
	/**
	 * 获取试题内容
	 * @param qids 试题id
	 * @return
	 */
	@RequestMapping(value="/getExamContent")
	@ResponseBody
	public String getExamContent(String qids) {
		
		List<Question> list=examPaperService.getExamContent(qids);
		String json=JSON.toJSONString(list);
		
		return json;
	}
	/**
	 * 中间跳转页
	 * @return
	 */
	@RequestMapping("/jump")
	public String jump(HttpServletRequest request,HttpSession session) {
		
		String pid=request.getParameter("pid");
		String pname=request.getParameter("pname");
		String ptimes=request.getParameter("ptimes");
		String qids=request.getParameter("qids");
		String statime=request.getParameter("statime");
		int p=Integer.parseInt(ptimes);
		long endtime=new Date().getTime()+p*3600*1000;
		session.setAttribute("ptimes",ptimes);
		session.setAttribute("pid", pid);
		session.setAttribute("pname", pname);
		session.setAttribute("endtime", endtime);
		session.setAttribute("qids", qids);
		session.setAttribute("statime", statime);
		return "redirect:/page/toExamPaper.do";
	}
	/**
	 * 保存学生信息
	 * @param score 分数
	 * @return
	 */
	@RequestMapping("/saveScore")
	public String saveScores(Scores score,HttpServletRequest request) {
		
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("userInfo");
		String userId=user.getId()+"";
		String pid=(String)session.getAttribute("pid");
		String statime=(String)session.getAttribute("statime");
		long begintime=Long.parseLong(statime);
		Paper paper=new Paper();
		paper.setPid(Integer.parseInt(pid));
		score.setPaper(paper);
		User u=new User();
		u.setId(Integer.parseInt(userId));
		score.setUser(u);
		java.sql.Date date=new java.sql.Date(begintime);
		score.setBegintime(date);
		int n=examPaperService.saveScore(score);
		
		if(n>0) {
			return "redirect:/page/toExam_index.do";	
		}
		
		return "";
	}
	@RequestMapping(value="/checkSkillquestionIfExist",produces="text/html;charset=UTF-8;")
	@ResponseBody
	public String checkSkillQuestionIFExist(String pid) {
		String filePath=examPaperService.getFilePath(pid);
		return filePath;
	}
	
	 /**
	  * 文件下载
	  */
	 @RequestMapping("/fileDownload")
	 public void fileDownload(String pid,HttpServletResponse response) {
		 //获取客观题路径
		 String filePath=examPaperService.getFilePath(pid);
		 if(filePath!=null&&!("".equals(filePath))) {
		  //获取文件名
		 String filename=filePath.substring(filePath.lastIndexOf('\\')+1);
		 //路径不为空进行文件下载
		 File file=new File(filePath);
		
		 if(file==null||!file.exists()) {
			return ; 
		 }
		 try {
			 //设置发送到客户端的响应类型 application/octet-stream 任意类型
			 response.setContentType("application/octet-stream;charset=utf-8");
			 //告诉浏览器要下载的文件名称Content-Disposition 
			 //注使用Content-Disposition时在之前先要设置setContentType
			 //new String(filename.getBytes("gb2312"), "ISO8859-1")解决中文乱码
			 response.setHeader("Content-Disposition","attachment; filename="+new String(filename.getBytes("gb2312"), "ISO8859-1"));
			 //获取响应中的输出流
			ServletOutputStream out= response.getOutputStream();
			//FileUtils是文件的工具类
			out.write(FileUtils.readFileToByteArray(file));
		 }catch(Exception e) {
			 e.printStackTrace();
		 }
		 }
		 
	 }

	
}
