<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<link href="<%=basePath%>css/mycss.css" rel="stylesheet"
	type="text/css" />
<title>编辑用户</title>

<script type="text/javascript">
	function updateUser(){
		var form = document.forms[0];
		form.action = "<%=basePath%>user/updateUser";
		form.method="post";
		form.submit();
	}
</script>

</head>

<body>
	<div style="top:0px;left:0px;width:100%;height:auto;background-color:#0078D7;font-family:宋体;font-size:35;color:white;text-align:center">
<br><b>编辑用户</b><br><br>
    </div>
    <br><br>
	<div style="width:400px;margin:0px auto">
		<form action="" name="userForm" style="width:400px;margin-left:25%;" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${user.id }" /> 
			姓名：<input type="text" name="userName" value="${user.userName }" /> 
			<br/><br/>
			年龄：<input type="text" name="age" value="${user.age }" /> 
			<br/><br/>
			性别：<input type="text" name="sex" value="${user.sex }" /> 
			<br/><br/>
			电话：<input type="text" name="phone" value="${user.phone }" /> 
			<br/><br/>
			地址：<input type="text" name="addr" value="${user.addr }" /> 
			<br/><br/>
			附加文件：<input type="file" name="other"  /> 
			<br/><br/>
			<input type="button" value="保存" onclick="updateUser()" />
		</form>
	</div>
</body>

</html>
