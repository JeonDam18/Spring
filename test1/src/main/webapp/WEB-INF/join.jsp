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
		<div>비밀번호 : <input type="text" placeholder="비밀번호" v-model="pwd"></div>
		<div>이름 : <input type="text" placeholder="이름" v-model="name"></div>
		<div>이메일 : <input type="text" placeholder="이메일" v-model="email"></div>
		<div>핸드폰 : <input type="text" placeholder="핸드폰" v-model="phone"></div>
		<div>성별 : <input type="radio"  name="gender" value="M" v-model="gender">남
					<input type="radio" name="gender" value="F" v-model="gender">여
		</div>
		<button @click="fnRegist">가입하기</button>
	</div>
</body>
</html> 
<script>
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
				gender : ""
            };
        },
        methods: {
		
			//fnSave 생성후 board-add.dox 호출해서 저장
			fncheck(){
				var self = this;
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
 				var self = this;
				if(self.userId == ""){
					alert("아이디를 입력하세요");
					return;
				}else if(self.pwd == ""){
					alert("비밀번호를 입력하세요");
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
				}
				
				if(self.isCheck == false){
					alert("아이디 중복체크를 하세요");
					return;
				}
 				var nparam = {userId : self.userId , pwd : self.pwd , name : self.name , email : self.email , phone : self.phone , gender : self.gender}
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
			 fnChange(){
 				var self = this;
 				self.isCheck = false;
 			}	
        },
		        
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>