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
	</div>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				list : [],
				stuNo : '${stuNo}'
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"school-view.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.list = data.list;
						
					}
				});
            },
			fnStuInfo(stuNo){
				$.pageChange("school-stuView.do",{stuNo : stuNo});
			},
			fnStuInfoUpdate(stuNo){
				$.pageChange("school-stuInfoUpdate.do",{stuNo : stuNo});				
			}			

        },
		       
        mounted() {
            var self = this;
			self.fnGetList();
		
        }
    });
    app.mount('#app');
</script>