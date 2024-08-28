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
		<div>제목 : <input type="text" placeholder="제목" v-model="title"></div>
		<div>내용 : <textarea cols="30" rows="5" v-model="contents"></textarea></div>
		<button @click="fnSave">저장</button>
	</div>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				title : "",
				contents : ""	
            };
        },
        methods: {
			//fnSave 생성후 board-add.dox 호출해서 저장
			fnSave(){
				var self = this;
				var nparam = {title : self.title,contents : self.contents}
				$.ajax({
					url:"board-add.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) { 
						alert(data.message);
						if(data.result == "success") {
							location.href = "board-list.do"
						}	
					}
				});
			 },	
        },
		       
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>