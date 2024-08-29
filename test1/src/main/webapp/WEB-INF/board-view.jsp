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
			<div>
				제목 : {{list.title}}					
			</div>
			<div>
				내용 : <div v-html="list.contents"></div>					
			</div>
		</div>

</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				list : {},
				boardNo : '${boardNo}'
            };
        },
        methods: {
			fnView(){
				var self = this;
				var nparam = {boardNo : self.boardNo}
				$.ajax({
					url:"board-view.dox",
					dataType:"json",	
					type : "POST", 
					data : nparam,
					success : function(data) {
						self.list = data.list;		
					}
				});
			 },	
			
        },
		       
        mounted() {
			var self = this;
			self.fnView();
        }
    });
    app.mount('#app');
</script>