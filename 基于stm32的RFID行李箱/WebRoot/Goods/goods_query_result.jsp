<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/goods.css" /> 

<div id="goods_manage"></div>
<div id="goods_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="goods_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="goods_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="goods_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="goods_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="goods_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="goodsQueryForm" method="post">
			物品类型：<input class="textbox" type="text" id="goodTypeObj_goodTypeId_query" name="goodTypeObj.goodTypeId" style="width: auto"/>
			物品名称：<input type="text" class="textbox" id="goodsName" name="goodsName" style="width:110px" />
			物品rfid：<input type="text" class="textbox" id="goodsRfid" name="goodsRfid" style="width:110px" />
			物品描述：<input type="text" class="textbox" id="goodsDescribe" name="goodsDescribe" style="width:110px" />
			物品存入时间：<input type="text" id="goodIntoTIme" name="goodIntoTIme" class="easyui-datebox" editable="false" style="width:100px">
			所属用户：<input class="textbox" type="text" id="goodsUserObj_user_name_query" name="goodsUserObj.user_name" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="goods_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="goodsEditDiv">
	<form id="goodsEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">物品id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodsId_edit" name="goods.goodsId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">物品类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="goods_goodTypeObj_goodTypeId_edit" name="goods.goodTypeObj.goodTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">物品名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodsName_edit" name="goods.goodsName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物品rfid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodsRfid_edit" name="goods.goodsRfid" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物品价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodPrice_edit" name="goods.goodPrice" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">物品描述:</span>
			<span class="inputControl">
				<textarea id="goods_goodsDescribe_edit" name="goods.goodsDescribe" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">物品存入时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodIntoTIme_edit" name="goods.goodIntoTIme" />

			</span>

		</div>
		<div>
			<span class="label">仓库数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodsNumb_edit" name="goods.goodsNumb" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">所属用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="goods_goodsUserObj_user_name_edit" name="goods.goodsUserObj.user_name" style="width: auto"/>
			</span>
		</div>
	</form>
</div>
<script type="text/javascript" src="Goods/js/goods_manage.js"></script> 
