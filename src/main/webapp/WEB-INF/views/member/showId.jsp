<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		
	<title>Insert title here</title>
	</head>
	<script>

	</script>
	<body>

		<div>
		<br/>
		<br/>
			<div>
				<div>
					<a>U ´ᴥ` U 고객님의 아이디는 ${user_id} 입니다</a>
				</div>
				<br/><br/><br/>
				<div style="float:left;">
					<a href="/member/login" style="text-decoration:none;"><img src="/resources/images/common/id.png" style="width:60px; height:60px; text-decoration:none;"/><br/>로그인</a>
				</div>
				<br/>
				<div style="float:left;">
					<a href="/member/findPw" style="text-decoration:none;"><img src="/resources/images/common/id2.png" style="width:60px; height:60px; text-decoration:none;"/><br/>비밀번호찾기</a>
				</div>				
			</div>
		<br/>
		<br/>
		</div>
	</body>
</html>