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
	도/시<select  v-model="si" @change="fnGetList()">
		  <option value="" selected>::선택::</option> 
		  <option :value="item.si" v-for="item in list" >{{item.si}}</option>
		</select>
	구/군<select  v-model="gu" @change="fnGetList()">
		  <option value="" selected>::선택::</option> 
		  <option :value="item.gu" v-for="item in guList" >{{item.gu}}</option>
		</select>
	동<select  v-model="dong" >
		  <option value="" selected>::선택::</option> 
		  <option :value="item.dong" v-for="item in dongList" >{{item.dong}}</option>
		</select>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				list : [],
				guList :[],
				dongList : [],
				si : "",
				gu : "",
				dong : ""
            };
        },
        methods: {
            fnGetList(){
				var self = this;
				if(self.si == ""){
					self.guList = [];
				}
				if(self.gu == ""){
					self.dongList =[];
				}
				var nparmap = {si : this.si , gu : this.gu};
				$.ajax({
					url:"area.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						if(self.gu != ""){
							self.dongList = data.list;
						}else if(self.si != ""){
							self.guList =  data.list;
						}else{
							self.list = data.list;							
						}
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