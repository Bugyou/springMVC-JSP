<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="js/jquery-accordion-menu.js"
	type="text/javascript"></script>

<link href="css/jquery-accordion-menu.css"
	rel="stylesheet" type="text/css" />

<title>Insert title here</title>
<style type="text/css">
.htmleaf-header {
	font-family: "Segoe UI", "Lucida Grande", Helvetica, Arial,
		"Microsoft YaHei", FreeSans, Arimo, "Droid Sans",
		"wenquanyi micro hei", "Hiragino Sans GB", "Hiragino Sans GB W3",
		"FontAwesome", sans-serif;
}

<
style type ="text /css">.htmleaf-header {
	font-family: "Segoe UI", "Lucida Grande", Helvetica, Arial,
		"Microsoft YaHei", FreeSans, Arimo, "Droid Sans",
		"wenquanyi micro hei", "Hiragino Sans GB", "Hiragino Sans GB W3",
		"FontAwesome", sans-serif;
}

<
style type ="text /css">* {
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
}

body {
	background: #f0f0f0;
}

.content {
	width: 260px;
	margin: 100px auto;
}

.filterinput {
	background-color: rgba(249, 244, 244, 0);
	border-radius: 15px;
	width: 90%;
	height: 30px;
	border: thin solid #FFF;
	text-indent: 0.5em;
	font-weight: bold;
	color: #FFF;
}

#demo-list a {
	overflow: hidden;
	text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
	white-space: nowrap;
	width: 100%;
}
</style>
<script type="text/javascript">
	(function($) {
		$.expr[":"].Contains = function(a, i, m) {
			return (a.textContent || a.innerText || "").toUpperCase().indexOf(
					m[3].toUpperCase()) >= 0;
		};
		function filterList(header, list) {
			// @header 头部元素
			// @list 无需列表
			// 创建一个搜素表单
			var form = $("<form>").attr({
				"class" : "filterform",
				action : "#"
			}), input = $("<input>").attr({
				"class" : "filterinput",
				//"placeholder" : "过滤菜单项",
				"type" : "text"
			});
			$(form).append(input).appendTo(header);

			$(input).change(
					function() {
						var filter = $(this).val();
						if (filter) {
							$matches = $(list).find(
									"a:Contains(" + filter + ")").parent();
							$("li", list).not($matches).slideUp();
							$matches.slideDown();
						} else {
							$(list).find("li").slideDown();
						}
						return false;
					}).keyup(function() {
				$(this).change();
			});

		}
		$(function() {
			filterList($("#form"), $("#demo-list"));
		});
	})(jQuery);

	jQuery(document).ready(function() {
		jQuery("#jquery-accordion-menu").jqueryAccordionMenu();

	});

	$(function() {
		// 顶部导航切换
		$("#demo-list li").click(function() {
			$("#demo-list li.active").removeClass("active");
			$(this).addClass("active");
		});
	});
</script>
</head>
<body>
	<div id="jquery-accordion-menu" class="jquery-accordion-menu">
		<div class="jquery-accordion-menu-header" id="form"
			style="padding-top: 10px;background-color: #0078D7"></div>
		<ul id="demo-list">
			
			<!--
			<li><a href="#"><i class="fa fa-suitcase"></i>GMS TOOL</a>
				<ul class="submenu">
					<li><a href="1">1</a></li>
					<li><a href="2">2</a></li>
					<li><a href="3"></a>3</li>
					<li><a href="4">4</a></li>
				</ul>
			</li>-->

			<li ><a href="<%=basePath%>user/getAllUser">人员信息</a></li>
		</ul>
	</div>

</body>
</html>