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
		<ul>
			<li><a href="#" @click="fnCateBoard('')">전체</a></li>
			<li><a href="#" @click="fnCateBoard('1')">공지사항</a></li>
			<li><a href="#" @click="fnCateBoard('2')">자유게시판</a></li>
			<li><a href="#" @click="fnCateBoard('3')">질문게시판</a></li>
		</ul>
		
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
				            <td><a href="#" @click="fnView(item.boardNo)">{{item.title}}</a></td>
				            <td><a href="#" @click="fnUserView(item.userId)">{{item.userName}}</a></td>
				            <td>{{item.hit}}</td>
				            <td>{{item.cdateTime}}</td>
							
				        </tr>
				    </table>
				
				<button @click="fnInsert()">게시글작성</button>
				<button @click="fnLogout()">로그아웃</button>
				<div>세션값 {{sessionId}}</div>
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
				searchData : "",
				category : "",
				number : "",
				sessionId : '${sessionId}'
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {searchData : this.searchData, category : this.category, number : this.number };
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
	          
			 fnView(BoardNo){
				$.pageChange("board-view.do",{boardNo : BoardNo});
			 },
			 fnUserView(userId){
				$.pageChange("user-view.do",{userId : userId});
			 },
			 fnCateBoard(number){
				var self = this;
				this.number = number;
				self.fnGetList(); 
			},
			fnInsert(){
				location.href="board-insert.do"
			},
			fnLogout(){
				location.href="login.do"
			}

        },
		       
        mounted() {
            var self = this;
			self.fnGetList();
		
        }
    });
    app.mount('#app');
</script>