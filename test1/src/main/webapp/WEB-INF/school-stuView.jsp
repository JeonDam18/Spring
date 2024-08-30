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
				            <th>이름</th>
				            <th>학부</th>
				            <th>교수</th>    
				        </tr>
				        <tr v-for="item in list">
				            <td>{{item.stuNo}}</td>
				            <td>{{item.name}}</td>
				            <td>{{item.dName}}</td>
				            <td>{{item.pName}}</td>
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
				stuNo : '${stuNo}'
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {stuNo : this.stuNo};
				$.ajax({
					url:"stu-view.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.list = data.list;
						if(data.result == 'success'){
							
						}
						
					}
				});
            },
	
        },
		       
        mounted() {
            var self = this;
			self.fnGetList();
		
        }
    });
    app.mount('#app');
</script>