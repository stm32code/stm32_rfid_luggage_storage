<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/goods.css" />
<div id="goods_editDiv">
	<form id="goodsEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">物品id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodsId_edit" name="goods.goodsId" value="<%=request.getParameter("goodsId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="goodsModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Goods/js/goods_modify.js"></script> 
