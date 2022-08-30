<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page trimDirectiveWhitespaces="true" %>
<c:set var="uri" value='${requestScope["javax.servlet.forward.request_uri"]}' />

				<ul class="nav nav-sidebar">
					<li  <c:if test="${fn:containsIgnoreCase(uri, '/admin/mainPage')}">class="active"</c:if>>
						<a href="/admin/mainPage">HOME</a>
					</li>
					<li <c:if test="${fn:containsIgnoreCase(uri, '/admin/member/memberList')}">class="active"</c:if>>
					<a href="/admin/member/memberList">회원관리</a>
					</li>
					<li <c:if test="${fn:containsIgnoreCase(uri, '/admin/hotel/hotelList')}">class="active"</c:if>>
					<a href="/admin/hotel/hotelList">숙소게시판관리</a>
					</li>
					<li <c:if test="${fn:containsIgnoreCase(uri, '/admin/notice/noticeList')}">class="active"</c:if>>
					<a href="/admin/notice/noticeList">공지사항</a>
					</li>
					<li <c:if test="${fn:containsIgnoreCase(uri, '/admin/qna/qnaList')}">class="active"</c:if>>
					<a href="/admin/qna/qnaList">QnA게시판관리</a>
					</li>
					<li <c:if test="${fn:containsIgnoreCase(uri, '/admin/member/reservList')}">class="active"</c:if>>
					<a href="/admin/member/reservList">예약내역관리</a>
					</li>
				</ul>
				<!--  
				<ul class="nav nav-sidebar">
					<li><a href="">Nav item <span class="sr-only">(current)</span></a></li>
					<li><a href="">Nav item again</a></li>
					<li><a href="">One more nav</a></li>
					<li><a href="">Another nav item</a></li>
					<li><a href="">More navigation</a></li>
				</ul>
				<ul class="nav nav-sidebar">
					<li><a href="">Nav item again</a></li>
					<li><a href="">One more nav</a></li>
					<li><a href="">Another nav item</a></li>
				</ul> -->