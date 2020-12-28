package com.hxzy.controller;


import com.alibaba.fastjson.JSON;
import com.hxzy.bean.Option;
import com.hxzy.bean.Paper;
import com.hxzy.bean.Question;
import com.hxzy.service.IPaperService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * 试卷
 */

@RequestMapping("paper")
@Controller
public class PaperController {
	
	@Autowired
	private IPaperService paperservice;
	
	//生成试卷信息
	@RequestMapping("/getPaper")
	@ResponseBody
	public String getPaper(HttpServletRequest request,HttpServletResponse response) throws IOException{
		//单选题数
		String single = request.getParameter("Single");
		//多选题数
		String multiple = request.getParameter("Multiple");
		//判断题数
		String judge = request.getParameter("Judge");
		//课程
		String course = request.getParameter("course");
		//阶段
		String stage = request.getParameter("stage");
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("qcourse", course);
		map.put("qstage", stage);
		map.put("qsingle", single);
		map.put("qmultiple", multiple);
		map.put("qjudge", judge);		
		List<Question> qlist=paperservice.getListByMap(map);
		for(Question q:qlist){
			String qid= String.valueOf(q.getId());
			List<Option> olist=paperservice.getListById(qid);
			q.setOptions(olist);		
		}	
		String json=JSON.toJSONString(qlist);
		return json;
	}
	//保存试卷信息
	@RequestMapping("/savePaper")
	@ResponseBody
	public String savePaper(HttpServletRequest request, @RequestParam("uploadfile")MultipartFile upfile) throws Exception{
		//使用fileupload组件实现文件上传
		String url="";
        if (!upfile.isEmpty()) {
            System.out.println("文件非空");
            //获取上传文件的保存位置
            String savepath = request.getSession().getServletContext().getRealPath("/paperFile/");
            System.out.println(savepath);
            //判断该路径是否存在
            File file = new File(savepath);
            if (!file.exists()) {
                file.mkdirs();
            }
            String oldname=upfile.getOriginalFilename();
            long size=upfile.getSize();
            System.out.println("文件名称："+oldname);
            System.out.println("文件大小："+size);
            //文件传输
            upfile.transferTo(new File(file,oldname));
            url =savepath+oldname;
        }
		//获取表单信息
		String pname = request.getParameter("pname");
		String ptimes = request.getParameter("ptimes");
		String datetimepicker = request.getParameter("datetimepicker");
		String qcourse = request.getParameter("qcourse");
		//获取qids
		String qids = request.getParameter("qids");
		qids = qids.substring(0, qids.length()-1);
		Paper paper = new Paper();
		paper.setPcourse(qcourse);
		paper.setQids(qids);
		paper.setPname(pname);
		paper.setPtimes(Integer.parseInt(ptimes));
		
		DateFormat df=new SimpleDateFormat("yyyy/MM/dd HH:mm");
		Timestamp tim=new Timestamp(df.parse(datetimepicker).getTime());
		paper.setStatime(tim);
		if(StringUtils.isNotEmpty(url)){
			paper.setUrl(url);
		}
		int k=paperservice.save(paper);	
		if(k>0){
			return"保存成功";
		}
		return "保存失败";
	}
	//文件上传
	@RequestMapping("/fileupload")
	@ResponseBody
    public String upload(HttpServletRequest request, @RequestParam("uploadfile")
            MultipartFile upfile) throws Exception {
		String pname=request.getParameter("pname");
		String url="";
        System.out.println("upload文件上传");
        //使用fileupload组件实现文件上传
        if (!upfile.isEmpty()) {
            System.out.println("文件非空");
            //获取上传文件的保存位置
            String savepath = request.getSession().getServletContext().getRealPath("/paperFile/");
            System.out.println(savepath);
            //判断该路径是否存在
            File file = new File(savepath);
            if (!file.exists()) {
                file.mkdirs();
            }
            String oldname=upfile.getOriginalFilename();
            long size=upfile.getSize();
            System.out.println("文件名称："+oldname);
            System.out.println("文件大小："+size);
            //文件传输
            upfile.transferTo(new File(file,oldname));
            url =savepath+oldname;
            return url;
        } else{
            System.out.println("文件空");
            return url;
        }
    }

}
