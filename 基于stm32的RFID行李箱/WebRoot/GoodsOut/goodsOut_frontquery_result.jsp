<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.GoodsOut" %>
<%@ page import="com.chengxusheji.po.Goods" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<GoodsOut> goodsOutList = (List<GoodsOut>)request.getAttribute("goodsOutList");
    //获取所有的outGoodsRfid信息
    List<Goods> goodsList = (List<Goods>)request.getAttribute("goodsList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Goods outGoodsRfid = (Goods)request.getAttribute("outGoodsRfid");
    String outTime = (String)request.getAttribute("outTime"); //出箱时间查询关键字
    String goodsRfid = (String)request.getAttribute("goodsRfid"); //物品rfid查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>物品出箱查询</title>
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
			    	<li role="presentation" class="active"><a href="#goodsOutListPanel" aria-controls="goodsOutListPanel" role="tab" data-toggle="tab">物品出箱列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>GoodsOut/goodsOut_frontAdd.jsp" style="display:none;">添加物品出箱</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="goodsOutListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>出箱id</td><td>物品出箱id</td><td>出箱数量</td><td>出箱时间</td><td>物品rfid</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<goodsOutList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		GoodsOut goodsOut = goodsOutList.get(i); //获取到物品出箱对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=goodsOut.getOutId() %></td>
 											<td><%=goodsOut.getOutGoodsRfid().getGoodsName() %></td>
 											<td><%=goodsOut.getOutNumb() %></td>
 											<td><%=goodsOut.getOutTime() %></td>
 											<td><%=goodsOut.getGoodsRfid() %></td>
 											<td>
 												<a href="<%=basePath  %>GoodsOut/<%=goodsOut.getOutId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="goodsOutEdit('<%=goodsOut.getOutId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="goodsOutDelete('<%=goodsOut.getOutId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>物品出箱查询</h1>
		</div>
		<form name="goodsOutQueryForm" id="goodsOutQueryForm" action="<%=basePath %>GoodsOut/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="outGoodsRfid_goodsId">物品出箱id：</label>
                <select id="outGoodsRfid_goodsId" name="outGoodsRfid.goodsId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Goods goodsTemp:goodsList) {
	 					String selected = "";
 					if(outGoodsRfid!=null && outGoodsRfid.getGoodsId()!=null && outGoodsRfid.getGoodsId().intValue()==goodsTemp.getGoodsId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=goodsTemp.getGoodsId() %>" <%=selected %>><%=goodsTemp.getGoodsName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="outTime">出箱时间:</label>
				<input type="text" id="outTime" name="outTime" class="form-control"  placeholder="请选择出箱时间" value="<%=outTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="goodsRfid">物品rfid:</label>
				<input type="text" id="goodsRfid" name="goodsRfid" value="<%=goodsRfid %>" class="form-control" placeholder="请输入物品rfid">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="goodsOutEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;物品出箱信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="goodsOutEditForm" id="goodsOutEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="goodsOut_outId_edit" class="col-md-3 text-right">出箱id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="goodsOut_outId_edit" name="goodsOut.outId" class="form-control" placeholder="请输入出箱id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="goodsOut_outGoodsRfid_goodsId_edit" class="col-md-3 text-right">物品出箱id:</label>
		  	 <div class="col-md-9">
			    <select id="goodsOut_outGoodsRfid_goodsId_edit" name="goodsOut.outGoodsRfid.goodsId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goodsOut_outNumb_edit" class="col-md-3 text-right">出箱数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="goodsOut_outNumb_edit" name="goodsOut.outNumb" class="form-control" placeholder="请输入出箱数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goodsOut_outTime_edit" class="col-md-3 text-right">出箱时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date goodsOut_outTime_edit col-md-12" data-link-field="goodsOut_outTime_edit">
                    <input class="form-control" id="goodsOut_outTime_edit" name="goodsOut.outTime" size="16" type="text" value="" placeholder="请选择出箱时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="goodsOut_goodsRfid_edit" class="col-md-3 text-right">物品rfid:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="goodsOut_goodsRfid_edit" name="goodsOut.goodsRfid" class="form-control" placeholder="请输入物品rfid">
			 </div>
		  </div>
		</form> 
	    <style>#goodsOutEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxGoodsOutModify();">提交</button>
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
    document.goodsOutQueryForm.currentPage.value = currentPage;
    document.goodsOutQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.goodsOutQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.goodsOutQueryForm.currentPage.value = pageValue;
    documentgoodsOutQueryForm.submit();
}

/*弹出修改物品出箱界面并初始化数据*/
function goodsOutEdit(outId) {
	$.ajax({
		url :  basePath + "GoodsOut/" + outId + "/update",
		type : "get",
		dataType: "json",
		success : function (goodsOut, response, status) {
			if (goodsOut) {
				$("#goodsOut_outId_edit").val(goodsOut.outId);
				$.ajax({
					url: basePath + "Goods/listAll",
					type: "get",
					success: function(goodss,response,status) { 
						$("#goodsOut_outGoodsRfid_goodsId_edit").empty();
						var html="";
		        		$(goodss).each(function(i,goods){
		        			html += "<option value='" + goods.goodsId + "'>" + goods.goodsName + "</option>";
		        		});
		        		$("#goodsOut_outGoodsRfid_goodsId_edit").html(html);
		        		$("#goodsOut_outGoodsRfid_goodsId_edit").val(goodsOut.outGoodsRfidPri);
					}
				});
				$("#goodsOut_outNumb_edit").val(goodsOut.outNumb);
				$("#goodsOut_outTime_edit").val(goodsOut.outTime);
				$("#goodsOut_goodsRfid_edit").val(goodsOut.goodsRfid);
				$('#goodsOutEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除物品出箱信息*/
function goodsOutDelete(outId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "GoodsOut/deletes",
			data : {
				outIds : outId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#goodsOutQueryForm").submit();
					//location.href= basePath + "GoodsOut/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交物品出箱信息表单给服务器端修改*/
function ajaxGoodsOutModify() {
	$.ajax({
		url :  basePath + "GoodsOut/" + $("#goodsOut_outId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#goodsOutEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#goodsOutQueryForm").submit();
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

    /*出箱时间组件*/
    $('.goodsOut_outTime_edit').datetimepicker({
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
})
</script>
</body>
</html>

