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
		<button @click="fnSearchAddr()">주소찾기</button>
		<div>주소 <input type="text" v-model="roadFullAddr" ></div>
	</div>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				roadFullAddr : ""
            };
        },
        methods: {
			fnSearchAddr(){
				var self = this;
				var option = "width = 500, height = 500, top = 100, left = 200, location = no"
				window.open("jusoPopup.do","address", option);
			},
			fnResult(roadFullAddr){
				var self = this;
				self.roadFullAddr = roadFullAddr;
			}				
        },
		        
        mounted() {
            window.vueAppInstance = this;
        }
    });
    app.mount('#app');
	function jusoCallBack(roadFullAddr) {
		if (window.vueAppInstance) {
			window.vueAppInstance.fnResult(roadFullAddr);
		} else {
			console.error("Vue app instance is not available.");
		}
	}
</script>