<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.GoodsType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    GoodsType goodsType = (GoodsType)request.getAttribute("goodsType");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改物品类型信息</TITLE>
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
  		<li class="active">物品类型信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="goodsTypeEditForm" id="goodsTypeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="goodsType_goodTypeId_edit" class="col-md-3 text-right">物品类型id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="goodsType_goodTypeId_edit" name="goodsType.goodTypeId" class="form-control" placeholder="请输入物品类型id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="goodsType_goodTypeName_edit" class="col-md-3 text-right">类型名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="goodsType_goodTypeName_edit" name="goodsType.goodTypeName" class="form-control" placeholder="请输入类型名称">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxGoodsTypeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#goodsTypeEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改物品类型界面并初始化数据*/
function goodsTypeEdit(goodTypeId) {
	$.ajax({
		url :  basePath + "GoodsType/" + goodTypeId + "/update",
		type : "get",
		dataType: "json",
		success : function (goodsType, response, status) {
			if (goodsType) {
				$("#goodsType_goodTypeId_edit").val(goodsType.goodTypeId);
				$("#goodsType_goodTypeName_edit").val(goodsType.goodTypeName);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交物品类型信息表单给服务器端修改*/
function ajaxGoodsTypeModify() {
	$.ajax({
		url :  basePath + "GoodsType/" + $("#goodsType_goodTypeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#goodsTypeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#goodsTypeQueryForm").submit();
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
    goodsTypeEdit("<%=request.getParameter("goodTypeId")%>");
 })
 </script> 
</body>
</html>

