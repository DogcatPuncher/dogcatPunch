<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="/resources/images/common/icon.png">

    <title>관리자 페이지</title>

    <!-- Bootstrap core CSS -->
    <link href="/resources/include/dist/css/bootstrap.min.css" rel="stylesheet">
	
    <!-- Custom styles for this template -->
    <link href="/resources/include/dist/css/sticky-footer-navbar.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="/resources/include/dist/assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/resources/include/dist/assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="/resources/include/dist/css/offcanvas.css">
	<link href="/resources/include/dist/css/dashboard.css" rel="stylesheet">
    
    <style>
    	section {
		    position:absolute;
		    right:0;
		    width:80%; 
		    height:80%;
		    margin-top:30px;
		    margin-right:15px;
		}
		
		body {
			background-color :#EFF5FB;
			color: #6E6E6E;}
		
		.box {
		    position:absolute;
		    top:0;
		    left:0;
		    right:50%;
		    bottom:50%;
		    border:2px solid #D8D8D8;
		    margin : 15px;
		    border-radius: 10px;
		    background-color:#fff;
		     cursor: pointer;
		}
		
		.box:nth-of-type(2) {
		    bottom:50%;
		    left:50%;
		    right:0;
			border:2px 2px 0 0 solid #D8D8D8;
			margin : 15px;
			border-radius: 10px;
			background-color:#fff;
			cursor: pointer;
		}
		
		.box:nth-of-type(3) {
		    top:50%;
		    left:0;
		    right:50%;
		    bottom:0;
			border:2px solid #D8D8D8;
			margin : 15px;
			border-radius: 10px;
			background-color:#fff;
			cursor: pointer;
		}
		
		.box:nth-of-type(4) {
		    top:50%;
		    left:50%;
		    right:0;
		    bottom:0;
			border:2px solid #D8D8D8;
			margin : 15px;
			border-radius: 10px;
			background-color:#fff;
			cursor: pointer;
		}
		
		div > h3 { margin-left : 20px;}
		
		.qna { 
			display : inline-block;
			border:2px solid #D8D8D8;
			border-radius: 10px;
			width : 200px;
			height : 200px;
			background-color :#EFF5FB;;
			margin-top:10px;
			margin-left: 60px;
			}
			
		.member	{
			display : inline-block;
			border:2px solid #D8D8D8;
			border-radius: 10px;
			background-color :#EFF5FB;;
			margin-top:10px;
			margin-left: 30px;
			width : 100px;
			height : 100px;
			font-size : 15px;
			}
		#notice_td{
			padding-left : 30px;
			font-size : 20px;
		}
		.info {margin-top : 20px;}
		.qna_today {margin:auto;}
		.qna_yet{margin:auto;}
		#qna_yet{margin-left: 40px;}
		.qna_h {padding-top:25px;}
		/*.nav-sidebar{width:15%;}*/
		#hotelBtn{height:110px;}
		#hotel_info{margin-left:30px; margin-top:10px;}
		#member_info{display:flex;}
		#member_info > h1 {padding-top : 25px;}
		#member_2, #member_1{padding-top: 30px;}
		
    </style>
	
	<script type="text/javascript">
		$(function(){
			$("#navbar .nav li:eq(0)").addClass("active");
			//$('.dropdown-toggle').dropdown();
			
			$("#payBtn").click(function(){
				location.href = "/admin/member/reservList";
			})
			
			$("#hotelBtn").click(function(){
				location.href = "/admin/hotel/hotelList";
			});
			
			
			$("#noticeBtn").click(function(){
				location.href = "/admin/notice/noticeList";
			});
			
			$("#qnaBtn").click(function(){
				location.href = "/admin/qna/qnaList";
			});
			
			$("#member_manage").click(function(){
				location.href = "/admin/member/memberList";
			})
			
		});
		
	</script>
  </head>

  <body>
    <!-- Begin page content -->
    <div class="container"> 	
		<section>
			<div class="box">
				<div id="payBtn"><h3>결제 현황</h3>
				
					<div class="pay">
						<h3 class="text-center">일일 결제 건수</h3>
						<h1 class="text-center">${reserv_cnt.reserv_cnt }건</h1>
					</div>
					<div class="pay">
						<h3 class="text-center">일일 결제 금액</h3>
						<h1 class="text-center">${reserv_pay_cnt.reserv_pay_cnt }원</h1>
					</div>
				</div>	
			</div>
			
			 <div class="box">
				<div id="hotelBtn">
					<h3>숙소 관리</h3>
					<div id="hotel_info">
						<h4>숙소 내역을 확인하세요.</h4>
					</div>
				</div>
				<div id="noticeBtn">
					<div>
						<h3>공지사항</h3>
					</div>
					<div id="content_body">
	                   <table>
	                  	<c:choose>
	                  		<c:when test="${not empty noticeList}">
	                  			<c:forEach var="notice" items="${noticeList}" varStatus="status" begin="0" end="5">
	                  				<ul class="info" data-num="${notice.n_no}">
	                        			<li id="notice_td" class="goNDetail">${notice.n_title}</li>
	                     			</ul>
	                  			</c:forEach>
	                  		</c:when>
	                  		<c:otherwise>
	                  			<tr>
	                  				<td>등록된 게시물이 존재하지 않습니다.</td>
	                  			</tr> 
	                  		</c:otherwise>
	                  	</c:choose>
	                  </table>
	               </div>
				</div>
			</div>
			
			
			<div class="box">
				<div id="qnaBtn">
					<h3>Q&A 관리</h3>
				
					<div class="qna" id="qna_yet">
						<div class="qna_yet">
							<h3 class="text-center qna_h">답변 대기중</h3>
							<h1 class="text-center qna_h">${qna_notcomple.admin_Qna_yet }개</h1>
						</div>
					</div>
					<div class="qna">
						<div class="qna_today">
							<h3 class="text-center qna_h">오늘한 답변</h3> 
							<h1 class="text-center qna_h">${qna_comple.admin_Qna_today }개</h1>
						</div>
					</div>
				</div>	
			</div>
			<div class="box">
				
               
               <div id="member_manage">
					<h3>회원 관리</h3>
					<div class="member_info">
						<div id="member_1" class="qna">
							<h3 class="text-center" style="margin-left:0px;">오늘 가입한 회원</h3>
							<h1 class="text-center">${member_join_today.member_today }명</h1>
						</div>
						<div id="member_2" class="qna">
							<h3 class="text-center">모든 회원</h3>
							<h1 class="text-center">${allMember.all_member }명</h1>
						</div>
					</div>
					
				</div>
			</div>
		</section>
			
			<!-- <div class="">
				<h2>회원관리</h2>
				<p><a class="btn btn-default" href="/admin/member/memberList" role="button">
				View details &raquo;</a></p>
            </div>/.col-xs-6.col-lg-4
            <div class="">
				<h2>예약내역관리</h2>
				<p><a class="btn btn-default" href="/admin/member/reservList" role="button">
				View details &raquo;</a></p>
            </div>/.col-xs-6.col-lg-4
            <div class="">
				<h2>숙소게시판관리</h2>
				<p><a class="btn btn-default" href="/admin/hotel/hotelList" role="button">
				View details &raquo;</a></p>
			</div>
				<div class="">
				<h2>공지사항</h2>
				<p><a class="btn btn-default" href="/admin/notice/noticeList" role="button">
				View details &raquo;</a></p>
            </div>/.col-xs-6.col-lg-4 -->
            
		</div><!--/box-->
    </div><!--/.container-->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> -->
    <script src="/resources/include/dist/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/resources/include/dist/assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
