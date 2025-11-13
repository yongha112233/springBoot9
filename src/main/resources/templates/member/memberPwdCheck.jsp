<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>memberPwdCheck.jsp</title>
  <script>
  	'use strict';
  	
  	function pwdCheck() {
  		let pwd = $("#pwd").val().trim();
  		if(pwd == "") {
  			alert("현재비밀번호를 입력하세요");
  			$("#pwd").focus();
  			return false;
  		}
  		$.ajax({
  			url  : '${ctp}/member/memberPwdCheck',
  			type : 'post',
  			data : {
  				pwd : pwd,
  				mid : '${sMid}'	
  			},
  			success: (res) => {
  				if(res != '0') {
  					if('${flag}' == 'p') {
  						$("#myform").hide();
  						$("#newPassform").show();
  					}
  					else {
  						location.href = '${ctp}/member/memberUpdate?mid=${sMid}';
  					}
  				}
  				else {
  					alert("비밀번호가 틀립니다. 확인해 주세요.");
  					$("#pwd").focus();
  				}
  			},
  			error : () => alert("전송오류!")
  		});
  	}
  	
  	function pwdChange() {
  		let newPwd = $("#newPwd").val().trim();
  		let rePwd = $("#rePwd").val().trim();
  		
  		if(newPwd == "" || rePwd == "" || newPwd != rePwd) {
  			alert("비밀번호가 다름니다. 비밀번호를 확인하세요.");
  		}
  		else {
  			newPassform.action = "${ctp}/member/memberPwdChange";
  			newPassform.submit();
  		}
  		
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform" id="myform" method="post">
  	<table class="table table-bordered text-center">
  		<tr>
  			<th colspan="2">
  				<h3>비밀번호 확인</h3>
  				<div>(현재 비밀번호를 확인합니다.)</div>
  			</th>
  		</tr>
  		<tr>
  			<th>비밀번호</th>
  			<td><input type="password" name="pwd" id="pwd" class="form-control" autofocus required /></td>
  		</tr>
  		<tr>
  			<th colspan="2">
  				<input type="button" value="비밀번호확인" onclick="pwdCheck()" class="btn btn-success me-2" />
  				<input type="reset" value="다시입력" class="btn btn-warning me-2" />
  				<input type="button" value="돌아가기" onclick="location.href='memberMain'" class="btn btn-info" />
  			</th>
  		</tr>
  	</table>
  </form>
  <form name="newPassform" id="newPassform" method="post" style="display:none">
  	<table class="table table-bordered text-center">
  		<tr>
  			<th colspan="2">
  				<h3>비밀번호 변경</h3>
  				<div>(변경할 비밀번호를 입력하세요.)</div>
  			</th>
  		</tr>
  		<tr>
  			<th>새비밀번호</th>
  			<td><input type="password" name="newPwd" id="newPwd" class="form-control" autofocus required /></td>
  		</tr>
  		<tr>
  			<th>비밀번호확인</th>
  			<td><input type="password" name="rePwd" id="rePwd" class="form-control" required /></td>
  		</tr>
  		<tr>
  			<th colspan="2">
  				<input type="button" value="비밀번호변경" onclick="pwdChange()" class="btn btn-success me-2" />
  				<input type="reset" value="다시입력" class="btn btn-warning me-2" />
  				<input type="button" value="돌아가기" onclick="location.href='memberMain'" class="btn btn-info" />
  			</th>
  		</tr>
  	</table>
  	<input type="hidden" name="mid" value="${sMid}" />
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>