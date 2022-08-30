<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<title></title>
	
	<link rel="shortcut icon" href="/resources/image/icon.png"/>
	<link rel="apple-touch-icon" href="/resources/image/icon.png"/>
	
  	
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/bootstrap-theme.min.css"/>
	<!--<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/justified-nav"/>-->
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/style.css" >
	<link href="https://fonts.googleapis.com/css?family=Dosis:200,300,400,500,600,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Roboto:200,300,400,500,600,700" rel="stylesheet">
	<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script type="text/javascript" src="/resources/include/scorilo/js/bootstrap.min.js"></script>
	<style>
		#updateFormBtn{
    		background: url( "/resources/images/common/updatebtn.png" ) no-repeat;
	        border: none;
	        font-size : 13px;
	        color:#fff;
	        width: 60px;
	        height: 60px;
	        background-size: contain;
	        cursor: pointer;
	        line-height:200%;
	        color:black;
	        margin-bottom:25px;
    	}
    	#boardCancelBtn{
    		background: url( "/resources/images/common/cancelbtn.png" ) no-repeat;
	        border: none;
	        font-size : 13px;
	        color:#fff;
	        width: 60px;
	        height: 60px;
	        background-size: contain;
	        cursor: pointer;
	        line-height:200%;
	        color:black;
	        margin-bottom:25px;
    	}
    	#boardListBtn{
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
	        margin-bottom:25px;
    	}
    	#updateFormBtn, #boardCancelBtn, #boardListBtn:focus { outline: none; }
    	/*
		=====
		DEPENDENCES
		=====
		*/
		
		.r-link{
		  display: var(--rLinkDisplay, inline-flex) !important;
		}
		
		.r-link[href]{
		  color: var(--rLinkColor) !important;
		  text-decoration: var(--rLinkTextDecoration, none) !important;
		}
		
		.r-list{
		  padding-left: var(--rListPaddingLeft, 0) !important;
		  margin-top: var(--rListMarginTop, 0) !important;
		  margin-bottom: var(--rListMarginBottom, 0) !important;
		  list-style: var(--rListListStyle, none) !important;
		}
		
		
		/*
		=====
		CORE STYLES
		=====
		*/
		
		.menu{
		  --rLinkColor: var(--menuLinkColor, currentColor);
		}
		
		.menu__link{
		  display: var(--menuLinkDisplay, block);
		}
		
		/* 
		focus state 
		*/
		
		.menu__link:focus{
		  outline: var(--menuLinkOutlineWidth, 2px) solid var(--menuLinkOutlineColor, currentColor);
		  outline-offset: var(--menuLinkOutlineOffset);
		}
		
		/* 
		fading siblings
		*/
		
		.menu:hover .menu__link:not(:hover){
		  /* --rLinkColor: var(--menuLinkColorUnactive, rgba(22, 22, 22, .35)); */
		  --rLinkColor: var(--menuLinkColorUnactive, rgba(58, 91, 160, .35));
		}
		
		/*
		=====
		PRESENTATION STYLES
		=====
		*/
		
		.menu{
		  background-color: var(--menuBackgroundColor, #FFE5B4);
		  box-shadow: var(--menuBoxShadow, 0 1px 3px 0 rgba(0, 0, 0, .12), 0 1px 2px 0 rgba(0, 0, 0, .24));
		}
		
		.menu__list{
		  display: flex;
		  text-align: center; 
		}
		
		.menu__link{
		  padding: var(--menuLinkPadding, 1.5rem 2.5rem);
		  font-weight: 700;
		  text-transform: uppercase;
		}
		
		/* 
		=====
		TEXT UNDERLINED
		=====
		*/
		
		.text-underlined{
		  position: relative;
		  overflow: hidden;
		
		  will-change: color;
		  transition: color .25s ease-out;  
		}
		
		.text-underlined::before, 
		.text-underlined::after{
		  content: "";
		  width: 0;
		  height: 3px;
		  background-color: var(--textUnderlinedLineColor, #3A5BA0);
		
		  will-change: width;
		  transition: width .1s ease-out;
		
		  position: absolute;
		  bottom: 0;
		}
		
		.text-underlined::before{
		  left: 50%;
		  transform: translateX(-50%); 
		}
		
		.text-underlined::after{
		  right: 50%;
		  transform: translateX(50%); 
		}
		
		.text-underlined:hover::before, 
		.text-underlined:hover::after{
		  width: 100%;
		  transition-duration: .2s;
		}
		
		/*
		=====
		SETTINGS
		=====
		*/
		
		.page__custom-settings{
		  --menuBackgroundColor: #6c5ce7;
		  --menuLinkColor: #fff;
		  --menuLinkColorUnactive: #241c69;
		  --menuLinkOutlineOffset: -.5rem; 
		}
		
		/*
		=====
		DEMO
		=====
		*/
		
		/* body > div.page {
		  font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Open Sans, Ubuntu, Fira Sans, Helvetica Neue, sans-serif;
		  margin: 0;
		  min-height: 100vh;
		  display: flex;  
		  flex-direction: column;
		} */
		
		.page{
		  box-sizing: border-box;
		  /* max-width: 640px; */
		  padding-left: .75rem;
		  padding-right: .75rem;
		  margin: auto;
		}
		
		.page__menu:nth-child(n+2){
		  margin-top: 3rem;
		}
		
		
		.substack{
		  border:1px solid #EEE; 
		  background-color: #fff;
		  width: 100%;
		  max-width: 480px;
		  height: 280px;
		  margin: 1rem auto;;
		}
		
		.linktr{
		  display: flex;
		  justify-content: flex-end;
		  padding: 2rem;
		  text-align: center;
		}
		
		.linktr__goal{
		  background-color: rgb(209, 246, 255);
		  color: rgb(8, 49, 112);
		  box-shadow: rgb(8 49 112 / 24%) 0px 2px 8px 0px;
		  border-radius: 2rem;
		  padding: .75rem 1.5rem;
		}
		
		.r-link{
		    --uirLinkDisplay: var(--rLinkDisplay, inline-flex);
		    --uirLinkTextColor: var(--rLinkTextColor);
		    --uirLinkTextDecoration: var(--rLinkTextDecoration, none);
		
		    display: var(--uirLinkDisplay) !important;
		    color: var(--uirLinkTextColor) !important;
		    text-decoration: var(--uirLinkTextDecoration) !important;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			$("#boardListBtn").click(function(){
				location.href = "/community/communityBoardList/${c_no}";
			});
			$("#boardCancelBtn").click(function(){
				$("#f_updateForm").each(function(){
					this.reset();
				});
			});
			$("#updateFormBtn").click(function(){
				if(!chkData("#b_title","제목을")) return;
				else if(!chkData("#b_content","작성할 내용을")) return;
				else{
					if($("#file").val()!=""){
						if(!chkFile($("#file"))) return;
					}
					$("#f_updateForm").attr({
						"method":"post",
						"enctype":"multipart/form-data",
						"action":"/community/boardUpdate/"+${c_no}
					});
					$("#f_updateForm").submit();
				}
			});
		})
	</script>
</head>
<body>
	<header class="item header margin-top-0">
		<div class="wrapper">
	   		<div class="container">
	      		<div class="row">
	         		<div class="col-md-12 text-center">
	            		<div class="text-pageheader">
	               			<div class="subtext-image" data-scrollreveal="enter bottom over 1.7s after 0.0s">
	                   			COMMUNITY
	               			</div>
	            		</div>
	         		</div>
	      		</div>
	   		</div>
		</div>
	</header>
	<div class="container toparea">
		<div class="page" style="display: flex; align-items: center; justify-content: center; text-align: center;">
	        <nav class="page__menu menu" style="display: inline-block;">
	        	<ul class="menu__list r-list">
			          <li class="menu__group"><a href="/community/communityBoardList/1" class="menu__link r-link text-underlined">잡담</a></li>
			          <li class="menu__group"><a href="/community/communityBoardList/2" class="menu__link r-link text-underlined">여행후기</a></li>
			          <li class="menu__group"><a href="/community/communityBoardList/3" class="menu__link r-link text-underlined">꿀팁공유</a></li>
			          <li class="menu__group"><a href="/community/communityBoardList/4" class="menu__link r-link text-underlined">고민상담</a></li>
			          <li class="menu__group"><a href="/community/communityBoardList/5" class="menu__link r-link text-underlined">무료나눔</a></li>
			          <li class="menu__group"><a href="/notice/noticeList" class="menu__link r-link text-underlined">공지사항</a></li>
			        </ul>
	        </nav>
	    </div>
        <br/>
        <div class="contentContainer container">
        	<div class="contentTB text-center">
        		<form id="f_updateForm" name="f_updateForm">
        			<input type="hidden" id="b_no" name="b_no" value="${updateData.b_no}"/>
        			<input type="hidden" id="user_id" name="user_id" value="${updateData.user_id}"/>
					<input type="hidden" id="b_file" name="b_file" value="${updateData.b_file}"/>
					<table class="table table-bordered">
						<tbody>
							<tr>
								<td class="col-md-4">글제목</td>
								<td colspan="3" class="text-left">
								<input type="text" name="b_title" id="b_title" value="${updateData.b_title}" class="form-control"/>
								</td>
							</tr>
							<tr>
								<td class="col-md-3">글번호</td>
								<td class="text-left col-md-3">${updateData.b_no}</td>
								<td class="col-md-3">작성일</td>
								<td class="text-left col-md-3">${updateData.b_regdate}</td>
							</tr>
							<tr>
								<td>작성자</td>
								<td colspan="3" class="text-left">${updateData.user_id}</td>
							</tr>
							<tr class="table-tr-height">
								<td>내용</td>
								<td colspan="3" class="text-left">
									<textarea name="b_content" id="b_content" class="form-control" rows="8">${updateData.b_content}</textarea>
								</td>
							</tr>
							<tr>
								<td>이미지 파일 첨부</td>
								<td colspan="3" class="text-left"><input type="file" name="file" id="file" /></td>
							</tr>
						</tbody>
					</table>
        		</form>
        	</div>
        </div>
        <div class="contentBtn text-right">
			<input type="button" value="" id="updateFormBtn"class="btn btn-warning"></button>
			<input type="button" value="" id="boardCancelBtn"class="btn btn-warning"></button>
			<input type="button" value="" id="boardListBtn"class="btn btn-warning"></button>
		</div>
	</div>
<!-- SCRIPTS =============================-->
<script src="/resources/include/scorilo/js/jquery-.js"></script>
<script src="/resources/include/scorilo/js/bootstrap.min.js"></script>
<script src="/resources/include/scorilo/js/anim.js"></script>
</body>
</html>