<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String path=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<%=path %>/bootstrap/css/bootstrap.min.css" />
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
   $(function(){
	   //将多选、判断题隐藏 
	   $("[class='form-group more']").hide();
	   $("[class='form-group pd']").hide();
	   var zy=[{"id":8,"name":"java"},{"id":9,"name":"大数据"},{"id":10,"name":"UI设计"},{"id":11,"name":"AI智能"},{"id":12,"name":"网络营销"}];
	   var zyoption="";
	   for(var i in zy){
		   zyoption+="<option value="+zy[i].id+">"+zy[i].name+"</option>"
	   }
	   $("#zy").html(zyoption);
	   
	   $("#zy").change(function(){
		   $("#zy option").each(function(){
			   if($(this).prop("selected")){
				   $("#span_zy").text($(this).text());
			   }
		   })
	   })
	   
	   var jd=[{"id":4,"name":"第一阶段"},{"id":5,"name":"第二阶段"},{"id":6,"name":"第三阶段"},{"id":7,"name":"第四阶段"}];
	   var jdoption="";
	   for(var i in jd){
		   jdoption+="<option value="+jd[i].id+">"+jd[i].name+"</option>"
	   }
	   $("#jd").html(jdoption);
	   $("#jd").change(function(){
		   $("#jd option").each(function(){
			   if($(this).prop("selected")){
				   $("#span_jd").text($(this).text());
			   }
		   })
	   })
	   
	   var lx=[{"id":1,"name":"单选"},{"id":2,"name":"多选"},{"id":3,"name":"判断"}];
	   var lxoption="";
	   for(var i in lx){
		   lxoption+="<option value="+lx[i].id+">"+lx[i].name+"</option>"
	   }
	   $("#lx").html(lxoption);
	   $("#lx").change(function(){
		   if($(this).val()==2){
			   $("[class='form-group single']").hide();
			   $("[class='form-group pd']").hide();
			   $("[class='form-group more']").show();
		   }else if($(this).val()==3){
			   $("[class='form-group single']").hide();
			   $("[class='form-group more']").hide();
			   $("[class='form-group pd']").show();
		   }else if($(this).val()==1){
			   $("[class='form-group more']").hide();
			   $("[class='form-group pd']").hide();
			   $("[class='form-group single']").show();
		   }
		   $("#lx option").each(function(){
			   if($(this).prop("selected")){
				   $("#span_lx").text($(this).text());
			   }
		   })
	   })
	   
	   $("[name='score']").click(function(){
		   $("[name='score']").each(function(){
			   if($(this).prop("checked")){
				   $("#span_fz").text($(this).val());
			   }
		   })
	   })
	   
	   $("#quest").on("keyup change",function(){
		   $("#span_wt").text($(this).val());
	   })

	   //取答案
	   $("[name='single']").click(function(){
		   $("[name='single']").each(function(){
			   if($(this).prop("checked")){
				   $("#span_da").text($(this).val());
			   }
		   })
	   })
	   $("[name='pd']").click(function(){
		   $("[name='pd']").each(function(){
			   if($(this).prop("checked")){
				   $("#span_da").text($(this).val());
			   }
		   })
	   })
	   $("[name='more']").click(function(){
		   var da="";
		   $("[name='more']").each(function(){
			   if($(this).prop("checked")){
				   if(da==""){
					   da+=$(this).val();
				   }else{
					   da+=","+$(this).val();
				   }
			   }
		   })
		   $("#span_da").text(da);
	   })
	   
	   
	   $("[value='提交']").click(function(){
		   var zy=$("#zy").val();
		   var jd=$("#jd").val();
		   var lx=$("#lx").val();
		   var fz=$("#span_fz").text();
		   var wt=$("#quest").val();
		   var da=$("#span_da").text();
 	       var items="";
		   if($("#lx").val()==1){
			   items=getItems(0);
		   }else if($("#lx").val()==2){
			   items=getItems(1);
		   }else if($("#lx").val()==3){
			   items="对,错";
		   }
		   alert(items);
	   })
	   
   })
   
   function getItems(type){
	   var itema=$("[placeholder='选项A']").eq(type).val();
	   var itemb=$("[placeholder='选项B']").eq(type).val();
	   var itemc=$("[placeholder='选项C']").eq(type).val();
	   var itemd=$("[placeholder='选项D']").eq(type).val();
	   return itema+","+itemb+","+itemc+","+itemd;
   }
</script>
<title>题库维护</title>
</head>
<body>
<div class="container">
   <div style="border: 1px solid black;float: left;width: 50%">
      <p class="text-center">题目添加</p>
      <hr>
      <form class="form-horizontal" role="form">
		  <div class="form-group">
			    <div class="col-xs-offset-2 col-xs-8">
	      			<div class="input-group">
	      				<div class="input-group-addon">学科专业</div>
	      				<select class="form-control input-sm" id="zy">
	      				   
						</select>
	    			</div>
	    		</div>
		  </div>
		  <div class="form-group">
			    <div class="col-xs-offset-2 col-xs-8">
	      			<div class="input-group">
	      				<div class="input-group-addon">专业阶段</div>
	      				<select class="form-control input-sm" id="jd">
						</select>
	    			</div>
	    		</div>
		  </div>
		  <div class="form-group">
			    <div class="col-xs-offset-2 col-xs-8">
	      			<div class="input-group">
	      				<div class="input-group-addon">题目类型</div>
	      				<select class="form-control input-sm" id="lx">
						</select>
	    			</div>
	    		</div>
		  </div>
		  <div class="form-group">
			    <div class="col-xs-offset-2 col-xs-8">
	      			<div class="input-group">
	      				<div class="input-group-addon">题目分值</div>
	      				
					    <label class="radio-inline" style="margin-left: 20px;">
					        <input type="radio" name="score"  value="1"> 1分
					    </label>
					    <label class="radio-inline">
					        <input type="radio" name="score"  value="2"> 2分
					    </label>
					    <label class="radio-inline">
					        <input type="radio" name="score"  value="3" checked> 3分
					    </label>
					    <label class="radio-inline">
					        <input type="radio" name="score"  value="4"> 4分
					    </label>
					    <label class="radio-inline">
					        <input type="radio" name="score"  value="5"> 5分
					    </label>
	    			</div>
	    		</div>
		  </div>
		  <div class="form-group">
			    <div class="col-xs-offset-2 col-xs-8">
	      			<textarea class="form-control" rows="3" placeholder="请输入问题" id="quest"></textarea>
	    		</div>
		  </div>
		  <!-- 单选按钮组 -->
		  <div class="form-group single">
			    <div class="col-xs-offset-2 col-xs-8">
	      			<div class="input-group">
	      				<div class="input-group-addon">A<input type="radio" name="single"  value="A"></div>
	      				<input type="text" class="form-control" placeholder="选项A">
	    			</div>
	    		</div>
		  </div>
		  <div class="form-group single">
			    <div class="col-xs-offset-2 col-xs-8">
	      			<div class="input-group">
	      				<div class="input-group-addon">B<input type="radio" name="single"  value="B"></div>
	      				<input type="text" class="form-control" placeholder="选项B">
	    			</div>
	    		</div>
		  </div>
		  <div class="form-group single">
			    <div class="col-xs-offset-2 col-xs-8">
	      			<div class="input-group">
	      				<div class="input-group-addon">C<input type="radio" name="single"  value="C"></div>
	      				<input type="text" class="form-control" placeholder="选项C">
	    			</div>
	    		</div>
		  </div>
		  <div class="form-group single">
			    <div class="col-xs-offset-2 col-xs-8">
	      			<div class="input-group">
	      				<div class="input-group-addon">D<input type="radio" name="single"  value="D"></div>
	      				<input type="text" class="form-control" placeholder="选项D">
	    			</div>
	    		</div>
		  </div>
		  <!-- 多选按钮组 -->
		  <div class="form-group more">
			    <div class="col-xs-offset-2 col-xs-8">
	      			<div class="input-group">
	      				<div class="input-group-addon">A<input type="checkbox" name="more" value="A"></div>
	      				<input type="text" class="form-control" placeholder="选项A">
	    			</div>
	    		</div>
		  </div>
		  <div class="form-group more">
			    <div class="col-xs-offset-2 col-xs-8">
	      			<div class="input-group">
	      				<div class="input-group-addon">B<input type="checkbox" name="more" value="B"></div>
	      				<input type="text" class="form-control" placeholder="选项B">
	    			</div>
	    		</div>
		  </div>
		  <div class="form-group more">
			    <div class="col-xs-offset-2 col-xs-8">
	      			<div class="input-group">
	      				<div class="input-group-addon">C<input type="checkbox" name="more" value="C"></div>
	      				<input type="text" class="form-control" placeholder="选项C">
	    			</div>
	    		</div>
		  </div>
		  <div class="form-group more">
			    <div class="col-xs-offset-2 col-xs-8">
	      			<div class="input-group">
	      				<div class="input-group-addon">D<input type="checkbox" name="more" value="D"></div>
	      				<input type="text" class="form-control" placeholder="选项D">
	    			</div>
	    		</div>
		  </div>
		  
		  <!-- 判断题 -->
		  <div class="form-group pd">
			    <div class="col-xs-offset-2 col-xs-8">
			        <div class="input-group">
	      				<div class="input-group-addon"><input type="radio" name="pd"  value="对"></div>
	      				<input type="button" class="form-control" value="对" >
	    			</div>
	    		</div>
		  </div>
		  <div class="form-group pd">
		       <div class="col-xs-offset-2 col-xs-8">
				    <div class="input-group">
	      				<div class="input-group-addon"><input type="radio" name="pd"  value="错"></div>
	      				<input type="button" class="form-control" value="错" >
	    			</div>
    			</div>
		  </div>
		</form>
   </div>
   <div style="border: 1px sold red;float: left;background-color: gray;width: 50%;">
      <p class="text-center">题目预览</p>
      <hr>
      <div class="col-xs-offset-2 col-xs-8">
	      	<ul class="list-group">
			    <li class="list-group-item">专业:<span id="span_zy">java</span></li>
			    <li class="list-group-item">阶段:<span id="span_jd">第一阶段</span></li>
			    <li class="list-group-item">类型:<span id="span_lx">单选题</span></li>
			    <li class="list-group-item">分值:<span id="span_fz">3</span>分</li>
			    <li class="list-group-item">题目:<br><span id="span_wt">java面向对象的三大特征是什么？请详细描述,用自己的专业知识解答</span></li>
			    <li class="list-group-item">答案:<span id="span_da">A</span></li>
			</ul>
	  </div>
      <div class="col-xs-offset-2 col-xs-8">
	     <input type="button" class="form-control btn btn-primary" value="提交" >
	  </div>
   </div>

</div>
</body>
</html>