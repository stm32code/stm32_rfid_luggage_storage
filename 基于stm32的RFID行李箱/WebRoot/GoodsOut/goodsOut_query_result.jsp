<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/goodsOut.css" /> 

<div id="goodsOut_manage"></div>
<div id="goodsOut_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="goodsOut_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="goodsOut_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="goodsOut_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="goodsOut_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="goodsOut_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="goodsOutQueryForm" method="post">
			物品出箱id：<input class="textbox" type="text" id="outGoodsRfid_goodsId_query" name="outGoodsRfid.goodsId" style="width: auto"/>
			出箱时间：<input type="text" id="outTime" name="outTime" class="easyui-datebox" editable="false" style="width:100px">
			物品rfid：<input type="text" class="textbox" id="goodsRfid" name="goodsRfid" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="goodsOut_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="goodsOutEditDiv">
	<form id="goodsOutEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">出箱id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsOut_outId_edit" name="goodsOut.outId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">物品出箱id:</span>
			<span class="inputControl">
				<input class="textbox"  id="goodsOut_outGoodsRfid_goodsId_edit" name="goodsOut.outGoodsRfid.goodsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">出箱数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsOut_outNumb_edit" name="goodsOut.outNumb" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">出箱时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsOut_outTime_edit" name="goodsOut.outTime" />

			</span>

		</div>
		<div>
			<span class="label">物品rfid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsOut_goodsRfid_edit" name="goodsOut.goodsRfid" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="GoodsOut/js/goodsOut_manage.js"></script> 
