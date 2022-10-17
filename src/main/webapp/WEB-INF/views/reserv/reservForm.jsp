<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

      <script src = "/resources/include/js/jquery-1.12.4.min.js"></script>
      <!-- Moment Js -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
      <!-- Lightpick CSS --> 
      <link rel = "stylesheet" href = "/resources/include/calendar/css/lightpick.css" >
      <!-- Lightpick JS --> 
      <script src = "/resources/include/calendar/js/lightpick.js" ></script>   
      <!-- import.payment.js -->
      <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
      
      <style>
      	
      	.lightpick__previous-action, .lightpick__next-action, .lightpick__close-action {background-color: #E3F6CE; font-size: 17px;}
      	.lightpick_month {width: 750px;}
      	.lightpick__day {font-size:18px;}
		.lightpick__day.is-today {background-size: 40%; color:#fff;}
      	.lightpick__day-of-the-week {  
      		font-size: 18px; 
      		color:#585858;}
      	.lightpick__month-title > .lightpick__select-months {font-size: 22px;}
      	.lightpick__day.is-start-date.is-in-range, .lightpick__day.is-end-date.is-in-range.is-flipped {background-color: #B7E2A4;}
      	.lightpick__day.is-end-date.is-in-range, .lightpick__day.is-start-date.is-in-range.is-flipped {background-color: #B7E2A4;}  
      	.lightpick__day.is-in-range {background-color: #B7E2A4;} 	
      	.lightpick__day.is-disabled.is-forward-selected:not(.is-start-date) { background-color: #A5BE99;}
      	#pay {
	        background: url( "/resources/images/common/paybtn.png" ) no-repeat;
	        border: none;
	        width: 100px;
	        height: 100px;
	        background-size: contain;
	        cursor: pointer;
	        line-height:200%;
	        color:black;
	        margin-bottom:30px;
	        justify-content: center;
    		display: inline-block;
       	}		
        #personalTable {
               border : 1px solid #ddd;
               margin-left:auto;
               margin-right:auto;
               width : 1140px;
               }
         #personalTable > tbody > tr > td {
            padding : 10px;
         }            
         #personalTable > tbody > tr > td > input { width : 200px;}  
         #agreeDiv {margin-top : 30px;}
         
         .title, .calendar {margin-top : 40px; margin-bottom : 40px;}
         
         input { border: none;}  
    	.lightpick{ z-index:1; }
    	.infoKey  > th {width:30%;}
    	#user_date {width:100%; text-align:center;}
    	.lightpick__month{width:750px;}
    	.reservation_Info, .personal_info, #agreeDiv{margin-top:80px;}
      </style>      
      
      <script type="text/javascript">
         $(function(){ 
            let price = "";
            let days = "";
            
            let checkin = "";
            let checkout = "";
            
            let hotel_no = ${hotelVO.hotel_no};
            let reservDate = "";
            let res_day = [];
            
            console.log("호텔번호 " + hotel_no);
            
            listAll(hotel_no);
            
            pickerData(res_day);
            
            function listAll(hotel_no){
                let url = "/reserv/reservDate/"+hotel_no;
                
                
                $.getJSON(url,function(data){
                   $(data).each(function(){
                      
                      checkin = this.checkin;
                      checkout = this.checkout;
                      
                      console.log(checkin + "/" + checkout);
                      
                      res_day.push([checkin,checkout]);
                   });
                   console.log(res_day);
                   for(var key in res_day){
                 		console.log('값 : ' + res_day[key]);
               		
               		console.log("moment : "  + moment(toString(res_day[key])).format('YYYY-MM-DD'));
               	}
                   
                   
                   
                }).fail(function(){
                   alert("예약일을 불러오는데 실패했습니다. 다시 시도해주세요.");
                })
             }
            
			
			function pickerData(res_day) {
            var picker = new Lightpick({
                field: document.getElementById('date'),
                inline : true,
                lang: 'ko',
                singleDate: false,
                minDate: moment().startOf('day'),
                minDays : 2,
                disableDates : [moment().startOf('month'), res_day],
                format: 'YYYY-MM-DD',
                onSelect: function(start, end){
                   
                    let date = $("#date").val();
                    let SplitDate = date.toString().split (' - ');
                    
                    let startDate = SplitDate[0];
                    let endDate = SplitDate[1];
                    
                    console.log("체크인 : "  + startDate);
                    console.log("체크아웃 : " + endDate);
                    
                    $("#user_date").val(startDate + " ~ " + endDate); 
                    $("#checkin").val(startDate); 
                    $("#checkout").val(endDate);
                    
                    days = moment(endDate).diff(startDate, 'days');
                    price = ${hotelVO.hotel_price} * days;
                    
                    $("#reserv_price").val(price);
                    $("#price").val(price + "원");
                    
                    if($("#price").val() == NaN){
                       "#price".type=hidden;
                    }
                    console.log($("#reserv_price").val());
                    console.log($("#price").val());
                }
            });
			}
            
            $("#pay").click(function(){
               if(!chkData("#checkin","예약 일자를 ")) return;
               if(!chkData("#checkout","예약 일자를" )) return;
               if($("#checkout").val().toString() == "...") {
                  alert("예약 일자를 입력해주세요.");
                  return;
               }
               
            	// 이름 유효성 검사
               var name = $("#name").val();
               
               if(!chkData("#name","예약자명을 ")) return;
               
               var n_RegExp = /^[가-힣]{2,15}$/;
               if(!n_RegExp.test(name)){            
                  alert("특수문자,영어,숫자는 사용할수 없습니다. 한글로 2자 이상 입력해주세요.");
                  $("#name").focus();
                  $("#name").val("");  
                  return false;        
               }
               
               // 전화번호 유효성 검사
               var phone = $("#phone").val();
               
               if(!chkData("#phone","예약자 전화번호를 ")) return;
               var p_RegExp = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;
               if(!p_RegExp.test(phone)){
                  alert("전화번호를 다시 입력해주세요. 010-1234-5678 또는 02-1234-5678의 형태로 입력하세요.");
                  $("#phone").focus();
                  $("#phone").val("");
                  return false;
               }
               
               // 예약 인원 유효성 검사
               var people = $("#people").val();
               
               if(!chkData("#people","예약 인원을 ")) return;
               var m_RegExp = /^[1-9]*$/;
               
               if(!m_RegExp.test(people)){
                  alert("예약 인원은 숫자만 입력하세요.");
                  $("#people").focus();
                  $("#people").val("");
                  return false;
               }
               
               if(people > 2){
                  alert("예약 인원을 잘못입력하셨습니다.");
                  $("#people").focus();
                  $("#people").val("");
                  return false;
               }
               
               // 이용동의 유효성 검사
               let isChecked = $("#agree").prop("checked"); 
               if(!isChecked){
                  alert("이용동의를 확인해주세요.");
                  return;
               }
              
               pay();
            });
               
               
            function pay(data){
               IMP.init('imp60663075'); // 관리자 콘솔 -> 가맹점 식별코드 
               IMP.request_pay({
                  pg: "html5_inicis",
                  pay_method:"card",
                  merchant_uid:"petcation_" + new Date().getTime(),	 // 결제 일련번호 : petcation_ + 현재 날짜 시간
                  name: "${hotelVO.hotel_name}",
                  amount: price,   	// 일수 * 금액
                  buyer_email : "pet@petcation.com",
                  buyer_name : "펫케이션",
                  buyer_tel : "02-1234-5678"
               },  function (rsp) { // callback함수 
                       if (rsp.success) {	// 결제 성공
                          alert('결제가 완료되었습니다.');
                          
                          $("#merchant_uid").val(rsp.merchant_uid);
                        
                        $("#reserv_form").attr({
                             "method" : "post",
                             "action" : "/reserv/reservInsert"
                          });
                        $("#reserv_form").submit();
                        } else {	//  결제 실패
                        let msg = '결제에 실패하였습니다. 에러내용 : ' + rsp.error_msg;
                        alert(msg);
                        document.location.href="/reserv/reservForm?hotel_no=" + ${hotelVO.hotel_no}; //alert창 확인 후 이동할 url 설정
                     }
               });
            }
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
                            RESERVATION
                           </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </header>
      <!-- CONTENT =============================-->
			<div class="container toparea">
		   		<div class="underlined-title">
		      	<div class="editContent">
		         <h1 class="text-center latestitems">숙소 예약</h1>
		      </div>
		      <div class="wow-hr type_short">
		         <span class="wow-hr-h">
		         <i class="fa fa-star"></i>
		         <i class="fa fa-star"></i>
		         <i class="fa fa-star"></i>
		         </span>
		      </div>
		   </div>
		
      <div class="container"> 
         
      
         <br/>
         
         <div class="text-center title">
            <h1>RESERVATION</h1>
         </div>
         
         <form id="reserv_form">
            <div id="dateDiv" class="text-center">
               <input type="hidden" id="date" name="Date">
               <input type="hidden" id="date" name="Date"> 
            </div>
            
               <input type="hidden" id="checkin" name="checkin">
               <input type="hidden" id="checkout" name="checkout">
               <input type="hidden" id="hotel_no" name="hotel_no" value="${hotelVO.hotel_no }">
               <input type="hidden" id="hotel_name" name="hotel_name" value="${hotelVO.hotel_name }"> 
               <input type="hidden" id="reserv_price" name="reserv_price" >    
             <input type="hidden" id="merchant_uid" name="merchant_uid" >
         
        
         <div class="reservation_Info">
            <h3>Reservation Info</h3>
            <div class="text-center">
            
               <table class="table table-bordered">
                  <tbody>
                     <tr class="infoKey">
                        <th class="text-center">숙소 이름</th>
                        <th class="text-center">예약 일시</th>
                        <th class="text-center">가격</th>
                     </tr>
                     <tr class="infoValue text-center">
                        <td id="hotel_name">${hotelVO.hotel_name }</td>
                        <td><input type="text" id="user_date" readonly=readonly></td>
                        <td><input type="text" class="text-center" id="price" readonly=readonly></td>
                     </tr>
                  </tbody>
               </table>
            </div>
         </div>
         
         <div class="personal_info">
         	<h3>Personal Info</h3>
         </div>
	         
	         
	     <div class="text-center" id="input">
	        <table id="personalTable" class="table table-boardred">
	     	   <colgroup>
	               <col width="20%" />
	               <col width="80%" />
	           </colgroup>
	           <tbody>
	              <tr>
	                 <td>이름 : </td>
	                 <td class="text-left"><input type="text" id="name" name="reserv_name" class="form-control" ></td>
	              </tr>
	              <tr>
	                 <td>전화번호 : </td>
	                 <td class="text-left"><input type="text" id="phone" name="reserv_phone" class="form-control"></td>
	              </tr>
	              <tr>
	                 <td>예약 인원 : </td>
	                 <td class="text-left"><input type="number" id="people" name="reserv_people" class="form-control" placeholder="숫자만 입력하세요."></td>
	              </tr>
	              <tr>
	                 <td>기타 : </td>
	                 <td class="text-left">
	       	            <textarea style="resize: none;" cols="100" rows="5" class="form-control" id="reserv_etc" name="reserv_etc" ></textarea>
	                 </td>
	              </tr>
	          </tbody>
	       </table>
	     </div>
	   </form>
      
      <div class="text-center" id="agreeDiv">
          <div class="text-center" id="agreeDiv2">
              <label>이용동의</label> <br/>
              <input type="checkbox" name="agree" id="agree">
               예약 취소는 체크인 날짜 기준 7일 전 까지 가능합니다. 
          </div>
      </div>   
      <br /><br />
         
      <div class="text-center">
          <input type="button" id="pay">
      </div>
         
      
      
         
      
         
      </div>
     </div>
   </body>
</html>



