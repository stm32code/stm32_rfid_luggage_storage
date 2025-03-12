<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.GoodsInto" %>
<%@ page import="com.chengxusheji.po.Goods" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的goodsIntoObj信息
    List<Goods> goodsList = (List<Goods>)request.getAttribute("goodsList");
    GoodsInto goodsInto = (GoodsInto)request.getAttribute("goodsInto");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改物品入箱信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">物品入箱信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="goodsIntoEditForm" id="goodsIntoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="goodsInto_goodsintoId_edit" class="col-md-3 text-right">物品入箱id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="goodsInto_goodsintoId_edit" name="goodsInto.goodsintoId" class="form-control" placeholder="请输入物品入箱id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="goodsInto_goodsIntoObj_goodsId_edit" class="col-md-3 text-right">入箱物品:</label>
		  	 <div class="col-md-9">
			    <select id="goodsInto_goodsIntoObj_goodsId_edit" name="goodsInto.goodsIntoObj.goodsId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goodsInto_intoNumb_edit" class="col-md-3 text-right">入箱数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="goodsInto_intoNumb_edit" name="goodsInto.intoNumb" class="form-control" placeholder="请输入入箱数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goodsInto_intoTIme_edit" class="col-md-3 text-right">入箱时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date goodsInto_intoTIme_edit col-md-12" data-link-field="goodsInto_intoTIme_edit">
                    <input class="form-control" id="goodsInto_intoTIme_edit" name="goodsInto.intoTIme" size="16" type="text" value="" placeholder="请选择入箱时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goodsInto_goodsRfid_edit" class="col-md-3 text-right">物品rfid:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="goodsInto_goodsRfid_edit" name="goodsInto.goodsRfid" class="form-control" placeholder="请输入物品rfid">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxGoodsIntoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#goodsIntoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改物品入箱界面并初始化数据*/
function goodsIntoEdit(goodsintoId) {
	$.ajax({
		url :  basePath + "GoodsInto/" + goodsintoId + "/update",
		type : "get",
		dataType: "json",
		success : function (goodsInto, response, status) {
			if (goodsInto) {
				$("#goodsInto_goodsintoId_edit").val(goodsInto.goodsintoId);
				$.ajax({
					url: basePath + "Goods/listAll",
					type: "get",
					success: function(goodss,response,status) { 
						$("#goodsInto_goodsIntoObj_goodsId_edit").empty();
						var html="";
		        		$(goodss).each(function(i,goods){
		        			html += "<option value='" + goods.goodsId + "'>" + goods.goodsName + "</option>";
		        		});
		        		$("#goodsInto_goodsIntoObj_goodsId_edit").html(html);
		        		$("#goodsInto_goodsIntoObj_goodsId_edit").val(goodsInto.goodsIntoObjPri);
					}
				});
				$("#goodsInto_intoNumb_edit").val(goodsInto.intoNumb);
				$("#goodsInto_intoTIme_edit").val(goodsInto.intoTIme);
				$("#goodsInto_goodsRfid_edit").val(goodsInto.goodsRfid);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交物品入箱信息表单给服务器端修改*/
function ajaxGoodsIntoModify() {
	$.ajax({
		url :  basePath + "GoodsInto/" + $("#goodsInto_goodsintoId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#goodsIntoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#goodsIntoQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse > a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*入箱时间组件*/
    $('.goodsInto_intoTIme_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    goodsIntoEdit("<%=request.getParameter("goodsintoId")%>");
 })
 </script> 
</body>
</html>

