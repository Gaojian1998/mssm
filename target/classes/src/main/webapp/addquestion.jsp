<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String path=request.getContextPath();%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link  rel="stylesheet" href="<%=path%>/bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="<%=path%>/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/bootstrap/js/bootstrap.min.js"></script>
<title>addquestion</title>
<script type="text/javascript">
$(function() {
	var profer=0;
	var stage=0;
	var qtype=0;
	var mainid=0;
	//学科专业
	getProfo();
	//专业阶段
	getStage();
	//题目类型
	getQtype();
	//同步显示数据
	synDisplayData();
	//清空数据
	clean();
	//提交表单
	submit();
})
////学科专业
function getProfo() {
	$.ajax({
		type:"post",
		url:"<%=path%>/question/toDropdown.do",
		data:{"m":"2"},
		dataType:"json",
		success:function(res){
			//[Type [typeid=1, typename=单选题, type=0], Type [typeid=2, typename=多选题, type=0], Type [typeid=3, typename=判断题, type=0]]
			var html="";
			html="<option value=''>请选择专业</option>";
			for(var i in res){
				html+="<option value="+res[i].typeid+">"+res[i].typename+"</option>";
			}
			$("[class='form-control']:eq(0)").html(html);
		}
	})
}
function getStage() {
	$.ajax({
		type:"post",
		url:"<%=path%>/question/toDropdown.do",
		data:{"m":"1"},
		dataType:"json",
		success:function(res){
			//[Type [typeid=1, typename=单选题, type=0], Type [typeid=2, typename=多选题, type=0], Type [typeid=3, typename=判断题, type=0]]
			var html="";
			html="<option value=''>请选择学业阶段</option>";
			for(var i in res){
				html+="<option value="+res[i].typeid+">"+res[i].typename+"</option>";
			}
			$("[class='form-control']:eq(1)").html(html);
		}
	})
}
//题目类型
function getQtype() {
	$.ajax({
		type:"post",
		url:"<%=path%>/question/toDropdown.do",
		data:{"m":"0"},
		dataType:"json",
		success:function(res){
			//[Type [typeid=1, typename=单选题, type=0], Type [typeid=2, typename=多选题, type=0], Type [typeid=3, typename=判断题, type=0]]
			var html="";
			html="<option value=''>请选择题目类型</option>";
			for(var i in res){
				html+="<option value="+res[i].typeid+">"+res[i].typename+"</option>";
			}
			$("[class='form-control']:eq(2)").html(html);
		}
	})
}
//同步显示数据
function synDisplayData() {
	//隐藏判断
	$("#judgeDemo").hide();
	$("#morechooseDemo").hide();
	//学科专业
	$("[class='form-control']:eq(0)").click(function() {
		//alert("进来了");
		 $("[class='form-control']:eq(0) option").each(function(){
			var obj=$(this).prop("selected");
			if($(this).prop("selected")){
				//$("tbody tr:eq(0) td:eq(1)").text();
				$("#profer").val($(this).text());
				//穿id给name属性
				var id=$(this).val();
				$("#profer").prop('name',id);
				profer=$("#profer").prop("name");
			}
		})
	})
	//学业阶段
	$("[class='form-control']:eq(1)").click(function() {
		//alert("进来了");
		 $("[class='form-control']:eq(1) option").each(function(){
			var obj=$(this).prop("selected");
			if($(this).prop("selected")){
				//$("tbody tr:eq(0) td:eq(1)").text();
				$("#stage").val($(this).text());
				//穿id给name属性
				var id=$(this).val();
				$("#stage").prop('name',id);
				stage=$("#stage").prop("name");
			}
		})
	})
	//题目类型
	$("[class='form-control']:eq(2)").click(function() {
		//alert("进来了");
		 $("[class='form-control']:eq(2) option").each(function(){
			var obj=$(this).prop("selected");
			if($(this).prop("selected")){
				//$("tbody tr:eq(0) td:eq(1)").text();
				$("#qtype").val($(this).text());
				//判断题时隐藏div
				var id=$(this).val();
				//alert(id);
				$("#qtype").prop('name',id);
				qtype=$("#qtype").prop("name");
				if(id==parseInt(3)){
					$("#judgeDemo").attr("style","display:block;");//显示div
					$("#singlechooseDemo").attr("style","display:none;");//隐藏div
					$("#morechooseDemo").attr("style","display:none;");//隐藏div
					judgeChoose();
				}else if(id==parseInt(1)){
					$("#singlechooseDemo").show();
					$("#morechooseDemo").attr("style","display:none;");//隐藏div
					$("#judgeDemo").attr("style","display:none;");//隐藏div
					//单选方法
					singleChoose();
				}else{
					//$("#morechooseDemo").attr("style","display:block;");//显示div
					$("#morechooseDemo").show();
					$("#singlechooseDemo").hide();
					//$("#singlechooseDemo").attr("style","display:none;");//隐藏div
					$("#judgeDemo").attr("style","display:none;");//隐藏div
					//多选
					moreChoose();
				}
			}
		})
	})
	$("input:eq(0)").mouseleave(function() {
		//打印name属性重新赋值后的name属性值
		//alert($("#profer").prop("name"));alert($("#stage").prop("name"));alert($("#qtype").prop("name"));
		//alert($(this).val());
		$("#score").val($(this).val());
	})
	$("input:eq(1)").mouseleave(function() {
		//alert($(this).val());
		$("#question").val($(this).val());
	})
}
//单选题
function singleChoose() {
	    var i=0;
    	$("#A").click(function() {
    		if(i<1){
    			$("#A").attr("class","form-control btn-success");
        		$("#answer").val("A");
        		i=i+1;
    		}else{
    			$("#answer").val(" ");
    			$("#A").attr("class","form-control");
    			i=i-1;
    		}
    	})
    	var k=0;
    	$("#B").click(function() {
    		if(k<1){
    			$("#B").attr("class","form-control btn-success");
        		$("#answer").val("B");
        		k=k+1;
    		}else{
    			$("#answer").val(" ");
    			$("#B").attr("class","form-control");
    			k=k-1;
    		}
    	})
    	var j=0;
    	$("#C").click(function() {
    		if(j<1){
    			$("#C").attr("class","form-control btn-success");
        		$("#answer").val("C");
        		j=j+1;
    		}else{
    			$("#answer").val(" ");
    			$("#C").attr("class","form-control");
    			j=j-1;
    		}
    	})
    	 var n=0;
    	$("#D").click(function() {
    		if(n<1){
    			$("#D").attr("class","form-control btn-success");
        		$("#answer").val("D");
        		n=n+1;
    		}else{
    			$("#answer").val(" ");
    			$("#D").attr("class","form-control");
    			n=n-1;
    		}
    	})
} 
//多选
function moreChoose() {
    var m=0;
	var morechoose="";
	//var checkedclass="form-control btn-success";
		/* var x="";
		$("#E").click(function() {
			alert($("#E").attr("class"));
    		if(checkedclass!=$(this).prop("class")){
    			$("#E").attr("class","form-control btn-success");
    			if(x==""){	
    				x="A";
   				}
    			m=m+1;alert(m);
        		morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}else{
    				$("#E").attr("class","form-control");
        			x="";
        			m=m-1;alert(m);
        			morechoose=x+y+z+w;
        			$("#answer").val(morechoose);
    		} 
    	}) 
    	 var y="";
    	$("#F").click(function() {
    		if(checkedclass!=$(this).prop("class")){
    			$("#F").attr("class","form-control btn-success");
    			if(y==""){
    				y="B";
   				}
        		m=m+1;alert(m);
        		morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}else{
    			$("#F").attr("class","form-control");
    			y="";
    			m=m-1;alert(m);
    			morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}
    	}) 
    	var z="";
    	$("#G").click(function() {
    		alert($("#G").attr("class"));
    		if(checkedclass!=$(this).prop("class")){
    			$("#G").attr("class","form-control btn-success");
    			if(z==""){
    				z="C";
   				}
        		m=m+1;alert(m);
        		morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}else{
    			$("#G").attr("class","form-control");
    			z="";
    			m=m-1;alert(m);
    			morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		} 
    	})
    	var w="";
    	$("#H").click(function() {
    		if(checkedclass!=$(this).prop("class")){
    			$("#H").attr("class","form-control btn-success");
    			if(w==""){
    				w="D";
   				}
        		m=m+1;alert(m);
        		morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}else{
    			$("#H").attr("class","form-control");
    			w="";
    			m=m-1;alert(m);
    			morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}
    	}) */
    	var i=0;
    	var x="";
    	$("#E").click(function() {
    		if(i<1){
    			$("#E").attr("class","form-control btn-success");
        		i=i+1;
        		x="A";
        		morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}else{
    			$("#E").attr("class","form-control");
    			i=i-1;
    			x="";
    			morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}
    	})
    	var k=0;
    	var y="";
    	$("#F").click(function() {
    		if(k<1){
    			$("#F").attr("class","form-control btn-success");
        		k=k+1;
        		y="B";
        		morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}else{
    			$("#F").attr("class","form-control");
    			k=k-1;
    			y="";
        		morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}
    	})
    	var j=0;
    	var z="";
    	$("#G").click(function() {
    		if(j<1){
    			$("#G").attr("class","form-control btn-success");
        		$("#answer").val("G");
        		j=j+1;
        		z="C";
        		morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}else{
    			$("#answer").val(" ");
    			$("#G").attr("class","form-control");
    			j=j-1;
    			z="";
        		morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}
    	})
    	 var n=0;
    	var w="";
    	$("#H").click(function() {
    		if(n<1){
    			$("#H").attr("class","form-control btn-success");
        		$("#answer").val("H");
        		n=n+1;
        		w="D";
        		morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}else{
    			$("#answer").val(" ");
    			$("#H").attr("class","form-control");
    			n=n-1;
    			w="";
        		morechoose=x+y+z+w;
    			$("#answer").val(morechoose);
    		}
    	})
}
//判断
function judgeChoose(){
	 var i=0;
 	$("#yes").click(function() {
 		if(i<1){
 			$("#yes").attr("class","form-control btn-success");
     		$("#answer").val("对");
     		i=i+1;
 		}else{
 			$("#answer").val(" ");
 			$("#yes").attr("class","form-control");
 			i=i-1;
 		}
 	})
 	var k=0;
 	$("#No").click(function() {
 		if(k<1){
 			$("#No").attr("class","form-control btn-success");
     		$("#answer").val("错");
     		k=k+1;
 		}else{
 			$("#answer").val(" ");
 			$("#No").attr("class","form-control");
 			k=k-1;
 		}
 	})
}
//清空表单选项
function clean() {
	/* $("[class='btn btn-warning btn-lg']").click(function() {
		
	}) */
}
function submit() {
	$("#submit").click(function() {
		$.ajax({
			type:"post",
			url:"<%=path%>/addQuestion/toaddQuest.do",
			data:{"qanswer":$("#answer").val(),"qname":$("#question").val(),"qscore":$("#score").val(),"qtype":qtype,"qcourse":profer,"qstage":stage},
			dataType:"text",
			success:function(res){
				alert(res);
				 mainid=res;
				//"781"
				if(qtype==1){
					addchoose();
				}else if(qtype==2){
					addmorechoose();
				}else if(qtype==3){
					addjudge();
				}
				
			}
		})
	})
}
//增加选项
function addchoose() {
	var achoose=$("#A").val();
	var bchoose=$("#B").val();
	var cchoose=$("#C").val();
	var dchoose=$("#D").val();
	$.ajax({
		type:"post",
		url:"<%=path%>/addQuestion/toaddChoose.do",
		data:{"achoose":achoose,"bchoose":bchoose,"cchoose":cchoose,"dchoose":dchoose},
		dataType:"text",
		success:function(res){
			if(res>0){
				alert("增加成功!");
			}
		}
	})
} 
function addmorechoose() {
	var achoose=$("#E").val();
	var bchoose=$("#F").val();
	var cchoose=$("#G").val();
	var dchoose=$("#H").val();
	$.ajax({
		type:"post",
		url:"<%=path%>/addQuestion/toaddChoose.do",
		data:{"achoose":achoose,"bchoose":bchoose,"cchoose":cchoose,"dchoose":dchoose},
		dataType:"text",
		success:function(res){
			if(res>0){
				alert("增加成功!");
			}
		}
	})
} 
function addjudge() {
	var yeschoose=$("#yes").val();
	var nochoose=$("#No").val();
	$.ajax({
		type:"post",
		url:"<%=path%>/addQuestion/toaddJudge.do",
		data:{"yeschoose":yeschoose,"nochoose":nochoose},
		dataType:"text",
		success:function(res){
			if(res>0){
				alert("增加成功!");
			}
		}
	})
} 
</script>
</head>
<body>
    <!--整个div容器-->
	<div id="container" style="width:100%">
	    <!--头标题-->
		<!-- <div id="header" style="background-color:#FFFFFF;height: 20px;">
			<h3 style="margin-bottom:0; color: #3E8E41;text-align: center;">试题</h3>
	    </div>  -->
	    <!--题目添加左-->
		<div id="menu" style="background-color:#FFFFFF;height:650px;width:49%;float:left;border: 1px solid #EEEEEE;">
			<h3 style="text-align: center;">题目添加</h3>
			<hr />
		<!--题目的选择栏左上-->
		<div style="padding: 6px 100px 10px; ">
			<form class="bs-example bs-example-form" role="form">
				<div class="input-group">
					<span class="input-group-addon" style="margin:100px,200px">学科专业</span>
				    <select class="form-control">
					      
					</select>
				</div>
				<br>
				<div class="input-group">
					<span class="input-group-addon" style="margin:100px,200px">学业阶段</span>
				    <select class="form-control">
		
					</select>
				</div>
				<br>
				<div class="input-group">
					<span class="input-group-addon" style="margin:100px,200px">题目类型</span>
				    <select class="form-control">
					      
					</select>
				</div>
				<br>
				<div class="input-group">
					<span class="input-group-addon" style="margin:100px,200px">题目分值</span>
				    <input type="text" class="form-control">
				</div>
			</form>
	    </div>
	    <hr/>
	    <!--题目-->
	    <input type="text"  class="form-control" style="width:430px;margin-left:90px"/>
	    <!--题目的选择栏左下-->
	    <!--单选-->
        <div id="singlechooseDemo">
			<div style="padding: 40px 100px 10px;">
				<form class="bs-example bs-example-form" role="form" id="123">
					<div class="input-group">
						<span class="input-group-addon" style="margin:100px,200px;background-color:white;"><button class="btn-default" style="padding:1px;border-color:white;"type="button">A</button></span>
					    <input type="text" class="form-control"  id="A">
					</div>
					<br>
					<div class="input-group">
						<span class="input-group-addon" style="margin:100px,200px;background-color:white;"><button class="btn-default" style="padding:1px;border-color:white;"type="button">B</button></span>
					    <input type="text" class="form-control"   id="B">
					</div>
					<br>
					<div class="input-group">
						<span class="input-group-addon" style="margin:100px,200px;background-color:white;"><button class="btn-default" style="padding:1px;border-color:white;"type="button">C</button></span>
					    <input type="text" class="form-control"  id="C">
					</div>
					<br>
					<div class="input-group">
						<span class="input-group-addon" style="margin:100px,200px;background-color:white;"><button class="btn-default" style="padding:1px;border-color:white;"type="button">D</button></span>
					    <input type="text" class="form-control" id="D">
					</div>
				</form>
			</div>
		</div>
		<!--多选-->
		<div id="morechooseDemo">
			<div style="padding: 40px 100px 10px;" >
				<form class="bs-example bs-example-form" role="form" id="456">
					<div class="input-group">
						<span class="input-group-addon" style="margin:100px,200px;background-color:white;"><button class="btn-default" style="padding:1px;border-color:white;"type="button">A</button></span>
					    <input type="text" class="form-control"  id="E">
					</div>
					<br>
					<div class="input-group">
						<span class="input-group-addon" style="margin:100px,200px;background-color:white;"><button class="btn-default" style="padding:1px;border-color:white;"type="button">B</button></span>
					    <input type="text" class="form-control"   id="F">
					</div>
					<br>
					<div class="input-group">
						<span class="input-group-addon" style="margin:100px,200px;background-color:white;"><button class="btn-default" style="padding:1px;border-color:white;"type="button">C</button></span>
					    <input type="text" class="form-control"  id="G">
					</div>
					<br>
					<div class="input-group">
						<span class="input-group-addon" style="margin:100px,200px;background-color:white;"><button class="btn-default" style="padding:1px;border-color:white;"type="button">D</button></span>
					    <input type="text" class="form-control" id="H">
					</div>
				</form>
			</div>
		</div>
		<div id="judgeDemo">
			<div style="padding: 40px 100px 10px;" >
				<form class="bs-example bs-example-form" role="form">
					<div class="input-group">
						<span class="input-group-addon" style="margin:100px,200px;background-color: green;"><button class="btn-success" style="padding:1px;border-color:green;"type="button">对</button></span>
					    <input type="text" class="form-control" id="yes">
					</div>
					<br>
					<div class="input-group">
						<span class="input-group-addon" style="margin:100px,200px;background-color: green;"><button class="btn-success" style="padding:1px;border-color:green;"type="button">错</button></span>
					    <input type="text" class="form-control" id="No">
					</div>
					<br>
				</form>
			</div>
		</div>
		</div>
	    <!--题目预览右-->
		<div id="content" style="background-color:azure;height:650px;width:49%;float:left;border: 1px solid #EEEEEE;">
			<h3 style="text-align: center;">题目预览</h3>
			<hr />
			<div style="background-color:#FFFFFF;height: 78%; width: 70%;margin-left: 90px; border: 1px solid #EEEEEE;">
				<form class="form-horizontal" role="form">
					<table style="height:500px;width:430px;border-color:#FFFFFF" border="1">
					   <tbody>
					      <tr style="height:50px;text-align: center;"> 
					         <td>专业:</td>
					         <td style="text-align: left;">
					             <input style="border: none;outline: none;" value="请选择专业" id="profer" name="123"/>
					         </td>
					      </tr>
					      <tr style="height:50px;text-align: center;">
					         <td>阶段:</td>
					         <td style="text-align: left;">
					             <input style="border: none;outline: none;" value="请学业选择阶段" id="stage" name="123"/>
					         </td>
					      </tr>
					      <tr style="height:50px;text-align: center;"> 
					         <td>类型:</td>
					         <td style="text-align: left;">
					             <input style="border: none;outline: none;"value="请选择题目类型" id="qtype" name="123"/>
					         </td>
					      </tr>
					      <tr style="height:50px;text-align: center;">	
					         <td>题目:</td>
					         <td style="text-align: left;">
					         <input style="width:360px;height:80px;border: none;outline: none;"value="请描述题目" id="question"/>
					         </td>
					      </tr>
					      <tr style="height:50px;text-align: center;"> 
					         <td>分值:</td>
					         <td style="text-align: left;">
					         <input style="border: none;outline: none;"value="请填写题目分值" id="score"/>
					         </td>
					      </tr>
					       <tr style="height:50px;text-align: center;">
					         <td>答案:</td>
					         <td style="text-align: left;">
					         <input style="border: none;outline: none;" value="请选择题目答案" id="answer"/>
					         </td>
					      </tr>
					   </tbody>
					</table>
	           </form>
		   </div>
		</div>
	    <!--清空提交-->
		<div id="footer" style="background-color:#FFFFFF;clear:both;text-align:center;height: 50px;width: 98.3%;border: 1px solid #EEEEEE;">
			<!-- 表示应谨慎采取的动作 -->
            <button type="button" class="btn btn-warning btn-lg" style="margin-left: -600px">清空</button>
            <!-- 表示一个成功的或积极的动作 -->
            <button type="button" class="btn btn-success btn-lg" style="margin-left: 200px" id="submit">提交</button>
		</div>
	
	</div>
 
</body>
</html>