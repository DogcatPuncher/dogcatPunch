<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style>
	#noticeListBtn{
		background: url( "/resources/images/common/listbtn.png" ) no-repeat;
        border: none;
        font-size : 13px;
        color:#fff;
        width: 60px;
        height: 60px;
        background-size: contain;
        cursor: pointer;
        line-height:200%;
        color:black;
        margin-bottom:30px;
	}
	#noticeListBtn:focus { outline: none; }
</style>
<script type="text/javascript">
				$(function(){
					$("#noticeListBtn").click(function(){
						location.href = "/notice/noticeList";
					});
				});
			</script>
</head>
<body>

<!-- HEADER =============================-->
	<header class="item header margin-top-0">
		<div class="wrapper">
	   		<div class="container">
	      		<div class="row">
	         		<div class="col-md-12 text-center">
	            		<div class="text-pageheader">
	               			<div class="subtext-image" data-scrollreveal="enter bottom over 1.7s after 0.0s">
	                   			NOTICE
	               			</div>
	            		</div>
	         		</div>
	      		</div>
	   		</div>
		</div>
	</header>


<!-- CONTENT =============================-->

	<div class="container toparea">
	   <div class="underlined-title">
	      <div class="editContent">
	         <h1 class="text-center latestitems">공지사항</h1>
	      </div>
	      <div class="wow-hr type_short">
	         <span class="wow-hr-h">
		         <i class="fa fa-star"></i>
		         <i class="fa fa-star"></i>
		         <i class="fa fa-star"></i>
	         </span>
	      </div>
	   </div>
<!-- NAVBAR=============================== -->
   
        
 <!-- CONTENT============================== -->       
			<div class="">
						<div class="fontchange">
							<div class="text-right">
								<input type="button" class="btn btn-info" value="" id="noticeListBtn" />
							</div>
							<br/>
						<table class="table table-bordered">
							<tbody>
								<tr>
									<td class="col-md-1 text-center">번호</td>
									<td class="col-md-1 text-center" >${detail.n_no }</td>
									<td class="col-md-1">작성자</td>
									<td class="col-md-1 text-center">${detail.a_name }</td>
									<td class="col-md-1">${detail.n_date }</td>
								</tr>
								<tr>
									<td class="col-md-1">제목</td>
									<td colspan="4" class="col-md-2">${detail.n_title} <span class="text-right">(조회수 : ${detail.n_readcnt })</span></td>
								</tr>
								<tr class="table-tr-height">
									<td class="col-md-1">내용</td>
									<td colspan="4" class="col-md-8 text-left">${detail.n_content }</td>
								</tr>
							</tbody>
						</table>
						</div>
					</div>
		</div>


<!-- SCRIPTS =============================-->
<script src="/resources/include/scorilo/js/jquery-.js"></script>
<script src="/resources/include/scorilo/js/bootstrap.min.js"></script>
<script src="/resources/include/scorilo/js/anim.js"></script>

</body>
</html>