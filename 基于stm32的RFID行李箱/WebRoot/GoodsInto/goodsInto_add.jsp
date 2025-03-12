<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/goodsInto.css" />
<div id="goodsIntoAddDiv">
	<form id="goodsIntoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">入箱物品:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsInto_goodsIntoObj_goodsId" name="goodsInto.goodsIntoObj.goodsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入箱数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsInto_intoNumb" name="goodsInto.intoNumb" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">入箱时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsInto_intoTIme" name="goodsInto.intoTIme" />

			</span>

		</div>
		<div>
			<span class="label">物品rfid:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsInto_goodsRfid" name="goodsInto.goodsRfid" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="goodsIntoAddButton" class="easyui-linkbutton">添加</a>
			<a id="goodsIntoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/GoodsInto/js/goodsInto_add.js"></script> 
