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
	
	<script src="/resources/include/js/summernote/summernote-lite.js"></script>
	<script src="/resources/include/js/summernote/lang/summernote-ko-KR.js"></script>

	<link rel="stylesheet" href="/resources/include/css/summernote/summernote-lite.css">
	
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
    <style>
    	#insertFormBtn {
	        background: url( "/resources/images/common/insertbtn.png" ) no-repeat;
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
      	#boardCancelBtn {
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
      	#insertFormBtn, #boardCancelBtn, #boardListBtn:focus { outline: none; }
    
    </style>
	<script type="text/javascript">
		$(function(){
			/*저장 버튼 클릭 시 처리 이벤트*/
			$("#insertFormBtn").click(function(){
				//입력값 체크
				if(!chkData("#d_title","제목을"))return;
				else if(!chkData("#summernote","작성할 내용을"))return;
				else if(!chkData("#file","썸네일 파일을"))return;
				else{
					if($("#file").val()!=""){
						if(!chkFile($("#file")))return;
					}
					$("#frm").attr({
						"method":"post",
						"enctype":"multipart/form-data",
						"action":"/diary/boardInsert"
					});
					$("#frm").submit();
				}
			});
			
			$("#boardCancelBtn").click(function(){
				$("#f_writeForm").each(function(){
					this.reset();
				});
			});
			
			/*목록 버튼 클릭 시 처리 이벤트*/
			$("#boardListBtn").click(function(){
				location.href="/diary/diaryBoardList";
			});
		});
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
	                   			Travel Diary
	               			</div>
	            		</div>
	         		</div>
	      		</div>
	   		</div>
		</div>
	</header>
	<div class="container toparea">
	<div class="diary text-center"><h3>여행 다이어리</h3></div>
		<form name="frm" method="post" enctype="multipart/form-data" id="frm">
			<table class="table table-bordered mt-1">
				<tr>
					<th style="vertical-align: middle;">제목</th>
					<td><input type="text" class="form-control" name="d_title" id="d_title" required="required" autofocus="autofocus"></td>
				</tr>
				<tr>
					<th align="center">작성자</th>
					<td class="text-left">${data.user_id}</td>
				</tr>
				<tr>
					<th align="center">내용</th>
					<td colspan="2">
						<textarea id="summernote" name="d_content" id="d_content" rows="10" cols="100" required="required"></textarea>
					</td>
				</tr>
				<tr>
					<td>썸네일이미지파일첨부</td>
					<td class="text-left"><input type="file" name="file" id="file"/></td>
				</tr>
			</table>
		</form>
		<div class="contentBtn text-right">
			<input type="button" value="" id="insertFormBtn"class="btn btn-warning">
			<input type="button" value="" id="boardCancelBtn"class="btn btn-warning">
			<input type="button" value="" id="boardListBtn"class="btn btn-warning">
		</div>
	</div>
<script type="text/javascript">
	
	$(document).ready(function(){
		$('#summernote').summernote({
			toolbar: [
			    // [groupName, [list of button]]
			    ['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['forecolor','color']],
			    ['table', ['table']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert',['picture','link','video']],
			    ['view', ['fullscreen', 'help']]
			  ],
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
	        placeholder: '내용을 작성하세요',
	        height: 400,
	        maxHeight: 400,
	        callbacks : {
	        	onImageUpload : function(files, editor, welEditable){
	        		for(var i = files.length - 1; i >= 0; i--){
	        			uploadSummernoteImageFile(files[i],this);
	        		}
	        	}
	        }
	        
	   	});
	});
	function uploadSummernoteImageFile(file, el) {
		data = new FormData();
		data.append("file", file);
		$.ajax({                                                              
			data : data,
			type : "POST",
			url : 'uploadSummernoteImageFile',
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(data) {                                         
				$(el).summernote('editor.insertImage',data.url);
			}
		});
	}
</script>
</body>
</html>