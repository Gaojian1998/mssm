<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>考试页面</title>
		<link rel="stylesheet" href="<%=path %>/bootstrap/css/bootstrap.css" />
        <link rel="stylesheet" href="<%=path %>/css/exam.css"/>
        <script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
        <script type="text/javascript">
        var qids='${qids}';
        
        var pid='${pid}';
       
        //考试结束时间
        var endtime=${endtime};
        var ptimes=${ptimes};
       // alert(endtime);
         $(function(){
        	 examContent();
        	
        	 scantron();
        	
        	 setInterval("countdown();",1000);
        	 checkSkillQuestionIFExist();
        	 
        	
         })
         //试卷内容
         function examContent(){
        	 $.ajax({
        		 type:"post",
        		 url:"<%=path%>/examPaper/getExamContent.do",
        		 data:{"qids":qids},
        		 dataType:"json",
        		 success:function(res){
        			 var html1="";//单选
        			 var html2="";//多选
        			 var html3="";//判断
        			
				       for(var i in res){
				    	  var a=parseInt(i);
				    	   var obj=res[i];
				    	   if(obj.qtype==1){//单选
				    		    var op="";
						        for(var j in obj.options){
						        	var obj1=obj.options[j];
						        	
						        	op+="<li>"+
			    							"<div class=\"radio\">"+
										    "<label><input type=\"radio\" name=\"optionsRadios"+(a+1)+"\"  class=\"optioncheck\"  value=\""+obj1.opcontent+"\" onclick=\"if(this.c==1){this.c=0;this.checked=0}else this.c=1\">"+obj1.opcontent+"</label>"+
										    "</div>"+
							    	    "</li>";
						        }
				    		   html1+="<div class=\"panel panel-default\">"+
										    "<div class=\"panel-heading\">"+(a+1)+".(单选题).("+obj.qscore+"分)"+obj.qname+"</div>"+
										    "<ul> <input type=\"text\" hidden=\"hidden\" value=\""+(obj.id+"-"+obj.qanswer)+"\">"+op+"</ul>"+
					                    "</div>";
		                    
		                    
				    	   }else if(obj.qtype==2){//多选
				    		   var op2="";
				    	       for(var j in obj.options){
				    	    	   var obj2=obj.options[j];
				    	    	 
				    	    	   op2+="<li>"+
							    		  "<div class=\"checkbox\">"+
								            "<label><input type=\"checkbox\" name=\"optionsRadios"+(a+1)+"\" class=\"optioncheck\"  class=\"tui-checkbox\" value=\""+obj2.opcontent+"\">"+obj2.opcontent+"</label>"+
								         "</div>"+
					    	            "</li>";
				    	       }
				    	       //<input type="radio" onclick="if(this.c==1){this.c=0;this.checked=0}else this.c=1">
				    		   
				    		   html2+="<div class=\"panel panel-default\">"+
							    "<div class=\"panel-heading\">"+(a+1)+".(多选题).("+obj.qscore+"分)"+obj.qname+"</div>"+
							    "<ul> <input type=\"text\" hidden=\"hidden\" value=\""+(obj.id+"-"+obj.qanswer)+"\">"+op2+"</ul>"+
		                    "</div>";
				    		   
				    	   }else if(obj.qtype==3){//判断
				    		   
				    		   var op3="";
				    	       for(var j in obj.options){
				    	    	   var obj3=obj.options[j];
				    	    	  
				    	    	   var op3="<li>"+
									    		"<div class=\"radio\">"+
												    "<label><input type=\"radio\" name=\"optionsRadios"+(a+1)+"\" class=\"optioncheck\"  value=\""+obj3.opcontent+"\" onclick=\"if(this.c==1){this.c=0;this.checked=0}else this.c=1\"> "+obj3.opcontent+"</label>"+
										        " </div>"+
							    	        "</li>";
				    	       }
				    		   html3+="<div class=\"panel panel-default\">"+
							    "<div class=\"panel-heading\">"+(a+1)+".(判断题).("+obj.qscore+"分)"+obj.qname+"</div>"+
							    "<ul> <input type=\"text\" hidden=\"hidden\" value=\""+(obj.id+"-"+obj.qanswer)+"\">"+op3+"</ul>"+
							"</div>";
				    		   
				    	   }
				       }
				      $("#one").html(html1);
				      $("#more").html(html2);
				      $("#juage").html(html3);
				      connection();
				      fileDownload();
				      submit();
				     }
				  })
			 }
                    
         //试卷与答题卡关联
         function connection(){
        	
        	 //给所有选项绑定单击事件
        	$("[class='optioncheck']").click(function(){
        		var self=$(this);
        		//如果当前选项选中,答题卡变颜色
       		   var str=self.parent().parent().parent().parent().prev().text();
       		   //获取题号
       		   index=str.substring(0,str.indexOf("."));
        		if(self.prop("checked")){
        		  
        		  $("[class='btn btn-default']").eq(parseInt(index)-1).css("background-color","gray");
        		  
        		}else {
        			
        		  $("[class='btn btn-default']").eq(parseInt(index)-1).css("background-color","");
        		}
        	})
         }
         //客观题下载(文件下载一般别用ajax)
         function fileDownload(){
        	 $("[type='button']").eq(0).click(function(){
        		
        		 location.href="<%=path%>/examPaper/fileDownload.do?pid="+pid;
        		 
        	 }) 
         }
        	 
         //查看客观题是否存在，不存在将下载客观题按钮进行隐藏，存在显示客观题题目
         function checkSkillQuestionIFExist(){
        	
        	 $.ajax({
        		 type:"post",
        		 url:"<%=path%>/examPaper/checkSkillquestionIfExist.do",
        		 data:{"pid":pid},
        		 dataType:"text",
        		 success:function(res){
        			 if(res!=null&&res!=""){
        				 $("[class='btn btn-success']").css("display","display"); 
        				 var filename=res.substring(res.lastIndexOf('\\')+1);
        				 $("[class='btn btn-success']").text(filename+"下载");
        				
        			 }else {
        				 //alert("sss");
        				 $("[class='btn btn-success']").css("display","none");
        			 }
        				
        				 
        			 }
        		
        	 })
        		 }
        	
         //考试倒计时
         function countdown(){
        	
        	 //当前时间
        	 var current=new Date().getTime();
        	 // alert(current);
        	 var time=endtime-current;
        	 if(time>0){
        		 var hour=Math.floor(time/(3600*1000));
        		 var minutes=Math.floor(time%(3600*1000)/(60*1000));
        		 var seconds=Math.floor(time%(60*1000)/1000);
        		 $("#countdown").text("在线考试倒计时: "+hour+"小时"+minutes+"分"+seconds+"秒");
        	 }else {
        		 //超过
        		 //提交试卷
        		 examAnswer();
        	 }
        	 
         }
         
         //答题卡
          function scantron(){
        	 var arr=new Array();
        	 arr=qids.split(",");
        	 var html="";
        	 for(var i =0;i<arr.length;i++){
        		 html+="<button type=\"button\" class=\"btn btn-default\">"+(i+1)+"</button>";
        	 }
        	$("#center").append(html);
         } 
         //提交试卷
        function submit(){
        	 $("[class='btn btn-danger']").click(function(){
        		 examAnswer();
        	 })
         }
         //试卷答案
         function examAnswer(){
        	 //答案字符串
    		 var str="";
        	 //正确答案的字符串
        	 var corrstr="";
    		 var arr=new Array();
        	 arr=qids.split(",");
        	 var scores=0;
        	 for(var i=1;i<=arr.length;i++){
        		 //答案
        		 var option="";
        		//正确答案
    			 var answer=$("[name=\"optionsRadios"+i+"\"]").parent().parent().parent().parent().children().val();
        		 
        		  answer1=answer.substring(answer.indexOf("-")+1,answer.length);
        		  //alert(answer1);
        		//分数
        		var s=$("[name=\"optionsRadios"+i+"\"]").parent().parent().parent().parent().prev().text();
        		var score=parseInt(s.substring(s.indexOf("题")+4,s.indexOf("分")));
        		//类型
                var type=s.substring(s.indexOf("(")+1,s.indexOf("题"));
               
        		 $("[name=\"optionsRadios"+i+"\"]:checked").each(function(){
        			 var obj=$(this);
        			 var op1=obj.val(); 
        			 if(type=="判断"){
        			
        			 option=op1;		 
        			 }else{
        			 option+=op1.substring(0,op1.indexOf("、"));	
        			 }
        			
        			 
        			 
        		 }) 
        		 str+=answer.substring(0,answer.indexOf("-"))+"-"+option+",";
        		 //alert(str);
        		 //判断答案是否正确
        		 if(answer1==option){
        			 scores+=score;
        		 }	
        	 }
        	 str=str.substring(0,str.lastIndexOf(","));
        	 corrstr=corrstr.substring(0,corrstr.lastIndexOf(","));
        	 //当前时间
        	 var current=new Date().getTime();
        	 var time=ptimes*3600*1000-(endtime-current);
        	 var hour=Math.floor(time/(3600*1000));
    		 var minutes=Math.floor(time%(3600*1000)/(60*1000));
    		 var seconds=Math.floor(time%(60*1000)/1000);
    		 var examtime=hour+"时"+minutes+"分"+seconds+"秒";
           location.href="<%=path%>/examPaper/saveScore.do?scores="+scores+"&myanswer="+str+"&usetimes="+examtime;
         }
        </script>
	</head>
	<body>
		<div id="main">
			<div id="top">
				<div id="top_left">
					<span>考生姓名:${userInfo.username}</span>
					<span>试卷标题:${pname}</span>
					<span id="countdown" style="color:red"></span>
				</div>
				<div id="top_right">
					<button type="button" class="btn btn-success" id="skill" >技能题下载</button>
					<button type="button" class="btn btn-danger">提交试卷</button>
				</div>
			</div>
			<div id="center">
				<span>答题卡:</span>
			
				
			</div>
			<div id="bottom">
			    
					<!--单选-->
					<div id="one">
						
					</div>
					<!--多选-->
					<div id="more">
						
					</div>
					<!--判断-->
					<div id="juage">
						
					</div>
				
			</div>
		</div>
	</body>
</html>
    