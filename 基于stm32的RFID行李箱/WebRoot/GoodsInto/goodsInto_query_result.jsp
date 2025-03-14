<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/goodsInto.css" /> 

<div id="goodsInto_manage"></div>
<div id="goodsInto_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="goodsInto_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="goodsInto_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="goodsInto_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="goodsInto_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="goodsInto_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="goodsIntoQueryForm" method="post">
			入箱物品：<input class="textbox" type="text" id="goodsIntoObj_goodsId_query" name="goodsIntoObj.goodsId" style="width: auto"/>
			入箱时间：<input type="text" id="intoTIme" name="intoTIme" class="easyui-datebox" editable="false" style="width:100px">
			物品rfid：<input type="text" class="textbox" id="goodsRfid" name="goodsRfid" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="goodsInto_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="goodsIntoEditDiv">
	<form id="goodsIntoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">物品入箱id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsInto_goodsintoId_edit" name="goodsInto.goodsintoId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">入箱物品:</span>
			<span class="inputControl">
				<input class="textbox"  id="goodsInto_goodsIntoObj_goodsId_edit" name="goodsInto.goodsIntoObj.goodsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入箱数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsInto_intoNumb_edit" name="goodsInto.intoNumb" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">入箱时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsInto_intoTIme_edit" name="goodsInto.intoTIme" />

			</span>

		</div>
		<div>
			<span class="label">物品rfid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsInto_goodsRfid_edit" name="goodsInto.goodsRfid" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="GoodsInto/js/goodsInto_manage.js"></script> 
