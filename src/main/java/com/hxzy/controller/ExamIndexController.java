package com.hxzy.controller;

import com.alibaba.fastjson.JSON;
import com.hxzy.bean.Paper;
import com.hxzy.bean.Scores;
import com.hxzy.bean.User;
import com.hxzy.service.IExamIndexService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 考试主页(欢迎页)
 *
 * @author home
 */
@Controller
@RequestMapping("/examIndex")
public class ExamIndexController {

	@Autowired
	private IExamIndexService examIndexService;

	@RequestMapping(value = "/examInfo")
	@ResponseBody
	public String getexamInfo(String current, HttpSession session) {
		//获取登录用户的id
		User user = (User) session.getAttribute("userInfo");
		String userid = "";
		if (user != null) {
			userid = user.getId() + "";
		} else {
			return "login";
		}
		List<Paper> papers = examIndexService.getExamInfo(current);
		//通过用户id与试卷id查看此次考试是否已完成，完成返回分数
		for (Paper p : papers) {
			Scores s = examIndexService.getExamScore(p.getPid() + "", userid);
			Scores score = new Scores();
			if (s != null) {

				score.setScores(s.getScores());
				score.setScid(s.getScid());

			}
			p.setScores(score);
		}
		String json = JSON.toJSONString(papers);

		return json;
	}


}
