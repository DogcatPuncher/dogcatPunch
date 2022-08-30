<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /> -->
   <title></title>
   
   <link rel="shortcut icon" href="/resources/images/common/dogpaw.svg"/>
   <link rel="apple-touch-icon" href="/resources/image/common/dogpaw.svg"/>
   
   <link href="/resources/include/scorilo/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
   <link href="/resources/include/scorilo/css/style.css" rel="stylesheet">
   <link href="https://fonts.googleapis.com/css?family=Dosis:200,300,400,500,600,700" rel="stylesheet">
   <link href="https://fonts.googleapis.com/css?family=Roboto:200,300,400,500,600,700" rel="stylesheet">
   <!--<link rel="stylesheet" type="text/css" href="/resources/include/css/default.css"/>  -->
   <style type="text/css">
      
   </style>

   <script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
   <script type="text/javascript" src="/resources/include/js/common.js"></script>
   <script type="text/javascript" src="/resources/include/scorilo/js/bootstrap.min.js"></script>
   <script type="text/javascript"></script>
</head>
<body>
	<section class="item content">
      <tiles:insertAttribute name="body"/>
   </section>
<%--    <div class="footer text-center">
      <tiles:insertAttribute name="footer"/>
   </div> --%>
    <footer class="footer text-center">
      <tiles:insertAttribute name="footer"/>
    </footer>  

    
</body>
</html>