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
		<!--<ul>
			<li><a href="#" @click="fnCateBoard('')">전체</li>
			<li><a href="#" @click="fnCateBoard('1')">공지사항</li>
		</ul>-->
		
		<select name="cate" v-model="category">
		  <option value="" selected>::전체::</option>
		  <option value="cate_id">아이디</option>
		  <option value="cate_email">이메일</option>
		</select>
		<div>검색 : <input type="text" v-model="searchData"> <button @click="fnGetList()">검색</button></div>
		<table>
				        <tr>
				            <th>아이디</th>
				            <th>이름</th>
				            <th>이메일</th>
				            <th>핸드폰</th>
				            <th>성별</th>
				            
				        </tr>
				        <tr v-for="item in list">
				            <td>{{item.userId}}</td>
				            <td>{{item.userName}}<a/></td>
				            <td>{{item.email}}</td>
				            <td>{{item.phone}}</td>
				            <td>{{item.gender}}</td>														
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
				userName : "", 
				userId : "",
				email : "",
				phone : "",
				category : "",
				number : "",
				searchData :""
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {searchData : this.searchData, category : this.category };
				$.ajax({
					url:"user-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.list = data.list;
						
					}
				});
            },			
	           
		
			 fnUserView(userId){
				$.pageChange("user-view.do",{userId : userId});
			 },
			 fnCateBoard(number){
				var self = this;
				this.number = number;
				self.fnGetList(); 
			}

        },
		       
        mounted() {
            var self = this;
			self.fnGetList();
		
        }
    });
    app.mount('#app');
</script>