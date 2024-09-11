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
	<button @click="fnApi">클릭</button>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				
            };
        },
        methods: {
			fnApi(){
				var xhr = new XMLHttpRequest();
				var url = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst'; /*URL*/
				var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'wVk%2Bvw1aTYsUoX8H450X4cx7B%2B2JsuyJQQ8%2FPkLjJUI8zjupM1cJ%2FL5ojWYKlYhM5DESZBaLixPakMlXQKuwbg%3D%3D'; /*Service Key*/
				queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
				queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('1000'); /**/
				queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('XML'); /**/
				queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent('20240911'); /**/
				queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent('0600'); /**/
				queryParams += '&' + encodeURIComponent('nx') + '=' + encodeURIComponent('55'); /**/
				queryParams += '&' + encodeURIComponent('ny') + '=' + encodeURIComponent('127'); /**/
				xhr.open('GET', url + queryParams);
				xhr.onreadystatechange = function () {
				    if (this.readyState == 4) {
						console.log('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText)
				        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
				    }
				};

				xhr.send('');
			}
        },
		       
        mounted() {
            var self = this;
			
        }
    });
    app.mount('#app');
</script>