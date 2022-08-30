<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<link rel="stylesheet" href="/resources/include/css/summernote/summernote-lite.css">
	
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<script type="text/javascript">
   $(function(){
      $("#hotelListBtn").click(function(){
         location.href = "/admin/hotel/hotelList";
      });
      $("#hotelCancelBtn").click(function(){
         $("#h_updateForm").each(function(){
            this.reset();
         });
      });
      $("#hotelUpdateBtn").click(function(){
    	  
     	 var num_check=/^[0-9]*$/;
 		/* var phone_check=/^[0-9]{3,4}-[0-9]{3,4}-[0-9]{3,4}$/; */
 		var phone_check=/^[-0-9]*$/;
     	  
          if(!chkData("#hotel_name", "숙소명을")) return;
          else if(!chkData("#hotel_address", "주소를")) return;
          else if(!chkData("#hotel_price", "가격을")) return;
          else if(!chkData("#hotel_tel", "전화번호를")) return;
          else if(!chkData("#local_no", "지역번호를")) return;
          else if($("#file").val()!=""){
                if(!chkFile($("#file"))) return;
          }else {
         	 
         	 if(!num_check.test($("#hotel_price").val())) {
 					alert ("가격을 숫자로 입력해주세요." );
 					$("#hotel_price").focus;
 					return false;
 			} else if(!phone_check.test($("#hotel_tel").val())) {
 					alert ("전화번호를 숫자로 입력해주세요.(-포함)");
 					$("#hotel_tel").focus;
 					return false;
 			} if(!num_check.test($("#local_no").val())) {
 					alert ("지역번호를 숫자로 입력해주세요." );
 					$("#local_no").focus;
 					return false;
 			}
             
             $("#h_updateForm").attr({
                "method":"post",
                "enctype":"multipart/form-data",
                "action":"/admin/hotel/hotelUpdate"
             });
             $("#h_updateForm").submit();
          }
       });
   });
</script>

<body>
   <div class="container">
            <form id="h_updateForm" name="h_updateForm" class="form-horizontal" method="post" enctype="multipart/form-data">
				<input type="hidden" id="hotel_no" name="hotel_no" value="${updateData.hotel_no}"/>
				<input type="hidden" id="hotel_thumb" name="hotel_thumb" value="${updateData.hotel_thumb}"/>
               <table class="table table-bordered">
                  <colgroup>
                     <col width="20%" />
                     <col width="80%" />
                  </colgroup>
                  <tbody>
                     <tr>
                        <td style="vertical-align: middle;">숙소명</td>
                        <td><input type="text" class="form-control" name="hotel_name" id="hotel_name" value="${updateData.hotel_name }" autofocus="autofocus"></td>
                     </tr>
                     <tr>
                        <td style="vertical-align: middle;">주소</td>
                        <td><input type="text" class="form-control" name="hotel_address" id="hotel_address" value="${updateData.hotel_address }" autofocus="autofocus" ></td>
                     </tr>
                     <tr>
                        <td>소개글</td>
                        <td colspan="2">
                           <textarea id="summernote" name="hotel_info" rows="10" cols="10" required="required">${updateData.hotel_info }</textarea>
                        </td>                     
                     </tr>
                     <tr>
                        <td>가격</td>
                        <td><input type="text" class="form-control" name="hotel_price" id="hotel_price" value="${updateData.hotel_price }" autofocus="autofocus"></td>
                     </tr>
                     <tr>
                        <td>전화번호</td>
                        <td><input type="text" class="form-control" name="hotel_tel" id="hotel_tel" value="${updateData.hotel_tel }" autofocus="autofocus"></td>
                     </tr>
                     <tr>
                        <td>지역번호</td>
                        <td><input type="text" class="form-control" name="local_no" id="local_no" value="${updateData.local_no }" autofocus="autofocus"></td>
                     </tr>
                     <tr>
                        <td>썸네일이미지파일첨부</td>
                        <td class="text-left"><input type="file" name="file" id="file"/>${updateData.hotel_thumb }</td>
                     </tr>
                  </tbody>
               </table>
               
               <div class="text-right">
                  <input type="button" id="hotelUpdateBtn" value="수정" class="btn btn-info" />
                  <input type="button" id="hotelCancelBtn" value="취소" class="btn btn-info" />
                  <input type="button" id="hotelListBtn" value="목록" class="btn btn-info" />
               </div>
            </form>
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