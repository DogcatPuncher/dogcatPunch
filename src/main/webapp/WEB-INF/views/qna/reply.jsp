<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<style>
		#item-template{display:none;}
		
		/* @font-face {
		  font-family: SCDream5;
		  src: url('/resources/include/dist/fonts/SCDream5.otf'); 
		}
		
		body {
			font-family: SCDream5;
		}
		 */
		.replyBtn{
			background: url( "/resources/images/common/reply.png" ) no-repeat;
	        border: none;
	        font-size : 13px;
	        width: 50px;
	        height: 40px;
	        background-size: contain;
	        cursor: pointer;
	        color:black;
	        margin-bottom:30px;
		} 
		
	</style>
	<script>
		$(function() {
			let q_num = ${detail.q_num};
			listAll(q_num);
			
			//$("#replyInsertBtn").click(function() {
			$(document).on("click", "#replyInsertBtn", function() {
				let insertUrl = "/qreplies/replyInsert";
				
				let value = JSON.stringify({
					q_num:q_num,
					r_name:$("#r_name").val(),
					r_pwd:$("#r_pwd").val(),
					r_content:$("#r_content").val()
				});
				
				$.ajax({
					url : insertUrl,
					type : "post",
					headers : {
						"Content-Type":"application/json"
					},
					dataType:"text",
					data : value,
					error : function(xhr, textStatus, errorThrown) {
						alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
					},
					beforeSend: function() {
						if(!checkForm("#r_name", "작성자를")) return false;
						else if(!checkForm("#r_pwd","비밀번호를")) return false;
						else if(!checkForm("#r_content", "답변을")) return false;
					},
					success : function(result){
						if(result=="SUCCESS"){
							alert("답변 등록이 완료되었습니다.");
							dataReset();
							listAll(q_num);
						}
					}
				})
				
			})
				$(document).on("click", "button[data-btn='delBtn']", function(){
					let r_num = $(this).parents("div.panel").attr("data-num");
					deleteBtn(q_num, r_num);
				})

				$(document).on("click", "button[data-btn='upBtn']", function() {
					let panel = $(this).parents("div.panel")
					let r_num = panel.attr("data-num");
					updateForm(r_num, panel);
				})
				
				$(document).on("click", "#replyUpdateBtn", function() {
					let r_num = $(this).attr("data-rnum");
					$.ajax({
						url: '/qreplies/' + r_num,
						type: 'put',
						headers: {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "PUT" },
						data:JSON.stringify({
							r_content:$("#r_content").val(),
							r_pwd:$("#r_pwd").val()
						}),
						dataType : 'text',
						error : function(xhr, textStatus, errorThrown) {
							alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
						},
						beforeSend: function() {
							if(!checkForm("#r_content", "답변을")) return false;
						},
						success:function(result) {
							console.log("result: " + result);
							if(result == "SUCCESS") {
								alert("답변 수정이 완료되었습니다.");
								dataReset();
								listAll(q_num);
							}
						}
					})
				})
					
				
		});
		
		
		function updateForm(r_num, panel){
			$("#r_name").val(panel.find(".panel-title .name").html());
			$("#r_name").prop("readonly", true);
			
			let content = panel.find(".panel-body").html();
			content = content.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
			$("#r_content").val(content);
			
			$("#replyForm button[type='button']").attr("id", "replyUpdateBtn");
			$("#replyForm button[type='button']").attr("data-rnum", r_num);
		}
		
		function listAll(q_num) {
			$(".reply").detach();
			
			let url = "/qreplies/all/" + q_num;
			
			$.getJSON(url, function(data) {
				$(data).each(function() {
					let r_num = this.r_num;
					let r_name = this.r_name;
					let r_content = this.r_content;
					let r_date = this.r_date;
					r_content = r_content.replace(/(\r\n|\r|\n)/g, "<br />");
					template(r_num, r_name, r_content, r_date);
				})
			}).fail(function() {
				alert("답변 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해주세요.")
			})
		}
		
			function template(r_num, r_name, r_content, r_date) {
				let $div = $('#reviewList');
				
				let $element = $('#item-template').clone().removeAttr('id');
				$element.attr("data-num", r_num);
				$element.addClass("reply");
				$element.find('.panel-heading > .panel-title > .name').html(r_name + "님");
				$element.find('.panel-heading > .panel-title > .date').html(" / " + r_date);
				$element.find('.panel-body').html(r_content);
				
				$div.append($element);
			}
		
			function dataReset() {
				$("#replyForm").each(function() {
					this.reset();
				})
				
				$("#r_name").prop("readonly", false);
				$("#replyForm button[type='button']").removeAttr("data-rnum");
				$("#replyForm button[type='button']").attr("id", "replyInsertBtn");
			}		
			
			function deleteBtn(q_num, r_num) {
				if(confirm("답변을 삭제하시겠습니까?")) {
					$.ajax({
						url : '/qreplies/' + r_num,
						type : 'delete',
							headers : {
								"X-HTTP-Method-Override" : "DELETE"
						},
					dataType : 'text',
					error : function(xhr, textStatus, errorThrown) {
						alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
					},
					success : function(result) {
						console.log("result: " + result);
						if(result == 'SUCCESS') {
							alert("답변 삭제가 완료되었습니다.");
							listAll(q_num);
						}
					} 
				})					
			}
		}
		
	</script>
	</head>
	<body>
		<div id="replyContainer">
			
			<c:choose>
			<c:when test="${lmember.user_no!=detail.user_no}">
				<form id="replyForm" name="replyForm" >
					<div class="panel panel-default">
						<table class="table">
							<tbody>
								<tr>
									<!-- <td class="col-md-1">작성자</td> -->
									<td class="col-md-3 text-left">
										<input type="text" name="r_name" id="r_name" maxlength="5" class="form-control" value="관리자"/>
									</td>
									<td class="col-md-1">비밀번호</td>
									<td class="col-md-3 text-left">
										<input type="password" name="r_pwd" id="r_pwd" maxlength="18" class="form-control" value="admin"/>
									</td>
									<td class="col-md-4">
										<button type="button" id="replyInsertBtn" class="replyBtn">등록</button>
									</td>
								</tr>
								<tr>
									<!-- <td class="col-md-1">답변내용</td> -->
									<td colspan="4" class="text-left">
										<textarea name="r_content" id="r_content" class="form-control" rows="3"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</form>
			</c:when>
			</c:choose>
				
				<div id="reviewList">
					<div id="item-template" class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">
								<span class="name"></span>
								<span class="date"></span>
								<c:choose>
								<c:when test="${lmember.user_no!=detail.user_no}">
									<button type="button" data-btn="upBtn" class="replyBtn">수정</button>
									<button type="button" data-btn="delBtn" class="replyBtn">삭제</button>
								</c:when>
								</c:choose>
							</h3>
						</div>
					<div class="panel-body"></div>
				</div>
		</div>
		
		</div>
		
	</body>
</html>