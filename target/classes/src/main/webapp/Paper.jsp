<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>   
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>生成试卷页面</title>
    <jsp:include page="top.jsp"/>
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/jquery.datetimepicker.css">
    <script type="text/javascript" src="<%=path%>/js/jquery.datetimepicker.full.js"></script>
    <script type="text/javascript">   
    $(function(){
    	var url="";
    	var qids="";
    	var qcourse="";
    	//时间控件
    	$("#datetimepicker").datetimepicker();     
    	 //生成试卷
    	 $("#button01").click(function(){ 
    		 qids="";
    		 var Single = $("#Single").val();
             var Multiple = $("#Multiple").val();
             var Judge = $("#Judge").val();
             var course = $("#course").val();
             var stage = $("#stage").val();          
             var s=parseInt(Single);
             var m=parseInt(Multiple); 
             var j=parseInt(Judge); 
             var SUM=0;
    		 if(Single==null || Single=='' || Single==undefined || Multiple==null || Multiple=='' || Multiple==undefined || Judge==null || Judge=='' || Judge==undefined){
				alert("各题型数目均不能为空");    			 
    		 }else{
    		 var traget=document.getElementById("form02");  
             if(traget.style.display=="none"){  
                 traget.style.display="";  
             }            
             //[{"id":403,"list":[{"oid":404,"oname":"A、 编译报错","qid":403},{"oid":405,"oname":"B、 12 ","qid":403},{"oid":406,"oname":"C、 12.0","qid":403},{"oid":407,"oname":"D、 运行时报错","qid":403}],"qcourse":0,"qname":"下列表达式运算后的结果是： \nbyte    b=10;\ndouble  d=2.0;\nint  n=b+d;","qscore":5.0,"qstage":0},
             //{"id":408,"list":[{"oid":409,"oname":"A、 ”+”","qid":408},{"oid":410,"oname":"B、 ”++”","qid":408},{"oid":411,"oname":"C、 ”=”","qid":408},{"oid":412,"oname":"D、 ”%”","qid":408}],"qcourse":0,"qname":"下列哪些不属于算术运算符 ","qscore":5.0,"qstage":0},{"id":453,"list":[{"oid":454,"oname":"A、 int[]  arry=new int[]{}","qid":453},{"oid":455,"oname":"B、 int  arry=new int[]{}","qid":453},{"oid":456,"oname":"C、 int[]  arry={‘a’,2,4}","qid":453},{"oid":457,"oname":"D、  int  arry=new int[4]","qid":453}],"qcourse":0,"qname":"下列数组格式正确的是","qscore":10.0,"qstage":0},{"id":458,"list":[{"oid":459,"oname":"A、 3=3?true:false","qid":458},{"oid":460,"oname":"B、  (1+1>0 && 3>2)?true:false","qid":458},{"oid":461,"oname":"C、 4>3?false:true ","qid":458},{"oid":462,"oname":"D、 4>3:false?true","qid":458}],"qcourse":0,"qname":"下列三目运算符表达式正确的是:","qscore":10.0,"qstage":0},{"id":463,"list":[{"oid":464,"oname":"对","qid":463},{"oid":465,"oname":"错","qid":463}],"qcourse":0,"qname":"java是一种语言吗","qscore":5.0,"qstage":0},{"id":466,"list":[{"oid":467,"oname":"对","qid":466},{"oid":468,"oname":"错","qid":466}],"qcourse":0,"qname":"java不是一种语言吗","qscore":5.0,"qstage":0}]
             $.ajax({
  			   type:"post",
  			   url:"<%=path%>/paper/getPaper.do",  			    
  			   data:{"Single":Single,"Multiple":Multiple,"Judge":Judge,"course":course,"stage":stage},
  			   dataType:"json",
  			   success:function(res){
  				 //[{"id":382,"options":[{"id":494,"opcontent":"A、 int a","qid":0},{"id":495,"opcontent":"B、 double b=4.5","qid":0},{"id":496,"opcontent":"C、 boolean b=true","qid":0},{"id":497,"opcontent":"D、 float f=9.8","qid":0}],"qcourse":"8","qname":"下列变量定义错误的是:","qscore":5.0},
  				    //{"id":387,"options":[{"id":388,"opcontent":"A、 double,int,long,float","qid":0},{"id":389,"opcontent":"B、 double,float,int,byte","qid":0},{"id":390,"opcontent":"C、 byte,long,double,float","qid":0},{"id":391,"opcontent":"D、 double,int,flaot,long","qid":0}],"qcourse":"8","qname":"下列数据类型的精度由高到低的顺序是","qscore":5.0},{"id":392,"options":[{"id":393,"opcontent":"A、 $java","qid":0},{"id":394,"opcontent":"B、 3_test","qid":0},{"id":396,"opcontent":"C、 hello-test","qid":0},{"id":397,"opcontent":"D、 my name","qid":0}],"qcourse":"8","qname":"下列哪些是合法的标识符 ","qscore":5.0},{"id":398,"options":[{"id":399,"opcontent":"A、 1011","qid":0},{"id":400,"opcontent":"B、 1101 ","qid":0},{"id":401,"opcontent":"C、 1001","qid":0},{"id":402,"opcontent":"D、 1101","qid":0}],"qcourse":"8","qname":"转化为二进制是：","qscore":5.0},{"id":403,"options":[{"id":404,"opcontent":"A、 编译报错","qid":0},{"id":405,"opcontent":"B、 12 ","qid":0},{"id":406,"opcontent":"C、 12.0","qid":0},{"id":407,"opcontent":"D、 运行时报错","qid":0}],"qcourse":"8","qname":"下列表达式运算后的结果是： \nbyte    b=10;\ndouble  d=2.0;\nint  n=b+d;","qscore":5.0},{"id":408,"options":[{"id":409,"opcontent":"A、 ”+”","qid":0},{"id":410,"opcontent":"B、 ”++”","qid":0},{"id":411,"opcontent":"C、 ”=”","qid":0},{"id":412,"opcontent":"D、 ”%”","qid":0}],"qcourse":"8","qname":"下列哪些不属于算术运算符 ","qscore":5.0},{"id":413,"options":[{"id":414,"opcontent":"A、 3=3?true:false","qid":0},{"id":415,"opcontent":"B、 (1+1>0 && 3>2)?true:false","qid":0},{"id":416,"opcontent":"C、 4>3?false:true","qid":0},{"id":417,"opcontent":"D、 4>3:false?true","qid":0}],"qcourse":"8","qname":"下列三目运算符表达式正确的是:","qscore":5.0},{"id":418,"options":[{"id":419,"opcontent":"A、 int a=(double) 8.0","qid":0},{"id":420,"opcontent":"B、 byte b=(byte)(4+4)","qid":0},{"id":421,"opcontent":"C、 double d=2+3","qid":0},{"id":422,"opcontent":"D、 int n=(byte) 4","qid":0}],"qcourse":"8","qname":"下列属于强制类型转化的是","qscore":5.0},{"id":423,"options":[{"id":424,"opcontent":"A、 switch 语句必须要有default","qid":0},{"id":425,"opcontent":"B、 switch 语句default必须写在最后","qid":0},{"id":426,"opcontent":"C、 switch 语句必须要有case标识符","qid":0},{"id":427,"opcontent":"D、 switch 语句必须要写break","qid":0}],"qcourse":"8","qname":"下列有关switch 语句描述正确的是 ","qscore":5.0},{"id":428,"options":[{"id":429,"opcontent":"A、 public void getName{}","qid":0},{"id":430,"opcontent":"B、  int void getValue(int n)","qid":0},{"id":431,"opcontent":"C、 void getAge(){}","qid":0},{"id":432,"opcontent":"D、 getName(){}","qid":0}],"qcourse":"8","qname":"下列方法格式正确的是 ","qscore":5.0},{"id":433,"options":[{"id":434,"opcontent":"A、 int[]  arry=new int[]{}","qid":0},{"id":435,"opcontent":"B、 int  arry=new int[]{}","qid":0},{"id":436,"opcontent":"C、 int[]  arry={‘a’,2,4}","qid":0},{"id":437,"opcontent":"D、 int  arry=new int[4]","qid":0}],"qcourse":"8","qname":"下列数组格式正确的是","qscore":5.0},{"id":438,"options":[{"id":439,"opcontent":"A、 1","qid":0},{"id":440,"opcontent":"B、 2","qid":0},{"id":441,"opcontent":"C、 没有结果","qid":0},{"id":442,"opcontent":"D、 编译报错","qid":0}],"qcourse":"8","qname":"以下代码执行的结果是 <br>\nfor (int i=2;i<=10;i++){<br>\n\t  if(i%2==0){\n\t     break;\n\t  }\n\t  System.out.println(i);\n\t }","qscore":5.0},{"id":443,"options":[{"id":444,"opcontent":"A、 1~10的所有偶数","qid":0},{"id":445,"opcontent":"B、 1~10的所有奇数","qid":0},{"id":446,"opcontent":"C、 1","qid":0},{"id":447,"opcontent":"D、 2","qid":0}],"qcourse":"8","qname":"下列代码执行的结果是: \nfor (int i=1;i<=10;i++){\n\t  if(i%2==0){\n\t     continue;\n\t  }\n\t  System.out.println(i);\n\t }","qscore":5.0},{"id":448,"options":[{"id":449,"opcontent":"A、 退出整个循环","qid":0},{"id":450,"opcontent":"B、 1~10的所有奇数","qid":0},{"id":451,"opcontent":"C、 1","qid":0},{"id":452,"opcontent":"D、 2","qid":0}],"qcourse":"8","qname":"下列代码执行的结果是: \n  for (int i=1;i<=10;i++){\n\t  if(i%2==0){\n\t     return;\n\t  }\n\t  System.out.println(i);\n\t }","qscore":5.0},{"id":453,"options":[{"id":454,"opcontent":"A、 int[]  arry=new int[]{}","qid":0},{"id":455,"opcontent":"B、 int  arry=new int[]{}","qid":0},{"id":456,"opcontent":"C、 int[]  arry={‘a’,2,4}","qid":0},{"id":457,"opcontent":"D、  int  arry=new int[4]","qid":0}],"qcourse":"8","qname":"下列数组格式正确的是","qscore":10.0},{"id":463,"options":[{"id":464,"opcontent":"对","qid":0},{"id":465,"opcontent":"错","qid":0}],"qcourse":"8","qname":"java是一种语言吗","qscore":5.0},{"id":466,"options":[{"id":467,"opcontent":"对","qid":0},{"id":468,"opcontent":"错","qid":0}],"qcourse":"8","qname":"java不是一种语言吗","qscore":5.0}]  
  				 
  				 var html="";
  				 for(var i in res){
  					var obj=res[i];
  					i++;
  					qcourse=obj.qcourse;
  					qids=qids+obj.id+",";
  					if(obj.qtype=="1"){html+="<div id=\"SingleChoice\">"+
  						"<div class=\"panel panel-default\">"+
				        "<div class=\"panel-heading\">"+i+"、(单选题)"+obj.qname+"</div>"+
		                "<ul id=\"Single\">";
		                 SUM = SUM+obj.qscore;
		                for(var j in obj.options){
		                	 html+="<div>"+
							    "<label>"+obj.options[j].opcontent+"</label>"+
								"</div>";
		                }
				        html+="</ul>"+
                        "</div>"+ 
			            "</div>";}
  					else if(obj.qtype=="2"){html+="<div id=\"MultipleChoice\">"+
  						"<div class=\"panel panel-default\">"+
				        "<div class=\"panel-heading\">"+i+"、(多选题)"+obj.qname+"</div>"+
		                "<ul id=\"Multiple\">";
		                SUM=SUM+obj.qscore;
		                for(var x in obj.options){
		                	 html+="<div>"+
							    "<label>"+obj.options[x].opcontent+"</label>"+
								"</div>";
		                }
				        html+="</ul>"+
                       "</div>"+ 
			            "</div>";}
  					else if(obj.qtype=="3"){
  						html+="<div id=\"Judge\">"+
  						"<div class=\"panel panel-default\">"+
				        "<div class=\"panel-heading\">"+i+"、(判断题)"+obj.qname+"</div>"+
		                "<ul id=\"Judge\">";
		                SUM=SUM+obj.qscore;
		                for(var y in obj.options){
		                	 html+="<div>"+
							    "<label>"+obj.options[y].opcontent+"</label>"+
								"</div>";
		                }
				        html+="</ul>"+
                      "</div>"+ 
			            "</div>";} 							
  				 }
  				 if(qids==""){
  					 alert("未找到结果集！")
  				 }
  				$("#Totalscore").text(SUM);
  				if(SUM>100){
  	    			 alert("总分数不能超过100分");
  	    		 }
  				$("[id='form02']").html(html);
  			   }  			
  		   }) 
    	 }
       })      
       //打开模态框
        $("#button02").click(function(){
        	$('#myModal').show();
       })
         //上传文件
        $("#button03").click(function () {
           $("[name='qids']").val(qids);
           $("[name='qcourse']").val(qcourse);
           var pname = $("#pname").val();
           var ptimes = $("#ptimes").val();
           var datetimepicker = $("#datetimepicker").val();
           var formData = new FormData($('#uploadForm')[0]); 
            if(pname==null || pname=='' ||pname==undefined ){
       		    alert("试卷描述不能为空");
	       	}else if(ptimes==null || ptimes=='' ||ptimes==undefined ){
	       		alert("考试时长不能为空");
	       	}else if(datetimepicker==null || datetimepicker=='' ||datetimepicker==undefined ){
	       		alert("开始考试时间不能为空");
	       	}else{
		       	 $.ajax({ 
			           type: 'post', 
			           url: "<%=path%>/paper/savePaper.do",
			           data: formData,
			           dataType:"text",
			           cache: false, 
			           processData: false, 
			           contentType: false, 
		          }).success(function(data) { 
		             alert("上传成功");
		          }).error(function(data) { 
		             alert("上传失败");
		          });
	       	}
           
    	  })
       
       })
    </script>
</head>
<body>
    <div class="container" style="margin-top: 60px;">
	<!-- form表单，生成试卷 -->
	<form id="form01" class="form-inline" role="form">
	
	  <div class="form-group">
	    单选题：<input id="Single" name="Single" type="text" class="form-control" style="width: 80px"  >
	    多选题：<input id="Multiple" name="Multiple" type="text" class="form-control" style="width: 80px" >
	    判断题：<input id="Judge" name="Judge" type="text" class="form-control" style="width: 80px"  >
	  
		<label for="course">课程：</label>
		    <select id="course" class="form-control" style="width: 150px">
		      <option value="8">java</option>
		      <option value="9">大数据</option>  
		      <option value="10">UI设计</option>
		      <option value="11">AI智能</option>
		      <option value="12">网络营销</option>
		    </select>
		<label for="stage">阶段：</label>
		    <select id="stage" class="form-control" style="width: 150px">
		      <option value="4">第一阶段</option>
		      <option value="5">第二阶段</option>
		      <option value="6">第三阶段</option>
		      <option value="7">第四阶段</option>
           </select>
                            总分值：<span><strong id="Totalscore">0</strong>分</span>				    
			<div class="btn-group">
			    <button id="button01" type="button" class="btn btn-success"><span class="glyphicon glyphicon-export" style="color: rgb(110, 253, 202);"></span>生成试卷</button>
			    <button id="button02" type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-save" style="color: rgb(205, 215, 79);"></span>保存试卷</button>
			</div>
	  </div>
	 </form>
	  <div id="form02" style="display:none">
	  </div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">考试相关信息</h4>
            </div>
            	<!-- 信息 -->
            	<div style="padding: 40px 40px 10px;">
				    <form id="uploadForm" class="bs-example bs-example-form" role="form" action="<%=path%>/Paper/upload.do"  method="post" enctype="multipart/form-data">
				        <div class="input-group">
				            <span class="input-group-addon">试卷描述:</span>
				            <input id="pname" name="pname" type="text" class="form-control" placeholder="请输入试卷名称"/>
				        </div>
				        <br>
				        <div class="input-group">
				            <span class="input-group-addon">考试时长:</span>
				            <input id="ptimes" name="ptimes" type="text" class="form-control" placeholder="请输入考试时长"/>
				            <span class="input-group-addon">hours</span>
				        </div>
				        <br>
				        <div class="input-group">
				            <span class="input-group-addon">开始时间:</span>
				            <input id="datetimepicker" name="datetimepicker" type="text" class="form-control" placeholder="请输入考试开始时间"/>
				        </div>
				        <br>
				         <div class="input-group">
				            <span class="input-group-addon">技能题目:</span>
				            <input name="uploadfile" type="file" id="file" multiple="multiple" />
				        </div>
				        <br>
				        <input type="hidden" name="qids"/>
				        <input type="hidden" name="qcourse"/>	 
				    </form>
				    
				</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="button03" type="button" class="btn btn-primary">提交信息</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<!-- /.modal -->
</div>
</body>
</html>