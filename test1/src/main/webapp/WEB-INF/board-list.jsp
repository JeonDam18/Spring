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
		<select name="cate" v-model="category">
		  <option value="" selected>::전체::</option>
		  <option value="cate_title">제목</option>
		  <option value="cate_user">작성자</option>
		</select>
		<div>검색 : <input type="text" v-model="searchData"> <button @click="fnGetList()">검색</button></div>
		<table>
				        <tr>
				            <th>번호</th>
				            <th>제목</th>
				            <th>작성자</th>
				            <th>조회수</th>
				            <th>작성일</th>
				            
				        </tr>
				        <tr v-for="item in list">
				            <td>{{item.boardNo}}</td>
				            <td><a href="#" @click="fnView(item.boardNo)">{{item.title}}<a/></td>
				            <td><a href="#" @click="fnUserView(item.userId)">{{item.userName}}</td>
				            <td>{{item.hit}}</td>
				            <td>{{item.cdateTime}}</td>
							<td><button @click="fnDelete(item.boardNo)">삭제 <button></td>
				        </tr>
				    </table>
	</div>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				list : [],
				boardNo : "",
				title : "",
				userId : "",
				hit : "",
				cdateTime : "",
				searchData : "",
				category : ""
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {searchData : this.searchData, category : this.category };
				$.ajax({
					url:"board-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
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
						self.fnGetList();
					}
				});
		     },
			 fnView(BoardNo){
				$.pageChange("board-view.do",{boardNo : BoardNo});
			 },
			 fnUserView(userId){
				$.pageChange("user-view.do",{userId : userId});
			 }
			 
        },
		       
        mounted() {
            var self = this;
			self.fnGetList();
        }
    });
    app.mount('#app');
</script>