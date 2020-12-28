package com.hxzy.controller;

import com.alibaba.fastjson.JSON;
import com.hxzy.bean.Paper;
import com.hxzy.bean.Question;
import com.hxzy.service.IPaperManagService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/paperManager")
public class PaperManagerController {
    
	@Autowired
	IPaperManagService paperManagService;
	
	@RequestMapping("/getPaperinfo")
	@ResponseBody
	public String getPaperinfo(@RequestParam(value="pageNumber") String pageNumber){
		//创建当前页
		if(Integer.parseInt(pageNumber)==0){
    		pageNumber="1";
    	}
		int currentPage=Integer.valueOf(pageNumber);
		if(currentPage<=0){
			currentPage=1;
		}
		//每页记录数
		int pageSize=10;
		//起始行
		int startRow=(currentPage-1)*pageSize;
		//结束行
		int endRow=currentPage*pageSize;
	    //总计录数
		int allCount=0;
		 allCount=paperManagService.allCount();
		//总页数
		int allPage=allCount%pageSize==0?allCount/pageSize:(allCount/pageSize)+1;
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		List<Paper> listpaper=paperManagService.getPaperInfo(map);
		Map<String,Object> map1=new HashMap<String, Object>();
		map1.put("listpaper", listpaper);
		map1.put("allCount", allCount);
		map1.put("pageSize", pageSize);
		map1.put("allPage", allPage);
		map1.put("pageNumber", pageNumber);
		//[Paper [pid=171, pname=2222, ptimes=1, statime=2020-02-28 16:37:00.0, qids=438,387,433,453,458,466, status=无效, url=null, pcourse=null, scores=null], Paper [pid=142, pname=fdzceshi, ptimes=1, statime=2020-02-05 14:20:00.0,
		String json = JSON.toJSONStringWithDateFormat(map1, "yyyy-MM-dd HH:mm:ss");
		return json;
	}
	//跳转查看试卷页面
	@RequestMapping("/toQuestionPage")
	public String toQuestionPage(@RequestParam(value="qids") String qids,HttpServletRequest request){
		request.setAttribute("qids", qids);
		return "showQuestion";
	}
	//试卷题目查询
	@RequestMapping("/getQuestion")
	@ResponseBody
	public String getQuestionByPid(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=UTF-8");
		String qids=(String)request.getParameter("qids");
		List<Question> listquestion= paperManagService.getQuestionByPid(qids);
		String json= JSON.toJSONString(listquestion);
		return json;
	}
    //附件下载
	@RequestMapping("/toDownFile")
	//@ResponseBody
	public void toDownFile(@RequestParam(value="filepath") String filepath,HttpServletResponse response){
		 response.setCharacterEncoding("UTF-8");
		//文件的下载只需要文件名
		//获取文件的名字
		 File targetFile=new File(filepath);
		 String filename=targetFile.getName();
		 System.out.println(filename);
		//创建文件下载的parent
		/*File targetfilepath=new File("D:\\downfile\\");
		if(!targetfilepath.exists()){
			targetfilepath.mkdir();
		}*/
		
		 if(targetFile==null||!targetFile.exists()){
			 return;
		 }
		 String dfilname=null;
		try {
			dfilname = new String(filename.getBytes("gb2312"),"iso8859-1");
			response.reset();
			response.setContentType("application/octet-stream;charset=UTF-8");
			response.setHeader("Content-Disposition", "attachment;filename=" +dfilname);
			OutputStream out = response.getOutputStream();
			out.write(FileUtils.readFileToByteArray(targetFile));
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
}
