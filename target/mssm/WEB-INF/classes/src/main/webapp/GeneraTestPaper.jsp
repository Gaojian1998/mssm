<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String path=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="top.jsp"></jsp:include>
<title>生成试卷</title>
<script type="text/javascript">
     $(function() {
		//展示下拉列表
    	 togetQuery();
		//随机抽取题目
    	 randomSelTop();
	})
	//展示下拉列表
	function togetQuery() {
		$.ajax({
			type:"post",
			url:"<%=path%>/generaPaper/togetQueryBytid.do",
			data:{},
			dataType:"json",
			success:function(res){
				//{"listType0":[{"type":"0","typeid":1,"typename":"单选题"},{"type":"0","typeid":2,"typename":"多选题"},{"type":"0","typeid":3,"typename":"判断题"}],
			   //"listType2":[{"type":"2","typeid":8,"typename":"java"},{"type":"2","typeid":9,"typename":"大数据"},{"type":"2","typeid":10,"typename":"UI设计"},{"type":"2","typeid":11,"typename":"AI智能"},{"type":"2","typeid":12,"typename":"网络营销"}]}
				var html="";
				for(var i in res.listType0){
					var obj=res.listType0[i];
					html+=" <option value="+obj.typeid+">"+obj.typename+"</option>";
				}
				$("[class='form-control']:eq(3)").html(html);
				var htm="";
				for(var i in res.listType2){
					var obj=res.listType2[i];
					htm+=" <option value="+obj.typeid+">"+obj.typename+"</option>";
				}
				$("[class='form-control']:eq(4)").html(htm);
			}
		})
	}
     function randomSelTop() {
		$("[class='btn btn-success']").click(function() {
			//获取条件
			var singChNum=$("#singleChoose").val();
			var moreChNum=$("#moreChoose").val();
			var judegeNum=$("#judege").val();
			var couresTyp=$("[class='form-control']:eq(3)").val();
			var statgesTyp=$("[class='form-control']:eq(4)").val();
			$.ajax({
				type:"post",
				url:"<%=path%>/generaPaper/torandomSelTop.do",
				data:{"singChNum":singChNum,"moreChNum":moreChNum,"judegeNum":judegeNum,"couresTyp":couresTyp,"statgesTyp":statgesTyp},
				dataType:"json",
				success:function(res){
				 //[{"id":387,"options":[{"id":390,"opcontent":"C、 byte,long,double,float","qid":387},{"id":391,"opcontent":"D、 double,int,flaot,long","qid":387},{"id":388,"opcontent":"A、 double,int,long,float","qid":387},{"id":389,"opcontent":"B、 double,float,int,byte","qid":387}],"qanswer":"B","qcourse":"java","qname":"下列数据类型的精度由高到低的顺序是","qscore":5.0,"qstage":"4","qtype":"单选题"},{"id":428,"options":[{"id":429,"opcontent":"A、 public void getName{}","qid":428},{"id":430,"opcontent":"B、  int void getValue(int n)","qid":428},{"id":431,"opcontent":"C、 void getAge(){}","qid":428},{"id":432,"opcontent":"D、 getName(){}","qid":428}],"qanswer":"C","qcourse":"java","qname":"下列方法格式正确的是 ","qscore":5.0,"qstage":"4","qtype":"单选题"},{"id":408,"options":[{"id":409,"opcontent":"A、 ”+”","qid":408},{"id":410,"opcontent":"B、 ”++”","qid":408},{"id":411,"opcontent":"C、 ”=”","qid":408},{"id":412,"opcontent":"D、 ”%”","qid":408}],"qanswer":"B","qcourse":"java","qname":"下列哪些不属于算术运算符 ","qscore":5.0,"qstage":"4","qtype":"单选题"},{"id":458,"options":[{"id":459,"opcontent":"A、 3=3?true:false","qid":458},{"id":460,"opcontent":"B、  (1+1>0 && 3>2)?true:false","qid":458},{"id":461,"opcontent":"C、 4>3?false:true ","qid":458},{"id":462,"opcontent":"D、 4>3:false?true","qid":458}],"qanswer":"BC","qcourse":"java","qname":"下列三目运算符表达式正确的是:","qscore":10.0,"qstage":"4","qtype":"多选题"},{"id":453,"options":[{"id":454,"opcontent":"A、 int[]  arry=new int[]{}","qid":453},{"id":455,"opcontent":"B、 int  arry=new int[]{}","qid":453},{"id":456,"opcontent":"C、 int[]  arry={‘a’,2,4}","qid":453},{"id":457,"opcontent":"D、  int  arry=new int[4]","qid":453}],"qanswer":"AC","qcourse":"java","qname":"下列数组格式正确的是","qscore":10.0,"qstage":"4","qtype":"多选题"},{"id":801,"options":[],"qanswer":"BCD","qcourse":"java","qname":"是个多选题","qscore":6.0,"qstage":"4","qtype":"多选题"},{"id":466,"options":[{"id":468,"opcontent":"错","qid":466},{"id":467,"opcontent":"对","qid":466}],"qanswer":"错","qcourse":"java","qname":"java不是一种语言吗","qscore":5.0,"qstage":"4","qtype":"判断题"},{"id":808,"options":[],"qanswer":"错","qcourse":"java","qname":"谁对谁错","qscore":3.0,"qstage":"4","qtype":"判断题"},{"id":809,"options":[],"qanswer":"错","qcourse":"java","qname":"时尚","qscore":3.0,"qstage":"4","qtype":"判断题"}]
				var html="";
					for(var i in res){
						var obj=res[i];
						var innerhtml="";
						for(var j in obj.options){
							var ob=obj.options[j];
							innerhtml+=" <div class=\"panel-body\">"+ob.opcontent+"</div>";
						}
						html+="<div class=\"panel panel-success\"><div class=\"panel-heading\"><h3 class=\"panel-title\">"+(parseInt(i)+1)+"、("+obj.qtype+")"+obj.qname+"</h3></div>"+innerhtml+"</div>"; 
					}
					$("#model").html(html);
				}
			})
		})
	}
</script>
</head>
<body>
	     <div class="container" style="margin-top:60px;">
			<form class="form-inline" role="form">
				<div class="form-group">
					<label  for="name">单选题:</label>
					<input type="text" class="form-control" id="singleChoose"  placeholder="请输入名称" style="width: 150px">
				</div>
				<div class="form-group">
					<label  for="name">多选题:</label>
					<input type="text" class="form-control" id="moreChoose" placeholder="请输入名称" style="width: 150px">
				</div>
				<div class="form-group">
					<label  for="name">判断题:</label>
					<input type="text" class="form-control" id="judege" placeholder="请输入名称" style="width: 150px">
				</div>
				<div class="form-group">
				    <label  for="name">课程:</label>
					<select class="form-control" style="width: 120px">
					       <option value=""></option>
					</select>
				</div>
				<div class="form-group">
				    <label  for="name" >阶段:</label>
					<select class="form-control" style="width: 120px">
					  
					</select>
				</div>
				<button type="button" class="btn btn-success">生成试卷</button>
				<button type="button" class="btn btn-info">保存试卷</button>
			</form>
		</div>
		<!--试卷部分-->
		<div class="container" style="margin-top:30px;" id="model">
		    <!--  <div class="panel-body">
										这是一个基本的面板
									</div>
									<div class="panel-body">
										这是一个基本的面板
									</div> -->
		</div>
</body>
</html>