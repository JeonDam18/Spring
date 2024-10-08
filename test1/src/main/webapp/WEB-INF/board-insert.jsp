<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>	
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
	    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
	<title>첫번째 페이지</title>
</head>
<style>
	#editor{
		height : 300px
	}
</style>
<body>
	<div id="app">
		<table>
			<tr>
				<th>제목</th>
				<th><input v-model="title"></th>			
			</tr>
			<tr>
				<th>내용</th>
				<th><div id="editor"></div></th>
			</tr>
			<tr>
				<input type="file" @change="fnFileChange"/>
			</tr>
		</table>
		<button @click="fnSave">저장</button>
	</div>
</body>
</html> 
<script>
    const app = Vue.createApp({
        data() {
            return {
				title : "",
				contents : "",
				sessionId : '${sessionId}',
				file : null
            };
        },
        methods: {
			//fnSave 생성후 board-add.dox 호출해서 저장
			 fnFileChange(event) {
	 			this.file = event.target.files[0];
 			},
 			fnSave (){
 				var self = this;
 				var nparam = {
 					title : self.title, 
 					contents : self.contents,
 					userId : self.sessionId
 				};
 				$.ajax({
 					url:"board-add.dox",
 					dataType:"json",	
 					type : "POST", 
 					data : nparam,
 					success : function(data) { 
 						var boardNo = data.boardNo;
 						console.log(boardNo);
						//게시글이 등록된 이후에 파일등록
						if(self.file){
							//append는 이어붙이는 개념
							  const formData = new FormData();
							  formData.append('file1', self.file);
							  formData.append('boardNo', boardNo);
							  $.ajax({
								url: '/fileUpload.dox',
								type: 'POST',
								data: formData,
								processData: false,  
								contentType: false,  
								success: function() {
								  console.log('업로드 성공!');
								},
								error: function(jqXHR, textStatus, errorThrown) {
								  console.error('업로드 실패!', textStatus, errorThrown);
								}
						  });
						}
 					}
 				});
 			}	
        },
		       
        mounted() {
            var self = this;
			var quill = new Quill('#editor', {
			           theme: 'snow',
			           modules: {
			               toolbar: [
			                   [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
			                   ['bold', 'italic', 'underline'],
			                   [{ 'list': 'ordered'}, { 'list': 'bullet' }],
			                   ['link', 'image'],
			                   ['clean']
			               ]
			           }
			       });

	       // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
	       quill.on('text-change', function() {
	           self.contents = quill.root.innerHTML;
	       });
        }
    });
    app.mount('#app');
</script>