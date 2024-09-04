<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<title>첫번째 페이지</title>
</head>
<style>
</style>
<body>
	<div id="app">
		<div>아이디 : <input type="text" placeholder="아이디" v-model="userId" @change="fnChange()">
		<button @click=fncheck()>중복체크</button></div>
		<div>비밀번호 : <input type="password" placeholder="비밀번호" v-model="pwd"></div>
		<div>비밀번호확인 : <input type="password" placeholder="비밀번호확인" v-model="pwdCon"></div>
		<div>이름 : <input type="text" placeholder="이름" v-model="name"></div>
		<div>이메일 : <input type="text" placeholder="이메일" v-model="email"></div>
		<div>주소 <input type="text" v-model="addr"></div>
		<button @click="fnSearchAddr()">주소찾기</button>
		<div>핸드폰 : <input type="text" placeholder="핸드폰" v-model="phone"></div>
		<div> 회원상태
			<select name="status" v-model="status">
			  <option value="" selected>::전체::</option>
			  <option value="C">일반회원</option>
			  <option value="A">관리자</option>
			</select>
		</div>
		<div>성별 : <input type="radio"  name="gender" value="M" v-model="gender">남
					<input type="radio" name="gender" value="F" v-model="gender">여
		</div>
		<button @click="fnRegist">가입하기</button>
	</div>
</body>
</html> 
<script>
	function jusoCallBack(roadFullAddr) {
			if (window.vueAppInstance) {
				window.vueAppInstance.fnResult(roadFullAddr);
			} else {
				console.error("Vue app instance is not available.");
			}
		}
    const app = Vue.createApp({
        data() {
            return {
				list : {},
				userId : '${userId}',
				isCheck : false,
				pwd : "",
				name : "",
				email : "",
				phone : "",
				gender : "",
				addr : "",
				status : "",
				pwdCheck : false,
				pwdCon : ""
            };
        },
        methods: {
			// /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}\[\]:;"'<>,.?/]).{6,}$/        ::영어+숫자+특수문자포함
			//fnSave 생성후 board-add.dox 호출해서 저장
			fncheck(){
				var self = this;
				const validateId= /^[a-zA-Z0-9]+$/
				if(!validateId.test(this.userId) || this.userId.length < 6){
					alert("아이디는 5글자 이상 영어와 숫자로만 입력할수있습니다. ");
					return;
				}
				var nparam = {userId : self.userId}
				$.ajax({
					url:"user-check.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) { 
					if(data.message == "아이디중복"){
						alert("아이디가 중복되었습니다")	
						return;					
					}else{
						alert("사용가능한 아이디 입니다.")
						self.isCheck =true;					
						}
					}
				}); 
			 },
			 fnRegist(){
				if(self.userId == ""){
					alert("아이디를 입력하세요");
					return;
				}else if(self.pwd == ""){
					alert("비밀번호를 입력하세요");
					return;
				}else if(self.pwd != self.pwdCon){
					alert("비밀번호가 일치하지 않습니다");
					return;
				}else if(self.name == ""){
					alert("이름을 입력하세요");
					return;
                }else if(self.email == ""){
					alert("이메일을 입력하세요");
					return;
				}else if(self.phone == ""){
					alert("핸드폰번호를 입력하세요");
					return;
				}else if(self.gender == ""){
					alert("성별을 선택해주세요");
					return;
				}else if(self.addr == ""){
					alert("주소를 입력해주세요");
					return;
				}
				
				if(self.isCheck == false){
					alert("아이디 중복체크를 하세요");
					return;
				}
 				var nparam = {
					userId : self.userId ,
					pwd : self.pwd ,
					name : self.name ,
				    email : self.email ,
				    phone : self.phone ,
					gender : self.gender ,
					addr : self.addr ,
					status : self.status
					  }
 				$.ajax({ 
 					url:"user-join.dox",
 					dataType:"json",	
 					type : "POST", 
 					data : nparam,
 					success : function(data) { 
 						if(data.result == "success"){
							alert(data.message);
						}else{
							alert(data.message);
						}
 					}
 				});
			},
			fnPwdCheck(){
				var self = this;
				const validatePwd= /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}\[\]:;"'<>,.?/]).{6,}$/
				if(!validatePwd.test(this.pwd)){
					alert("비밀번호는 숫자,영어,특수문자를 포함시켜야합니다.");
				}else{
					pwdCheck = true;
				}
				
			},
			fnChange(){
 				var self = this;
 				self.isCheck = false;
 			},
			fnSearchAddr(){
				var self = this;
				var option = "width = 500, height = 500, top = 100, left = 200, location = no"
				window.open("jusoPopup.do","address", option);
			},
			fnResult(roadFullAddr){
				var self = this;
				self.addr = roadFullAddr;
			}
       },
		        
        mounted() {
            var self = this;
			window.vueAppInstance = this;
        }
    });
    app.mount('#app');
</script>