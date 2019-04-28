<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
	<div style="top:0px;left:0px;width:100%;height:auto;background-color:#0078D7;font-family:宋体;font-size:35;color:white;text-align:center">
<br><b>欢迎进入用户管理系统！</b><br><br>
    </div>
<html>
<head>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery-1.7.1.js"></script>

<link href="js/easyui/themes/metro/easyui.css" rel="stylesheet"
	type="text/css" />
<link href="js/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
<script src="js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<script src="js/easyui/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>

<title>用户列表</title>

<script type="text/javascript">
	function showMsg(msg) {
		$.messager.show({
			title : '消息',
			msg : msg,
			showType : 'show',
			style : {
				right : '',
				bottom : 0,
				top : '',
				left : ''
			}
		});
	}
	function del(id) {
			$.get("<%=basePath%>user/delUser?id=" + id, function(data) {
			if ("success" == data.result) {
				alert("删除成功");
				window.location.reload();
			} else {
				alert("删除失败");
			}
		});
	}
	
	function jsEditUser() {
		var row = $('#allUserTable').datagrid('getSelected');
		var rows = $('#allUserTable').datagrid('getSelections');
		var index;
		if (rows.length>1){
			index = -1;
			alert("编辑请选中1行");
		}else if (row) {
			document.getElementById("dialog").style.display = "block";
			index = $('#allUserTable').datagrid('getRowIndex', row);
			
			window.location.href="<%=basePath%>user/getUser?id="+row.id;
			
		} else {
			index = -1;
			alert("未选中任何行");
		}
	}
	function jsRemoveUser() {
		var rows = $('#allUserTable').datagrid('getSelections');
		var index;
		if (rows.length>=1){
			var ids='' ;
			for(var i=0; i<rows.length; i++){
				ids=ids+rows[i].id+",";
			}
			$.ajax({
		        type:'GET',
		        url:'<%=basePath%>user/toRemoveUsers?ids='+ids,
		        success : function(data) {
					if (data.success) {
						$('#allUserTable').datagrid('reload');
						showMsg("删除成功");
					} else {
						$.messager.alert('错误', data.msg, 'error');
					}
				}
		    });
		}else {
			index = -1;
			alert("未选中任何行");
		}
	}
	$(function() {
		$('#allUserTable')
				.datagrid(
						{
							columns : [
									[ {
										title : '姓名(模糊搜索)'
									}, {
										title : '年龄(精确搜索)'
									}, {
										title : '性别'
									}, {
										title : '电话'
									}, {
										title : '地址'
									}, {
										title : '附加说明(文件)'
									}  ],
									[
											{
												field : 'userName',
												title : '<input type="text" id="search_userName" class="header-input"/>',
												width : 20,
												align : 'left'
											},
											{
												field : 'age',
												title : '<input type="text" id="search_age" class="header-input"/>',
												width : 20,
												align : 'left'
											},
											{
												field : 'sex',
												width : 20,
												align : 'left'
											},
											{
												field : 'phone',
												width : 20,
												align : 'left'
											},
											{
												field : 'addr',
												width : 20,
												align : 'left'
											},
											{
												field : 'userOther',
												title : '',
												width : 20,
												align : 'left',
												formatter : 
												function(value, row, index) {
													var d='';
													if((''!=value)&&(undefined!=value)){
														d = '<a href="<%=basePath%>user/download?id='
															+ row.id + '">下载</a>';
													}
													return d;
												}
											},
											{
												field : 'id',
												width : 0,
												hidden : true
											} 
									]
							]
						});
		$("#search_userName, #search_age, #search_phone, #search_addr").on('input', function(e) {
			var param = {
				userName : $("#search_userName").val(),
				age : $("#search_age").val()
			};
			$("#allUserTable").datagrid("load", param);
		});
	});

</script>
</head>

<body>
	<%--
	<h6>
		<a href="<%=basePath%>user/toAddUser">添加用户</a>
	</h6> 	
	<table border="1">
		<tbody>
			<tr>
				<th>姓名</th>
				<th>年龄</th>
				<th>操作</th>
			</tr>
			<c:if test="${!empty userList }">
				<c:forEach items="${userList}" var="user">
					<tr>
						<td>${user.userName }</td>
						<td>${user.age }</td>
						<td><a href="<%=basePath%>user/getUser?id=${user.id}">编辑</a>
							<a href="javascript:del('${user.id }')">删除</a></td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table> 
	--%>
	<div id="main_layout" class="easyui-layout" fit="true">
		<div region="west" split="false" title="导航菜单" border="false"
			style="width: 290px; background-color:#0078D7">
			<jsp:include page="left_nav.jsp"></jsp:include>
		</div>
		<div id="content" region="center" title="用户表" border="false">
			<div id="allUserTable" fit="true" nowrap="false"
				toolbar="#allUserTableToolbar" url="<%=basePath%>user/searchAllUser"
				fitColumns="true" rownumbers="true" pagination="true" 
				singleSelect="false" autoRowHeight="false" pageSize="20"></div>
		</div>
		<div id="south" region="south" title="说明——我的小练习"
		style="height: 180px; width: 100%">
	</div>

	<div id="allUserTableToolbar" align="right"
		style="height: auto; width: 100%; padding: 3px">
		<a href="<%=basePath%>user/toAddUser" class="easyui-linkbutton" 
			iconCls="icon-add" plain="true" 
			title="添加"
			style="background-color:#0078D7"></a> 
		<a onclick="jsEditUser()" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true"
			title="编辑"
			style="background-color:#0078D7"></a>
		<a onclick="jsRemoveUser()"
			class="easyui-linkbutton" iconCls="icon-remove" plain="true"
			title="删除" 
			style="margin-right: 15px;background-color:#0078D7"></a> 
	</div>
	<div id="dialog" style="display: none; width: 350; height: auto"
		closed=false cache=true modal=true>
		<table id="propertyGrid" style="" fit=true showGroup="false"
			nowrap="false" scrollbarSize="0" showHeader="false"
			data-options="columns: mycolumns">
		</table>
	</div>
</body>
</html>
