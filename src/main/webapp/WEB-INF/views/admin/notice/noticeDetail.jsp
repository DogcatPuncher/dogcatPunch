
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<script type="text/javascript">
            $(function(){
               let goUrl = "";
               
               $("#noticeListBtn").click(function(){
                  location.href = "/admin/notice/noticeList";
               });
               
               $("#noticeDeleteBtn").click(function(){
                  if(confirm("삭제하시겠습니까?")){
                  goUrl = "/admin/notice/noticeDelete";
                  $("#f_data").attr("action", goUrl);
                  $("#f_data").submit();
                  }
               })
               
               $("#noticeUpdateBtn").click(function(){
                  let goUrl = "";
                  goUrl = "/admin/notice/updateForm";
                  $("#f_data").attr("action", goUrl);
                  $("#f_data").submit();
               })
            });
</script>     
</head>
<body>
         <div class="contentContainer container">
            <div class="contentTit page-header">
               
               <form name="f_data" id="f_data" method="post">
                  <input type="hidden" name="n_no" value="${detail.n_no}" />
               </form>
            
               <div class="contentTB text-center">
                  <div class="fontchange">
                     <div class="text-right">
                        <input type="button" class="btn btn-info" value="수정" id="noticeUpdateBtn" />
                        <input type="button" class="btn btn-info" value="삭제" id="noticeDeleteBtn" />
                        <input type="button" class="btn btn-info" value="목록" id="noticeListBtn" />
                     </div>
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
         </div>
            </body>