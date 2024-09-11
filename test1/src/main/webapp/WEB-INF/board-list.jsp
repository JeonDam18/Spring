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
	.pagination {
		    justify-content: center;
		    align-items: center;
		    margin: 20px 0;
	}
	.pagination button {
	    background-color: #f8f9fa;
	    border: 1px solid #dee2e6;
	    color: #007bff;
	    padding: 8px 12px;
	    margin: 0 2px;
	    cursor: pointer;
	    transition: background-color 0.3s, color 0.3s;
	    border-radius: 4px;
	}

	.pagination button:hover {
	    background-color: #007bff;
	    color: white;
	}

	.pagination button.active {
	    background-color: #007bff;
	    color: white;
	    cursor: default;
	}

	.pagination button:disabled {
	    background-color: #e9ecef;
	    color: #6c757d;
	    cursor: not-allowed;
	    border: 1px solid #dee2e6;
	}

	.pagination button:not(.active):not(:disabled):hover {
	    background-color: #0056b3;
	    color: white;
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
		<div>검색 : <input type="text" v-model="searchData"> <button @click="fnGetList(1)">검색</button></div>
		<div>
			<select @change="fnCntValue(cntValue)" v-model="cntValue">
				<option value="5">5개씩</option>
				<option value="10">10개씩</option>
				<option value="15">15개씩</option>
			</select>
		</div>
		<table>
				        <tr>
							<th></th>
				            <th>번호</th>
				            <th>제목</th>
				            <th>작성자</th>
				            <th>조회수</th>
				            <th>작성일</th>
				            
				        </tr>
				        <tr v-for="item in list">
							<td><input type="checkbox" v-model="selectItem" :value="item.boardNo">
				            <td>{{item.boardNo}}</td>
				            <td><a href="#" @click="fnView(item.boardNo)">{{item.title}}<p v-if="item.count>0">({{item.count}})</p></a></td>
				            <td><a href="#" @click="fnUserView(item.userId)">{{item.userName}}</a></td>
				            <td>{{item.hit}}</td>
				            <td>{{item.cdateTime}}</td>
				            <td>{{item.userId}}</td>
				        </tr>
				    </table>
				
				<button @click="fnCheckRemove()">선택삭제</button>
				<button @click="fnInsert()">게시글작성</button>
				<button @click="fnLogout()">로그아웃</button>
				<div>세션값 {{sessionId}}</div>
		<div class="pagination">
		    <button v-if="currentPage > 1" @click="fnBeforPage()">이전</button>
		    <button v-for="page in totalPages" :class="{active: page == currentPage}" @click="fnGetList(page)">
		        {{ page }}
		    </button>
		    <button v-if="currentPage < totalPages" @click="fnNextPage()">다음</button>
		</div>
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
				sessionId : '${sessionId}',
				currentPage: 1,      
				pageSize: 5,        
				totalPages: 1,
				cntValue : 5,
				selectItem : []
            };
        },
        methods: {
            fnGetList(page){
				
				var self = this;
				var startIndex = (page-1) *self.pageSize;			
				self.currentPage = page;
				var outputNumber = this.pageSize;
				var nparmap = {searchData : this.searchData,
					 category : this.category,
					 number : this.number,
					 startIndex : startIndex,
				 	 outputNumber : outputNumber  
				    };
				$.ajax({
					url:"board-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.list = data.list;
						self.totalPages = Math.ceil(data.count/self.pageSize);

					}
				});
            },
				
			 fnView(BoardNo){
				$.pageChange("board-view.do",{boardNo : BoardNo});
				var self = this;
				self.fnUserView();
				
				self.fnCateBoard();
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
			},
			fnCntValue(cntValue){
				var self = this;
				self.pageSize=self.cntValue;
				self.fnGetList(1);
			},
			fnCheckRemove(){
				var self = this;
				var fList = JSON.stringify(self.selectItem);
				var nparmap = {selectItem : fList
				    };
				$.ajax({
					url:"check-remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						if(data.result=="success"){
							alert("다중선택삭제 성공");
							self.fnGetList(1);
						}else{
							alert("실패");
						}
					}
				});
			}
        },
		       
        mounted() {
            var self = this;
			self.fnGetList(1);
        }
    });
    app.mount('#app');
</script>