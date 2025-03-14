<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/goodsType.css" /> 

<div id="goodsType_manage"></div>
<div id="goodsType_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="goodsType_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="goodsType_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="goodsType_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="goodsType_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="goodsType_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="goodsTypeQueryForm" method="post">
			类型名称：<input type="text" class="textbox" id="goodTypeName" name="goodTypeName" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="goodsType_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="goodsTypeEditDiv">
	<form id="goodsTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">物品类型id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsType_goodTypeId_edit" name="goodsType.goodTypeId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">类型名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsType_goodTypeName_edit" name="goodsType.goodTypeName" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="GoodsType/js/goodsType_manage.js"></script> 
