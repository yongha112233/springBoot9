<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<script>
  function userDeleteCheck() {
	  let ans = confirm("회원 탈퇴하시겠습니까?");
	  if(ans) {
		  ans = confirm("탈퇴하시면 1개월간 같은 아이디로는 다시 가입하실수 없습니다.\n그래도 탈퇴 하시겠습니까?");
		  if(ans) {
			  $.ajax({
				  url  : '${ctp}/member/userDelete',
				  type : 'post',
				  success: (res) => {
					  if(res != '0') {
						  alert("회원에서 탈퇴 되셨습니다.");
						  location.href = '${ctp}/member/memberLogin';
					  }
					  else alert("회원 탈퇴 실패~~");
				  },
				  error : () => alert("전송오류!")
			  });
		  }
	  }
  }
</script>

<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-black w3-card">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <!-- <a href="http://192.168.50.215:9090/springGroupS/" class="w3-bar-item w3-button w3-padding-large">HOME</a> -->
    <a href="http://localhost:9090/springGroupS/" class="w3-bar-item w3-button w3-padding-large">HOME</a>
    <a href="${ctp}/guest/guestList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Guest</a>
    <c:if test="${sLevel <= 3}">
	    <a href="${ctp}/board/boardList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Board</a>
	    <c:if test="${sLevel < 3}">
		    <a href="${ctp}/pds/pdsList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">PDS</a>
		    <div class="w3-dropdown-hover w3-hide-small">
		      <button class="w3-padding-large w3-button" title="More">Study1 <i class="fa fa-caret-down"></i></button>     
		      <div class="w3-dropdown-content w3-bar-block w3-card-4">
		        <a href="${ctp}/study1/mapping/menu" class="w3-bar-item w3-button">Mapping</a>
		        <a href="${ctp}/study1/aop/aopMenu" class="w3-bar-item w3-button">AOP Test</a>
		        <a href="${ctp}/study1/xml/xmlMenu" class="w3-bar-item w3-button">XML 값주입 Test</a>
		        <a href="${ctp}/user/userList" class="w3-bar-item w3-button">User List</a>
		        <a href="${ctp}/user2/userList" class="w3-bar-item w3-button">User2 List</a>
		        <a href="${ctp}/study1/restApi/restApiForm" class="w3-bar-item w3-button">Rest API</a>
		        <a href="${ctp}/study1/ajax/ajaxForm" class="w3-bar-item w3-button">Ajax Test</a>
		        <a href="${ctp}/study1/password/passwordForm" class="w3-bar-item w3-button">암호화연습</a>
		        <a href="${ctp}/study1/mail/mailForm" class="w3-bar-item w3-button">메일 연습</a>
		        <a href="${ctp}/study1/fileUpload/fileUploadForm" class="w3-bar-item w3-button">파일업로드연습</a>
		        <a href="${ctp}/study1/sweetAlert/sweetAlertForm" class="w3-bar-item w3-button">SweetAlert연습</a>
		        <a href="${ctp}/study1/rangeSlider/rangeSlider" class="w3-bar-item w3-button">RangeSlider</a>
		      </div>
		    </div>
		    <div class="w3-dropdown-hover w3-hide-small">
		      <button class="w3-padding-large w3-button" title="More">Study2 <i class="fa fa-caret-down"></i></button>     
		      <div class="w3-dropdown-content w3-bar-block w3-card-4">
		        <a href="${ctp}/study2/random/randomForm" class="w3-bar-item w3-button">Random 연습</a>
		        <a href="${ctp}/study2/calendar/calendar" class="w3-bar-item w3-button">인터넷 달력</a>
		        <a href="${ctp}/study2/validator/validatorForm" class="w3-bar-item w3-button">validator(유효성검사)</a>
		        <a href="${ctp}/study2/transaction/transactionForm" class="w3-bar-item w3-button">transaction 연습</a>
		        <a href="${ctp}/study2/dataApi/dataApiForm1" class="w3-bar-item w3-button">공공데이터(RestAPI)</a>
		        <a href="${ctp}/study2/chart/chartForm" class="w3-bar-item w3-button">차트연습</a>
		        <a href="${ctp}/study2/chart/chart2Form" class="w3-bar-item w3-button">차트연습2</a>
		        <a href="${ctp}/study2/kakao/kakaomap" class="w3-bar-item w3-button">카카오 맵</a>
		        <a href="${ctp}/study2/weather/weatherForm" class="w3-bar-item w3-button">날씨정보</a>
		        <a href="${ctp}/study2/qrCode/qrCodeForm" class="w3-bar-item w3-button">QR코드</a>
		        <a href="${ctp}/study2/thumbnail/thumbnailForm" class="w3-bar-item w3-button">썸네일연습</a>
		        <a href="${ctp}/error/errorForm" class="w3-bar-item w3-button">errorPage연습</a>
		        <a href="${ctp}/study2/crawling/jsoup" class="w3-bar-item w3-button">crawling연습1</a>
		        <a href="${ctp}/study2/crawling/selenium" class="w3-bar-item w3-button">crawling연습2</a>
		      </div>
		    </div>
		    <div class="w3-dropdown-hover w3-hide-small">
		      <button class="w3-padding-large w3-button" title="More">Shopping mall <i class="fa fa-caret-down"></i></button>     
		      <div class="w3-dropdown-content w3-bar-block w3-card-4">
		        <a href="${ctp}/dbShop/dbProductList" class="w3-bar-item w3-button">상품리스트</a>
		        <a href="${ctp}/dbShop/dbCartList" class="w3-bar-item w3-button">장바구니</a>
		        <a href="${ctp}/dbShop/dbMyOrder" class="w3-bar-item w3-button">주문(배송)현황</a>
		        <a href="${ctp}/study2/payment/payment" class="w3-bar-item w3-button">결제연습</a>
		        <a href="${ctp}/webSocket/webSocket" class="w3-bar-item w3-button">웹소켓 채팅</a>
		        <a href="#" class="w3-bar-item w3-button">QnA</a>
		        <a href="${ctp}/inquiry/inquiryList" class="w3-bar-item w3-button">1:1문의</a>
		        <a href="#" class="w3-bar-item w3-button">FAQ</a>
		        <a href="${ctp}/photoGallery/photoGalleryList" class="w3-bar-item w3-button">photoGallery</a>
		      </div>
		    </div>
	    </c:if>
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button onclick="location.href='${ctp}/member/memberMain'" class="w3-padding-large w3-button" title="More">MyPage <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <c:if test="${sLevel < 3}">
		        <a href="${ctp}/schedule/schedule" class="w3-bar-item w3-button">일정관리</a>
		        <a href="${ctp}/study1/aop/aopMenu" class="w3-bar-item w3-button">웹메세지</a>
		        
		        <a href="${ctp}/study1/xml/xmlMenu" class="w3-bar-item w3-button">Photo Gallery</a>
		        <a href="${ctp}/member/memberList" class="w3-bar-item w3-button">회원리스트</a>
		        <a href="#" class="w3-bar-item w3-button">스케줄러연습(자동)</a>
	        </c:if>
	        <a href="${ctp}/member/memberPwdCheck/p" class="w3-bar-item w3-button">비밀번호변경</a>
	        <a href="${ctp}/member/memberPwdCheck/u" class="w3-bar-item w3-button">회원정보수정</a>
	        <a href="javascript:userDeleteCheck()" class="w3-bar-item w3-button">회원탈퇴</a>
	        <c:if test="${sLevel == 0}">
	        	<a href="${ctp}/admin/adminMain" class="w3-bar-item w3-button">관리자메뉴</a>
	        </c:if>
	      </div>
	    </div>
    </c:if>
    <c:if test="${empty sLevel}">
	    <a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Login</a>
	    <a href="${ctp}/member/memberJoin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Join</a>
    </c:if>
    <c:if test="${!empty sLevel}">
    	<div class="w3-dropdown-hover w3-hide-small">
	      <button onclick="location.href='${ctp}/member/memberLogout'" class="w3-padding-large w3-button" title="More">Logout <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
		    	<a href="${ctp}/member/memberLogout" class="w3-bar-item w3-button w3-padding-large w3-hide-small">일반Logout</a>
		    	<a href="${ctp}/member/kakaoLogout" class="w3-bar-item w3-button w3-padding-large w3-hide-small">KakaoLogout</a>
	      </div>
	    </div>
    </c:if>
  </div>
</div>




<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="#band" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">BAND</a>
  <a href="#tour" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">TOUR</a>
  <a href="#contact" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">CONTACT</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">MERCH</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Login</a>
</div>