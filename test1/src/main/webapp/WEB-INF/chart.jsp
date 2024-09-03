<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/layout/menu.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="https://cdn.jsdelivr.net/npm/vue-apexcharts"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
<div id="app">
	<div id="chart">
   	  <apexchart type="area" height="350" :options="chartOptions" :series="series"></apexchart>
 	</div>
</div>
</body>
</html>

<script>
var app = new Vue({
	el : '#app',
	components: {
      apexchart: VueApexCharts,
    },
	data : {
		series: [{
            name: "test",
            data: [41, 21, 15, 51, 33, 82, 100,40, 148]
        }],
        chartOptions: {
          chart: {
            height: 350,
            type: 'area',
            zoom: {
              enabled: false
            }
          },
          dataLabels: {
            enabled: false
          },
          stroke: {
            curve: 'straight'
          },
          title: {
            text: 'test',
            align: 'center'
          },
          grid: {
            row: {
              colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
              opacity: 0.5
            },
          },
          xaxis: {
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
          }
        }
	},// data
	methods : {
       fnGetList(){
		var self = this;
		var nparmap = { 
		    };
		$.ajax({
			url:"chart-data.dox",
			dataType:"json",	
			type : "POST", 
			data : nparmap,
			success : function(data) { 
				console.log(data);
				var priceList = [];
				var cateList = [];
				for(var i=0 ; i<data.list.length ; i++){
					priceList.push(data.list[i].price)
					cateList.push(data.list[i].pDate)
				}
				self.series = [{
		            data: priceList
		        }];
				self.xaxis = {
		            categories: cateList
		        }
			}
		});
	  }
	}, // methods
	created : function() {
		var self = this;
	},// created
	mounted() {
        var self = this;
		self.fnGetList(1);
     }
});
</script>