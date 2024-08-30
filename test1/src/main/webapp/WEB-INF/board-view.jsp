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
			<div>작성자 : {{list.userId}}</div>
		<div v-if="list.userId == sessionId || sessionStatus == 'A'">
			<button @click="fnDelete(list.boardNo)">삭제</button>
		</div>
		<div>세션값 : {{sessionId}}</div>
	</div>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				list : {},
				boardNo : '${boardNo}',
				sessionId : '${sessionId}',
				sessionStatus : '${sessionStatus}'
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
			 fnDelete(BoardNo){
 					var self = this;
 					var nparmap = {boardNo : BoardNo};
 					if(!confirm("삭제하시겠습니까?")){
 						return;
 					};
 					$.ajax({
 						url:"board-delete.dox",
 						dataType:"json",	
 						type : "POST", 
 						data : nparmap,
 						success : function(data) { 
 						console.log(data);
 						alert(data.message);
						location.href="board-list.do"

 					}
 				});
			}	
			
        },
		       
        mounted() {
			var self = this;
			self.fnView();
        }
    });
    app.mount('#app');
</script>