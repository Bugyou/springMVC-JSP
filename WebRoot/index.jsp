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
	function login(){
		var form = document.forms[0];
		form.action = "<%=basePath%>user/login";
		form.method="post";
		form.submit();
	}
</script>

</head>

<body>
	<div style="top:0px;left:0px;width:100%;height:auto;background-color:#0078D7;font-family:宋体;font-size:35;color:white;text-align:center">
<br><b>欢迎进入用户管理系统！</b><br><br>
    </div>
	<div style="width:400px;margin:0px auto">
		<form action="" name="userForm" style="width:400px" >
		    <br/><br/>
			用户名：<input type="text" name="name" value="${admin.name }" /> 
			<br/><br/>
			密　码：<input type="password" name="pwd" value="${admin.pwd }" /> 
			<br/><br/>
			<div style="margin-left:30%">
			<input type="button" value="登陆" onclick="login()" />
			</div>
		</form>
	</div>
</body>

</html>
