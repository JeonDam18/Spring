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
		<button @click="fnSearch">검색</button>
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
				dong : "",
				nx : "",
				ny : ""
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
            },
			fnSearch(){
				var self = this;
				var nparmap = {si : this.si , gu : this.gu , dong : this.dong};
				$.ajax({
					url:"weather.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.nx = data.list.nx;
						self.ny = data.list.ny;
						self.fnApi();
					}
				});
			},
			fnApi(){
				var self = this;
				var xhr = new XMLHttpRequest();
				var url = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst'; /*URL*/
				var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'wVk%2Bvw1aTYsUoX8H450X4cx7B%2B2JsuyJQQ8%2FPkLjJUI8zjupM1cJ%2FL5ojWYKlYhM5DESZBaLixPakMlXQKuwbg%3D%3D'; /*Service Key*/
				queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
				queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('1000'); /**/
				queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('XML'); /**/
				queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent('20240911'); /**/
				queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent('1700'); /**/
				queryParams += '&' + encodeURIComponent('nx') + '=' + encodeURIComponent(self.nx); /**/
				queryParams += '&' + encodeURIComponent('ny') + '=' + encodeURIComponent(self.ny); /**/
				xhr.open('GET', url + queryParams);
				xhr.onreadystatechange = function () {
				    if (this.readyState == 4) {
						console.log('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText)
				        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
						var responseJson = JSON.parse(this.responseText);
						var items = responseJson.response.body.items.item;
						for (var i = 0; i < items.length; i++) {
							var item = items[i];
							console.log(item); 
						}
				    }
				};

				xhr.send('');
			}
        },
		       
        mounted() {
            var self = this;
			self.fnGetList();
        }
    });
    app.mount('#app');
</script>