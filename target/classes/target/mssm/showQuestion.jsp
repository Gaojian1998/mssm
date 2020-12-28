<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%    String path=request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="top.jsp"/>
<title>试卷展示</title>
<script type="text/javascript">
      $(function() {
    	  //展示试卷题目
    	  showQuestion();
	   })
	   function showQuestion() {
    	  //接受跳转页面传递过来的数据
    	  var qids='${qids}';
		$.ajax({
			type:"post",
			url:"<%=path%>/paperManager/getQuestion.do",
			data:{"qids":qids},
			dataType:"json",
			success:function(res){
				//[Question [id=466, qanswer=null, qname=java不是一种语言吗, qscore=0.0, qtype=判断题, qcourse=null, qstage=null, options=[Option [id=468, opcontent=错, qid=0], Option [id=467, opcontent=对, qid=0]]], 
				//Question [id=438, qanswer=null, qname=以下代码执行的结果是 <br>for (int i=2;i<=10;i++){<br>if(i%2==0){ break;}System.out.println(i);}, qscore=0.0, qtype=单选题, qcourse=null, qstage=null, options=[Option [id=439, opcontent=A、 1, qid=0], Option [id=440, opcontent=B、 2, qid=0], Option [id=441, opcontent=C、 没有结果, qid=0], Option [id=442, opcontent=D、 编译报错, qid=0]]], 
				//Question [id=433, qanswer=null, qname=下列数组格式正确的是, qscore=0.0, qtype=单选题, qcourse=null, qstage=null, options=[Option [id=434, opcontent=A、 int[]  arry=new int[]{}, qid=0], Option [id=435, opcontent=B、 int  arry=new int[]{}, qid=0], Option [id=436, opcontent=C、 int[]  arry={‘a’,2,4}, qid=0], Option [id=437, opcontent=D、 int  arry=new int[4], qid=0]]], Question [id=387, qanswer=null, qname=下列数据类型的精度由高到低的顺序是, qscore=0.0, qtype=单选题, qcourse=null, qstage=null, options=[Option [id=390, opcontent=C、 byte,long,double,float, qid=0], Option [id=391, opcontent=D、 double,int,flaot,long, qid=0], Option [id=388, opcontent=A、 double,int,long,float, qid=0], Option [id=389, opcontent=B、 double,float,int,byte, qid=0]]], Question [id=458, qanswer=null, qname=下列三目运算符表达式正确的是:, qscore=0.0, qtype=多选题, qcourse=null, qstage=null, options=[Option [id=459, opcontent=A、 3=3?true:false, qid=0], Option [id=460, opcontent=B、  (1+1>0 && 3>2)?true:false, qid=0], Option [id=461, opcontent=C、 4>3?false:true , qid=0], Option [id=462, opcontent=D、 4>3:false?true, qid=0]]], Question [id=453, qanswer=null, qname=下列数组格式正确的是, qscore=0.0, qtype=多选题, qcourse=null, qstage=null, options=[Option [id=454, opcontent=A、 int[]  arry=new int[]{}, qid=0], Option [id=455, opcontent=B、 int  arry=new int[]{}, qid=0], Option [id=456, opcontent=C、 int[]  arry={‘a’,2,4}, qid=0], Option [id=457, opcontent=D、  int  arry=new int[4], qid=0]]]]
				var html="";
				for(var i in res){
					var obj=res[i];
					 var innerhtml="";
					for(var j in obj.options){
						var option=obj.options[j];
						innerhtml+="<div class=\"panel-body\">"+option.opcontent+"</div>";
					} 
					html+="<div class=\"panel panel-success\"><div class=\"panel-heading\"><h3 class=\"panel-title\">"+(1+parseInt(i))+"、("+obj.qtype+")"+obj.qname+"</h3></div>"+innerhtml+"</div>";
				}
				$("[class='container']").html(html);
			}
		})
	  }
</script>
</head>
<body>
   <div class="container" style="margin-top:60px;">
       
	
   </div>
</body>
</html>