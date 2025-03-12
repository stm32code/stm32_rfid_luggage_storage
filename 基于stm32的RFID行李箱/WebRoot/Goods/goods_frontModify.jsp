<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Goods" %>
<%@ page import="com.chengxusheji.po.GoodsType" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的goodTypeObj信息
    List<GoodsType> goodsTypeList = (List<GoodsType>)request.getAttribute("goodsTypeList");
    //获取所有的goodsUserObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Goods goods = (Goods)request.getAttribute("goods");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改物品信息</TITLE>
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
  		<li class="active">物品信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="goodsEditForm" id="goodsEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="goods_goodsId_edit" class="col-md-3 text-right">物品id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="goods_goodsId_edit" name="goods.goodsId" class="form-control" placeholder="请输入物品id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="goods_goodTypeObj_goodTypeId_edit" class="col-md-3 text-right">物品类型:</label>
		  	 <div class="col-md-9">
			    <select id="goods_goodTypeObj_goodTypeId_edit" name="goods.goodTypeObj.goodTypeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goods_goodsName_edit" class="col-md-3 text-right">物品名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="goods_goodsName_edit" name="goods.goodsName" class="form-control" placeholder="请输入物品名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goods_goodsRfid_edit" class="col-md-3 text-right">物品rfid:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="goods_goodsRfid_edit" name="goods.goodsRfid" class="form-control" placeholder="请输入物品rfid">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goods_goodPrice_edit" class="col-md-3 text-right">物品价格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="goods_goodPrice_edit" name="goods.goodPrice" class="form-control" placeholder="请输入物品价格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goods_goodsDescribe_edit" class="col-md-3 text-right">物品描述:</label>
		  	 <div class="col-md-9">
			    <textarea id="goods_goodsDescribe_edit" name="goods.goodsDescribe" rows="8" class="form-control" placeholder="请输入物品描述"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goods_goodIntoTIme_edit" class="col-md-3 text-right">物品存入时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date goods_goodIntoTIme_edit col-md-12" data-link-field="goods_goodIntoTIme_edit">
                    <input class="form-control" id="goods_goodIntoTIme_edit" name="goods.goodIntoTIme" size="16" type="text" value="" placeholder="请选择物品存入时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goods_goodsNumb_edit" class="col-md-3 text-right">仓库数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="goods_goodsNumb_edit" name="goods.goodsNumb" class="form-control" placeholder="请输入仓库数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goods_goodsUserObj_user_name_edit" class="col-md-3 text-right">所属用户:</label>
		  	 <div class="col-md-9">
			    <select id="goods_goodsUserObj_user_name_edit" name="goods.goodsUserObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxGoodsModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#goodsEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改物品界面并初始化数据*/
function goodsEdit(goodsId) {
	$.ajax({
		url :  basePath + "Goods/" + goodsId + "/update",
		type : "get",
		dataType: "json",
		success : function (goods, response, status) {
			if (goods) {
				$("#goods_goodsId_edit").val(goods.goodsId);
				$.ajax({
					url: basePath + "GoodsType/listAll",
					type: "get",
					success: function(goodsTypes,response,status) { 
						$("#goods_goodTypeObj_goodTypeId_edit").empty();
						var html="";
		        		$(goodsTypes).each(function(i,goodsType){
		        			html += "<option value='" + goodsType.goodTypeId + "'>" + goodsType.goodTypeName + "</option>";
		        		});
		        		$("#goods_goodTypeObj_goodTypeId_edit").html(html);
		        		$("#goods_goodTypeObj_goodTypeId_edit").val(goods.goodTypeObjPri);
					}
				});
				$("#goods_goodsName_edit").val(goods.goodsName);
				$("#goods_goodsRfid_edit").val(goods.goodsRfid);
				$("#goods_goodPrice_edit").val(goods.goodPrice);
				$("#goods_goodsDescribe_edit").val(goods.goodsDescribe);
				$("#goods_goodIntoTIme_edit").val(goods.goodIntoTIme);
				$("#goods_goodsNumb_edit").val(goods.goodsNumb);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#goods_goodsUserObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#goods_goodsUserObj_user_name_edit").html(html);
		        		$("#goods_goodsUserObj_user_name_edit").val(goods.goodsUserObjPri);
					}
				});
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交物品信息表单给服务器端修改*/
function ajaxGoodsModify() {
	$.ajax({
		url :  basePath + "Goods/" + $("#goods_goodsId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#goodsEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#goodsQueryForm").submit();
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
    /*物品存入时间组件*/
    $('.goods_goodIntoTIme_edit').datetimepicker({
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
    goodsEdit("<%=request.getParameter("goodsId")%>");
 })
 </script> 
</body>
</html>

