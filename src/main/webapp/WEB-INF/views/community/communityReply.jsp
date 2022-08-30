<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
	<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<title></title>
	
	<link rel="shortcut icon" href="/resources/include/scorilo/images/dogpaw.svg" />
	<link rel="apple-touch-icon" href="/resources/include/scorilo/images/dogpaw.svgg" />
	
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/bootstrap-theme.min.css"/>
	<!--<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/justified-nav"/>-->
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/style.css" >
	<link href="https://fonts.googleapis.com/css?family=Dosis:200,300,400,500,600,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Roboto:200,300,400,500,600,700" rel="stylesheet">
	<style>
		#item-template{display:none;}
		
		@font-face {
		  font-family: SCDream5;
		  src: url('/resources/include/dist/fonts/SCDream5.otf'); 
		}
		
		body {
			font-family: SCDream5;
		}
		
		.replyBtn{
			background: url( "/resources/images/common/insertbtn.png" ) no-repeat;
	        border: none;
	        font-size : 13px;
	        width: 50px;
	        height: 40px;
	        background-size: contain;
	        cursor: pointer;
	        color:black;
		}
		.update{
			background: url( "/resources/images/common/updatebtn.png" ) no-repeat;
	        border: none;
	        font-size : 13px;
	        width: 50px;
	        height: 40px;
	        background-size: contain;
	        cursor: pointer;
	        color:black;
	        outline:none;
		}
		.del{
			background: url( "/resources/images/common/delbtn.png" ) no-repeat;
	        border: none;
	        font-size : 13px;
	        width: 50px;
	        height: 40px;
	        background-size: contain;
	        cursor: pointer;
	        color:black;
		}
		
		panel{
			/* border: 2px solid rgb(255, 165, 0, 0.3); */
		}
		.panel-heading{
			background-color: rgb(255, 165, 0, 0.3);
		}
		.reply{
			border: 2px solid rgb(255, 165, 0, 0.3);
		}
	</style>
	<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script type="text/javascript" src="/resources/include/scorilo/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function(){
			let b_no = ${detail.b_no};
			listAll(b_no);
			
			$(document).on("click","#replyInsertBtn",function(){
				let insertUrl = "/replies/replyInsert";
				
				let value = JSON.stringify({
					b_no:b_no,
					/* com_rname:$('#com_rname').val(), */
					com_rname:com_rname,
					com_rcontent:$('#com_rcontent').val()
				
				});
				
				$.ajax({
					url:insertUrl,
					type:"post",
					headers : {
						"Content-Type" : "application/json"
					},
					dataType:"text",
					data:value,
					error:function(xhr,textStatus, errorThrown){
						alert(textStatus + "(HTTP-" +xhr.status+" / "+errorThrown+")");
					},
					beforeSend:function(){
						if(!checkForm("#com_rcontent","댓글내용을")) return false;
					},
					success : function(result){
						if(result=="SUCCESS"){
							alert("댓글 등록이 완료되었습니다.");
							dataReset();
							listAll(b_no);
						}
					}
				});
			});
			
			/*비밀번호 확인없이 수정버튼*/
			$(document).on("click","button[data-btn='upBtn']",function(){
				let panel = $(this).parents("div.panel")
				let com_rno = panel.attr("data-num");
				
				updateForm(com_rno, panel);
			});
			
			function updateForm(com_rno, panel){
				$("#com_rname").val(panel.find(".panel-title .name").html());
				$("#com_rname").prop("readonly",true);
				let content = panel.find(".panel-body").html();
				content = content.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n'); //<br><br/><br />
				$("#com_rcontent").val(content);
			
				$("#replyForm button[type='button']").attr("id","replyUpdateBtn");
				$("#replyForm button[type='button']").attr("data-com_rno",com_rno);
			}
			
			$(document).on("click","#replyUpdateBtn",function(){
				let com_rno = $(this).attr("data-com_rno");
				$.ajax({
					url:'/replies/'+com_rno,
					type:'put',
					headers: {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "PUT"},
					data:JSON.stringify({
						com_rcontent:$("#com_rcontent").val(),
					}),
					dataType:'text',
					error:function(xhr, textStatus, errorThrown){
						alert(textStatus + " (HTTP-"+xhr.status+" / " + errorThrown + ")");
					},
					beforeSend:function(){
						if(!checkForm("#com_rcontent","댓글내용을")) return false;
					},
					success:function(result){
						console.log("result: "+result);
						if(result == "SUCCESS"){
							alert("댓글 수정이 완료되었습니다.");
							dataReset();
							listAll(b_no);
						}
					}
				});
			});
			
			$(document).on("click","button[data-btn='delBtn']",function(){
				let com_rno = $(this).parents("div.panel").attr("data-num"); //this=event가 발생한 자기 자신
				deleteBtn(b_no,com_rno);
			});
		});
		function listAll(b_no){
			$(".reply").detach();
			let url = "/replies/all/"+b_no;
			
			$.getJSON(url, function(data){ 
				$(data).each(function(){
					let com_rno = this.com_rno;
					let com_rname = this.user_id;
					let com_rcontent = this.com_rcontent;
					let com_rdate = this.com_rdate;
					com_rcontent = com_rcontent.replace(/(\r\n|\r\n)/g, "<br/>");
					template(com_rno,com_rname,com_rcontent,com_rdate);
				});
			}).fail(function(){
				alert("댓글 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
			});
		}
		function template(com_rno, com_rname, com_rcontent, com_rdate){
			let $div = $('#reviewList');
			
			let $element = $('#item-template').clone().removeAttr('id');
			$element.attr("data-num",com_rno);
			$element.addClass("reply");
			$element.find('.panel-heading > .panel-title > .name').html(com_rname+"님");
			$element.find('.panel-heading > .panel-title > .date').html(" / "+com_rdate);
			
			let userID = "${data.user_id}";
			if(userID != com_rname){
				$element.find('.panel-heading > .panel-title > button').detach();
			}
			
			$element.find('.panel-body').html(com_rcontent);
			
			
			$div.append($element);
		}
		/*입력 폼 초기화*/
		function dataReset(){
			$("#replyForm").each(function(){
				this.reset();
			});
			$("#replyForm button[type='button']").removeAttr("data-rnum");
			$("#replyForm button[type='button']").attr("id","replyInsertBtn");
		}
		function deleteBtn(b_no,com_rno){
			if(confirm("선택하신 댓글을 삭제하시겠습니까?")){
				$.ajax({
					url : '/replies/' +com_rno,
					type: 'delete', //method-get(조회)/post(입력)/put(수정)/delete(삭제) 존재
					headers : {
						"X-HTTP-Method-Override" : "DELETE"
					},
					dataType : 'text',
					error : function(xhr, textStatus, errorThrown){ //실행시 오류가 발생했을 경우
						alert(textStatus + " (HTTP -" +xhr.status + " / " + errorThrown + ")");
					},
					success : function(result){
						console.log("result : "+result);
						if(result == 'SUCCESS'){
							alert("댓글 삭제가 완료되었습니다.");
							dataReset();
							listAll(b_no);
						}
					}
				});
			}
		}
	</script>
</head>
<body>
	<div class="container toparea">
		<div id="replyContainer">
			<%--댓글 리스트 화면 --%>
			<form id="replyForm" name="replyForm">
				<div class="panel panel-default">
					<table class="table">
						<tbody>
							<tr>
								<td class="col-md-1">작성자</td>
								<td class="text-left" id="com_rname">${data.user_id}</td>	
								<!--<td class="col-md-1">작성자</td>
								<td class="col-md-3 text-left">
									<input type="text" name="r_name" id="r_name" maxlength="5" class="form-control" />
								</td>  -->
								<td class="col-md-4">				
									<button type="button" id="replyInsertBtn" class="replyBtn"></button>
								</td>
							</tr>
							<tr>
								<td class="col-md-1">댓글내용</td>
								<td colspan="4" class="col-md-11 text-left">
									<textarea name="com_rcontent" id="com_rcontent" class="form-control" rows="3"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>
			<%--리스트 영역 --%>
			<div id="reviewList">
				<div id="item-template" class="panel">
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="name"></span>
							<span class="date"></span>
								<button type="button" data-btn="upBtn" class="update"></button>
								<button type="button" data-btn="delBtn" class="del"></button>
						</h3>
					</div>
				<div class="panel-body"></div>
			</div>
		</div>
	</div>
</body>
</html>