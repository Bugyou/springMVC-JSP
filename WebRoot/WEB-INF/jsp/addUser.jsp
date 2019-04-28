<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link href="<%=basePath%>css/mycss.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>js/easyui/themes/metro/easyui.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>js/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath%>js/jquery-1.7.1.js" type="text/javascript" ></script>
<script src="<%=basePath%>js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<script src="<%=basePath%>js/easyui/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>

<title>添加用户</title>

<script type="text/javascript">
	function addUser(){
		var form = document.forms[0];
		form.action = "<%=basePath%>user/addUser";
		form.method="post";
		form.submit();
	}
	function addOneUser(){
		var form = document.forms[0];
		form.action = "<%=basePath%>user/addUser";
		form.method="post";
		form.submit();
	}
	function saveAllUser(){
		var userList = new Array();  
		
		var _len = $("#tab tr").length;
        for(var i=1,j=_len;i<j;i++)
        {
            var nextName = $("#name"+i).val();
            var ageName = $("#age"+i).val();
			userList.push({userName:'"'+nextName+'"',age: '"'+ageName+'"'});
        }
		
		$.ajax({  
		    type: "POST",  
		    url: "<%=basePath%>user/addUserList",  
		    data: JSON.stringify(userList),//将对象序列化成JSON字符串  
		    dataType:"json",
		    contentType : 'application/json;charset=utf-8', //设置请求头信息  
		    success: function(data){
			    window.location.href="<%=basePath%>user/getAllUser";
		    },
		    error: function(res){
		    	alert("添加失败");
		    }
		}); 
	}
	 $(document).ready(function(){
        //<tr/>居中
        $("#tab tr").attr("align","center");
        
        //增加<tr/>
        $("#add_btn").click(function(){
            var _len = $("#tab tr").length-1;        
            $("#tab").append("<tr id="+_len+" align='center'>"
                                +"<td>"+_len+"</td>"
                                +"<td><input type='text' name='userList["+_len+"].userName' id='name"+_len+"' /></td>"
                                +"<td><input type='text' name='userList["+_len+"].age' id='age"+_len+"' /></td>"
                                +"<td><input type='text' name='userList["+_len+"].sex' id='sex"+_len+"' /></td>"
                                +"<td><input type='text' name='userList["+_len+"].phone' id='phone"+_len+"' /></td>"
                                +"<td><input type='text' name='userList["+_len+"].addr'  id='addr"+_len+"' /></td>"
                                //+"<td><input type='file' name='files' id='multipartFile"+_len+"' /></td>"
                                +"<td><a href=\'#\' onclick=\'deltr("+_len+")\'>删除</a></td>"
                            +"</tr>");            
        });
        
        //放弃 ， 返回
        $("#giveup_btn").click(function(){       
			window.location.href="<%=basePath%>user/getAllUser";
        });
    });
    //删除<tr/>
    var deltr =function(index)
    {
        var _len = $("#tab tr").length;
        $("tr[id='"+index+"']").remove();//删除当前行
        for(var i=index+1,j=_len;i<j;i++)
        {
            var nextName = $("#name"+i).val();
            var ageName = $("#age"+i).val();
            var sexName = $("#sex"+i).val();
            var phoneName = $("#phone"+i).val();
            var addrName = $("#addr"+i).val();
            var userOther = $("#other"+i).val();
            $("tr[id=\'"+i+"\']")
                .replaceWith("<tr id="+(i-1)+" align='center'>"
                                +"<td>"+(i-1)+"</td>"
                                +"<td><input type='text' name='userList["+(i-1)+"].userName' value='"+nextName+"' id='name"+(i-1)+"'/></td>"
                                +"<td><input type='text' name='userList["+(i-1)+"].age' value='"+ageName+"' id='age"+(i-1)+"'/></td>"
                                +"<td><input type='text' name='userList["+(i-1)+"].sex' value='"+sexName+"' id='sex"+(i-1)+"'/></td>"
                                +"<td><input type='text' name='userList["+(i-1)+"].phone' value='"+phoneName+"' id='phone"+(i-1)+"'/></td>"
                                +"<td><input type='text' name='userList["+(i-1)+"].addr' value='"+addrName+"' id='addr"+(i-1)+"'/></td>"
                                //+"<td><input type='text' name='userList["+(i-1)+"].multipartFile' value='"+userOther+"' id='multipartFile"+(i-1)+"'/></td>"
                                +"<td><a  href=\'#\' onclick=\'deltr("+(i-1)+")\'>删除</a></td>"
                            +"</tr>");
        }
    };
</script>

</head>

<body>
	<div style="top:0px;left:0px;width:100%;height:auto;background-color:#0078D7;font-family:宋体;font-size:35;color:white;text-align:center">
<br><b>添加用户</b><br><br>
    </div>
	<form method="post" action="<%=basePath%>user/addUserList" name="userForm" enctype="multipart/form-data">  
		<table id="tab" border="1" width="80%" align="center" style="margin-top:20px">
	        <tr>
	            <td width="20%">序号</td>
	            <td>姓名</td>
	            <td>年龄</td>
	            <td>性别</td>
	            <td>电话</td>
	            <td>地址</td>
	            <!-- <td>附加文件</td> -->
	            <td>操作</td>
	       	</tr>
	    </table>
	    <div 
	         style="border:2px; 
             border-color:#00CC00; 
             margin-left:45%;
	         margin-top:20px">
	        
	        <input type="button" id="add_btn" value="增加"/>
			<input type="button" id="giveup_btn" value="放弃" >
			<input type="submit" value="保存" >
   		</div>
  	</form>

</body>
</html>
