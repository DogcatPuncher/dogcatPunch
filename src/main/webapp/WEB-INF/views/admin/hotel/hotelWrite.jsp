<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
	<link href="/resources/include/dist/css/bootstrap.min.css" rel="stylesheet">
	
	
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script type="text/javascript" src="/resources/include/scorilo/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/bootstrap-theme.min.css"/>
	<!--<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/justified-nav"/>-->
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/style.css" >
	<link href="https://fonts.googleapis.com/css?family=Dosis:200,300,400,500,600,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Roboto:200,300,400,500,600,700" rel="stylesheet">
	<link rel="stylesheet" href="/resources/include/css/summernote/summernote-lite.css">
	
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
    
    <script src="/resources/include/js/summernote/summernote-lite.js"></script>
	<script src="/resources/include/js/summernote/lang/summernote-ko-KR.js"></script>
		    <script type="text/javascript">
						$(function(){
							var num_check=/^[0-9]*$/;
							/* var phone_check=/^[0-9]{3,4}-[0-9]{3,4}-[0-9]{3,4}$/; */
							var phone_check=/^[-0-9]*$/;
							
							$("#hotelInsertBtn").click(function(){
								if(!chkData("#hotel_name", "숙소명을")) return;
								else if(!chkData("#hotel_address", "주소를")) return;
								else if(!chkData("#hotel_price", "가격을")) return;
								else if(!chkData("#hotel_tel", "전화번호를")) return;
								else if(!chkData("#local_no", "지역번호를")) return;
								else if(!chkData("#file", "썸네일 사진을")) return;
								else {
									/*if($("#file").val() != ""){
										if(!chkFile($("#file"))) return;
									}*/
									
									if(!num_check.test($("#hotel_price").val())) {
										alert ("가격을 숫자로 입력해주세요." );
										$("#hotel_price").val("");
										$("#hotel_price").focus;
										return false;
									} else if(!phone_check.test($("#hotel_tel").val())) {
										alert ("전화번호를 숫자로 입력해주세요.(-포함)");
										$("#hotel_tel").val("");
										$("#hotel_tel").focus;
										return false;
									} if(!num_check.test($("#local_no").val())) {
										alert ("지역번호를 숫자로 입력해주세요." );
										$("#local_no").val("");
										$("#local_no").focus;
										return false;
									}
									
									$("#h_writeForm").attr({
										"method" : "post",
										"enctype": "multipart/form-data", // enctype 속성의 기본 값은 "application/x-www-form-urlcencoded" POST방식 폼 전송에 기본 값으로 사용
										"action" : "/admin/hotel/hotelInsert"
									});
									$("#h_writeForm").submit();
								}
							})
							
							$("#formCancelBtn").click(function(){
								$("#h_writeForm").each(function(){
									this.reset();
								})
							})
							
							$("#hotelListBtn").click(function(){
								location.href="/admin/hotel/hotelList"
							})
						})
					</script>
					
		</head>
		<body>
			<div class="container toparea">
	<div class="diary text-center"><h3>숙소 추가</h3></div>
		<form name="h_writeForm" id="h_writeForm">
			<table class="table table-bordered mt-1">
							<tr>
								<td style="vertical-align: middle;">숙소명</td>
								<td><input type="text" class="form-control" name="hotel_name" id="hotel_name" autofocus="autofocus"></td>
							</tr>
							<tr>
								<td style="vertical-align: middle;">주소</td>
								<td><input type="text" class="form-control" name="hotel_address" id="hotel_address" autofocus="autofocus"></td>
							</tr>
							<tr>
								<td>소개글</td>
								<td colspan="2">
									<textarea id="summernote" name="hotel_info" rows="10" cols="10" required="required"></textarea>
								</td>							
							</tr>
							<tr>
								<td>가격</td>
								<td><input type="text" class="form-control" name="hotel_price" id="hotel_price" autofocus="autofocus"></td>
							</tr>
							<tr>
								<td>전화번호</td>
								<td><input type="text" class="form-control" name="hotel_tel" id="hotel_tel" autofocus="autofocus"></td>
							</tr>
							<tr>
								<td>지역번호</td>
								<td><input type="text" class="form-control" name="local_no" id="local_no" autofocus="autofocus"></td>
							</tr>
							<tr>
								<td>썸네일이미지파일첨부</td>
								<td class="text-left"><input type="file" name="file" id="file"/></td>
							</tr>
			</table>
		</form>
		<div class="contentBtn text-right">
			<input type="button" value="저장" id="hotelInsertBtn"class="btn btn-info" />
			<input type="button" value="취소" id="formCancelBtn"class="btn btn-info" />
			<input type="button" value="목록" id="hotelListBtn"class="btn btn-info" />
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