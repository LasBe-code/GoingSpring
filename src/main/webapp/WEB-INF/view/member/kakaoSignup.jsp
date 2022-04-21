<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script>

let phoneAuth = true;
let passCheck = true;

function auth(){
	const tel = document.f.tel.value;
	const param = "tel="+tel;
	
	ajax("<%=request.getContextPath()%>/member/phoneAuth", param, callback, 'GET')
}
function callback(){
	if(this.readyState == 4 && this.status == 200){
		
		/* let rand = this.responseText.trim();
		document.f.rand.value=rand;  핸드폰 인증번호 확인용 */
		
		alert('인증 번호를 전송했습니다.')
		
		const code_btn = document.getElementById("code_btn")
		code_btn.disabled = false
	}
}

function authCheck(){
	/* const rand = document.f.rand.value; */
	const code = document.f.code.value;
	const param = "code="+code;
	
	ajax("<%=request.getContextPath()%>/member/phoneAuthOk", param, callbackCheck, 'GET')
	
}
function callbackCheck(){
	if(this.readyState == 4 && this.status == 200){
		let result = this.responseText.trim();
		
		if(result == 'false'){
			alert('인증되었습니다')
			const input_tel = document.getElementById("input_tel")
			input_tel.readOnly = true
			
			const input_code = document.getElementById("input_code")
			input_code.readOnly = true
			
			const tel_btn = document.getElementById("tel_btn")
			tel_btn.disabled = true
			
			const code_btn = document.getElementById("code_btn")
			code_btn.disabled = true
			
			phoneAuth=false
			inputCheck()
		} else {
			alert('인증 번호가 다릅니다.')
			phoneAuth=true
			inputCheck()
		}
	}
}

function passChk() {
	const pass = document.f.password.value
	const passChk = document.f.passC.value
	let result = document.querySelector("#passResult")
	
	if(pass == passChk){
		result.style.color = 'blue'
		result.innerHTML = '일치하는 비밀번호'
		
		passCheck = false
		inputCheck()
		
	} else {
		result.style.color = 'red'
		result.innerHTML = '일치하지 않는 비밀번호'
		
		passCheck = true
		inputCheck()
	}
}

function inputCheck() {
	if(phoneAuth == false && passCheck == false){
		const submit = document.getElementById("submit")
		submit.disabled = false
	} else {
		submit.disabled = true
	}
}
</script>

<div class="signup_form_width">
		<div style="text-align : center;">
			<b class="large_text" style="color:#ffc107;">회원가입</b>
		</div>
	<form name="f" action="${pageContext.request.contextPath}/member/signupPro" method="post">
		<!-- <input type="text" name="rand" id="rand"> 인증번호 확인용 -->
		<div class="row mt-5">
			<div class="col-sm-8">
				<input type="tel" name="tel" id="input_tel" class="form-control form-control-lg" 
					id="tel" placeholder="전화번호(- 빼고 작성해주세요)" pattern="[0-9]{11}" required>
			</div>
			<div class="col-sm-4">
				<button type="button" id="tel_btn" class="default_btn rounded" style="height: 48px;" onclick="auth()">인증코드 전송</button>
			</div>
		</div>
		<div class="row mt-3">
			<div class="col-sm-8">
				<input type="text" name="code" id="input_code" class="form-control form-control-lg" placeholder="전송받은 코드" required>
			</div>
			<div class="col-sm-4">
				<button type="button" id="code_btn" class="default_btn rounded" style="height: 48px;" onclick="authCheck()" disabled>코드 확인</button>
			</div>
		</div>
		
		<input type="text" name="email" class="form-control form-control-lg mt-3" value="${id}" placeholder="이메일" readonly required>
		
		<div class="form-floating mt-3">
		  <input type="password" name="password" class="form-control form-control-lg mt-3" pattern="^(?=.*[a-zA-z])(?=.*[0-9]).{6,12}$" required required>
		  <label><span>비밀번호 - 대문자 혹은 소문자와 숫자를 합해 6자리 이상 12자리 이하</span></label>
		</div>
		<div class="form-floating mt-3">
		  <input type="password" name="passC" class="form-control form-control-lg mt-3" onkeyup="passChk()" pattern="^(?=.*[a-zA-z])(?=.*[0-9]).{6,12}$" required>
		  <label><span id="passResult">비밀번호 확인</span></label>
		</div>
		
		<div class="mt-3">
			<input type="text" name="name" class="form-control form-control-lg" value="${name}" placeholder="이름" readonly required>
		</div>
		
		<input type="submit" id="submit" class="default_btn rounded mt-3" value="회원가입" disabled>
		
	</form>
</div>

</body>
</html>