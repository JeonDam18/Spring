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
	table,
	        tr,
	        th,
	        td {
	            border: 1px solid black; 
	            padding: 10px;
	            border-collapse: collapse;
	            text-align: center;
	        }
</style>
<body>
	<div id="app">
        <div>이름 <input type="text" v-model="name"></div>
        <div>전화번호<input type="text" v-model="tel"> </div>
        <div>키 <input type="text" v-model="height"></div>
        <div>몸무게 <input type="text" v-model="weight"></div>
	<button @click="fnUpdate()">수정</button>
	</div>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				stuNo : '${stuNo}',
				name : "",
				tel : "",
				height : "",
				weight : ""
            };
        },
        methods: {
            fnUpdate(){
				var self = this;
				var nparmap = {stuNo : this.stuNo, name : this.name , tel : this.tel , height : this.height, weight : this.weight};
				$.ajax({
					url:"stu-update.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
							if(data.result=="success"){
								alert("수정 완료");
							}else{
								alert("수정 실패");
							}
					  }		
				});
            }
        },
		       
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>