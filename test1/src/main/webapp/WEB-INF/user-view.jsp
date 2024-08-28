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
				유저아이디 : {{list.userId}}					
			</div>
			<div>
				이메일 : {{list.email}}					
			</div>
			<button>삭제</button>
		</div>

</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				list : {},
				userId : '${userId}'
            };
        },
        methods: {
			fnView(){
				var self = this;
				var nparam = {userId : self.userId}
				$.ajax({
					url:"user-view.dox",
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