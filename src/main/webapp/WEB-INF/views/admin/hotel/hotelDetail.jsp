<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<script type="text/javascript">
            $(function(){
               $("#hotelListBtn").click(function(){
                  location.href = "/admin/hotel/hotelList";
               });
               
               $("#hotelDeleteBtn").click(function(){
                  if(confirm("삭제하시겠습니까?")){
					goUrl = "/admin/hotel/hotelDelete";
					$("#f_data").attr("action", goUrl);
					$("#f_data").submit();
                  }
               })
               
               $("#hotelUpdateBtn").click(function(){
                  let goUrl = "";
                  goUrl = "/admin/hotel/updateForm";
                  $("#f_data").attr("action", goUrl);
                  $("#f_data").submit();
               })
            });
</script>     
</head>
<body>
         <div class="contentContainer container">
            <form id="f_data" name="f_data" method="post">
               <input type="hidden" name="hotel_no" value="${detail.hotel_no}"/>
            </form>
            <div class="contentTit page-header"><h3 class="text-center">${detail.hotel_name}</h3></div>
               <div class="contentTB text-center">
                  <div class="fontchange">
                     <div class="text-right">
                        <input type="button" class="btn btn-info" value="수정" id="hotelUpdateBtn" />
                        <input type="button" class="btn btn-info" value="삭제" id="hotelDeleteBtn" />
                        <input type="button" class="btn btn-info" value="목록" id="hotelListBtn" />
                     </div>
                  <table class="table table-bordered">
                     <tbody>
                        <tr>
                           <td class="col-md-1 text-center" >숙소명</td>
                           <td class="col-md-2 text-left">${detail.hotel_name}</td>
                           <td class="col-md-1">가격</td>
                           <td class="col-md-2 text-right">${detail.hotel_price } 원 / 일</td>
                        </tr>
                        <tr>
                           <td class="col-md-1">숙소주소</td>
                           <td colspan="4" class="col-md-8 text-left">${detail.hotel_address }</td>
                        </tr>
                        <tr>
                           <td class="col-md-1">전화번호</td>
                           <td colspan="4" class="col-md-8 text-left">${detail.hotel_tel }</td>
                        </tr>
                        <tr class="table-tr-height">
                           <td class="col-md-1">소개글</td>
                           <td colspan="4" class="col-md-8 text-left">${detail.hotel_info }</td>
                        </tr>
                        
                     </tbody>
                  </table>
                  </div>
               </div>
            </div>
            </body>