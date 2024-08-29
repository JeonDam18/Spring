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
		<div>아이디 : <input type="text" placeholder="아이디" v-model="userId"></div>
		<div>비밀번호 : <input type="text" placeholder="비밀번호" v-model="pwd"></div>
		<button @click="fnLogin">로그인</button>
		<button @click="fnRegist">회원가입</button>
	</div>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				userId : "",
				pwd : ""	
            };
        },
        methods: {
			//fnSave 생성후 board-add.dox 호출해서 저장
			fnLogin(){
				var self = this;
				var nparam = {userId : self.userId, pwd : self.pwd}
				if(this.userId==""){
					alert("아이디를 입력하세요");
					return;
				}else if(this.pwd==""){
					alert("비밀번호를 입력하세요");
					return;
				}
				$.ajax({
					url:"user-login.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) { 
						if(data.result == "success"){
							alert("로그인성공!!");
							//location.href="board-list.do"
							$.pageChange("board-list.do",{});
						}else{
							alert("로그인실패!!");
						}
					
							
					}
				});
			 },	
			 fnRegist(){
			 	location.href="join.do";
			 }
        },
		       
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>