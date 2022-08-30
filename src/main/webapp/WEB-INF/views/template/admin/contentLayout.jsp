<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="icon" href="/resources/images/common/icon.png">

  <title>관리자 페이지</title>
  <!-- Bootstrap core CSS -->
  <link href="/resources/include/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="/resources/include/dist/css/dashboard.css" rel="stylesheet">
  <link href="/resources/include/dist/css/offcanvas.css" rel="stylesheet">
  

  <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
  <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/resources/include/css/admin.css" />
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
</head>

<body>

	<nav class="navbar navbar-inverse navbar-fixed-top">
		<tiles:insertAttribute name="header" />
	</nav>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<tiles:insertAttribute name="left" />
			</div>
		
			<div>
				<tiles:insertAttribute name="sub" />
			</div>
			<div id="mainContents" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main" >
				<tiles:insertAttribute name="main" />
			</div>
		</div>
	</div>
	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> -->
	<script src="/resources/include/dist/js/bootstrap.min.js"></script>
	<script src="/resources/include/dist/assets/js/docs.min.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
</body>

</html>