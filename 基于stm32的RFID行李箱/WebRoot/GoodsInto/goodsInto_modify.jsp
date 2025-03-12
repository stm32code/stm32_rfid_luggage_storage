<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/goodsInto.css" />
<div id="goodsInto_editDiv">
	<form id="goodsIntoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">物品入箱id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="goodsInto_goodsintoId_edit" name="goodsInto.goodsintoId" value="<%=request.getParameter("goodsintoId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="goodsIntoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/GoodsInto/js/goodsInto_modify.js"></script> 
