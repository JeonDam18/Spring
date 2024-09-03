<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	<title>view 기본 세팅 파일</title>
</head>
<style>
</style>
<body>
	<div id="app">
		<input type="text" v-model="price">
		<button @click="fnPayment()">결제</button>
	</div>
</body>
</html>
<script>
	const userCode = "imp33068835"; 
	IMP.init(userCode);
    const app = Vue.createApp({
        data() {
            return {
				price : ""
            };
        },
        methods: {
	
			fnPayment(){
				var self = this;
				var uid = "test"+Math.floor(1000 + Math.random() * 9000);
				var product = "테스트 결제상품";
				IMP.request_pay({
				    pg: "html5_inicis",
				    pay_method: "card",
				    merchant_uid: this.uid,
				    name: this.product,
				    amount: this.price,
				    buyer_tel: "010-0000-0000",
				  }	, function (rsp) { // callback
			   	      if (rsp.success) {
			   	        // 결제 성공 시
						alert("성공");
						this.fnInsert();
						console.log(rsp);
			   	      } else {
			   	        // 결제 실패 시
					
						alert("실패"+this.merchant_uid);
						
			   	      }
		   	  	});
			},
			fnInsert(){
				var self = this;
				var nparmap = {product : this.product,
					 price : this.price,
					 uid : this.uid
				    };
				$.ajax({
					url:"payInfo.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 

					}
				});
			}
        },
        mounted() {
			
        }
    });
    app.mount('#app');
</script>