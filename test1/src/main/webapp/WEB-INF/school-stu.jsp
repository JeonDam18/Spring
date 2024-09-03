<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
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
	<span class="material-symbols-outlined">
	check_circle
	</span>
		<div>
			<i class="fa-solid fa-filter"></i>
			<select @change="fnCntValue(cntValue)" v-model="cntValue">
				<option value="5">5개씩</option>
				<option value="10">10개씩</option>
				<option value="15">15개씩</option>
			</select>
		</div>
<!--		<div>검색 : <input type="text" v-model="searchData"> <button @click="fnGetList()">검색</button></div>-->
		<table>
	        <tr>
	            <th>학번</th>
	            <th>아이디</th>
	            <th>이름</th>
	            <th>학년</th>
	            <th>주민번호</th>
	            
	        </tr>
	        <tr v-for="item in list">
	            <td>{{item.stuNo}}</td>
	            <td><a href="#" @click="fnStuInfoUpdate(item.stuNo)">{{item.id}}</a></td>
	            <td><a href="#" @click="fnStuInfo(item.stuNo)">{{item.name}}</a></td>
	            <td>{{item.grade}}</td>
	            <td>{{item.jumin}}</td>
				
	        </tr>
	    </table>
	
<!--	<button @click="fnInsert()">게시글작성</button>
	<button @click="fnLogout()">로그아웃</button>
	<div>세션값 {{sessionId}}</div>-->
		<div class="pagination">
		    <button v-if="currentPage > 1" @click="fnBeforePage(page)">이전</button>
		    <button v-for="page in totalPages" :class="{active: page == currentPage}" @click="fnGetList(page)">
		        {{ page }}
		    </button>
		    <button v-if="currentPage < totalPages" @click="fnNextPage(page)">다음</button>
		</div>
	</div>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				list : [],
				stuNo : '${stuNo}',
				currentPage: 1,      
				pageSize: 5,        
				totalPages: 2,
				cntValue : 5
            };
        },
        methods: {
            fnGetList(page){
				var self = this;
				var startIndex = (page-1) *self.pageSize;
				var outputNumber = this.pageSize;			
				self.currentPage = page;
				var nparmap = {startIndex : startIndex , outputNumber : outputNumber}; 
				$.ajax({
					url:"school-view.dox",
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
			fnStuInfo(stuNo){
				$.pageChange("school-stuView.do",{stuNo : stuNo});
			},
			fnStuInfoUpdate(stuNo){
				$.pageChange("school-stuInfoUpdate.do",{stuNo : stuNo});				
			},
			fnCntValue(cntValue){
				var self = this;
				self.pageSize = self.cntValue;
				self.fnGetList(1); 
			},
			fnNextPage(page){
				var self =this;
				page = page +1;
				self.fnGetList(page);
			},
			fnBeforePage(page){
				
			}	

        },
		       
        mounted() {
            var self = this;
			self.fnGetList(1);
        }
    });
    app.mount('#app');
</script>