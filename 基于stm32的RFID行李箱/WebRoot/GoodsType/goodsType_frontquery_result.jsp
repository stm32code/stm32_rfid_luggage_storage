<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.GoodsType" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<GoodsType> goodsTypeList = (List<GoodsType>)request.getAttribute("goodsTypeList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String goodTypeName = (String)request.getAttribute("goodTypeName"); //类型名称查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>物品类型查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#goodsTypeListPanel" aria-controls="goodsTypeListPanel" role="tab" data-toggle="tab">物品类型列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>GoodsType/goodsType_frontAdd.jsp" style="display:none;">添加物品类型</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="goodsTypeListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>物品类型id</td><td>类型名称</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<goodsTypeList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		GoodsType goodsType = goodsTypeList.get(i); //获取到物品类型对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=goodsType.getGoodTypeId() %></td>
 											<td><%=goodsType.getGoodTypeName() %></td>
 											<td>
 												<a href="<%=basePath  %>GoodsType/<%=goodsType.getGoodTypeId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="goodsTypeEdit('<%=goodsType.getGoodTypeId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="goodsTypeDelete('<%=goodsType.getGoodTypeId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>物品类型查询</h1>
		</div>
		<form name="goodsTypeQueryForm" id="goodsTypeQueryForm" action="<%=basePath %>GoodsType/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="goodTypeName">类型名称:</label>
				<input type="text" id="goodTypeName" name="goodTypeName" value="<%=goodTypeName %>" class="form-control" placeholder="请输入类型名称">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="goodsTypeEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;物品类型信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#goodsTypeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxGoodsTypeModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.goodsTypeQueryForm.currentPage.value = currentPage;
    document.goodsTypeQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.goodsTypeQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.goodsTypeQueryForm.currentPage.value = pageValue;
    documentgoodsTypeQueryForm.submit();
}

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
				$('#goodsTypeEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除物品类型信息*/
function goodsTypeDelete(goodTypeId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "GoodsType/deletes",
			data : {
				goodTypeIds : goodTypeId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#goodsTypeQueryForm").submit();
					//location.href= basePath + "GoodsType/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

