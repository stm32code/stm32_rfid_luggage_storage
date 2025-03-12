<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/goods.css" />
<div id="goodsAddDiv">
	<form id="goodsAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">物品类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodTypeObj_goodTypeId" name="goods.goodTypeObj.goodTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">物品名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodsName" name="goods.goodsName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物品rfid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodsRfid" name="goods.goodsRfid" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物品价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodPrice" name="goods.goodPrice" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">物品描述:</span>
			<span class="inputControl">
				<textarea id="goods_goodsDescribe" name="goods.goodsDescribe" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">物品存入时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodIntoTIme" name="goods.goodIntoTIme" />

			</span>

		</div>
		<div>
			<span class="label">仓库数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodsNumb" name="goods.goodsNumb" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">所属用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goods_goodsUserObj_user_name" name="goods.goodsUserObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div class="operation">
			<a id="goodsAddButton" class="easyui-linkbutton">添加</a>
			<a id="goodsClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Goods/js/goods_add.js"></script> 
