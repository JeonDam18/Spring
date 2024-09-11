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
		<div>
			<input type="checkbox" value="10" v-model="selectItem" @change="fnSelect">Accounting
			<input type="checkbox" value="20" v-model="selectItem" @change="fnSelect">Research
			<input type="checkbox" value="30" v-model="selectItem" @change="fnSelect">Sales
			<input type="checkbox" value="40" v-model="selectItem" @change="fnSelect">Operations
		</div>
		<table>
	        <tr>
	            <th>사번</th>
	            <th>이름</th>
	            <th>직급</th>
	            <th>부서명</th>	            
	        </tr>
	        <tr v-for="item in list">
	            <td>{{item.empNo}}</td>
	            <td>{{item.eName}}</a></td>
	            <td>{{item.job}}</a></td>
	            <td>{{item.deptNo}}</td>				
	        </tr>
	    </table>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                name : "홍길동",
				list : [],
				selectItem : []
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"empList.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.list = data.list;
					}
				});
            },
			fnSelect(){
			var self = this;
			var fList = JSON.stringify(self.selectItem);
			console.log(fList);
			var nparmap = {selectItem : fList
				    };
				$.ajax({
					url:"emp-check.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.fnGetList();
					}
				});
			}
        },
        mounted() {
            var self = this;
			self.fnGetList();
        }
    });
    app.mount('#app');
</script>