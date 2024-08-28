<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" /> 
<meta http-equiv="X-UA-Compatible" content="ie=edge" /> 
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>문자인증</title>
</head>
<body>
	<div id="contents"> 
		받는사람 : <input type="text" id="to" name="to"/>   <!-- 인증번호 받을사람 휴대폰 번호 -->
		<button type="button" id="send">전송</button><br> <!-- 문자보내는 전송버튼 -->
		
		인증번호 : <input type="text" id="userNum">   <!-- 인증번호 입력창 -->
		<button type="button" id="enterBtn">확인</button>  <!-- 인증번호와 내가 입력창에 입력한 인증번호 비교하는 창 -->		
    </div>
</body>

<script type="text/javascript">
$('#send').click(function() {
	
	const to = $('#to').val();
	
	$.ajax ({
		url: '/check/sendSMS',
		type: 'GET',
		data: {
			"to" : to
		},
		success: function(data) {
			const checkNum = data;
			alert('checkNum:'+ checkNum);
			
			$('#enterBtn').click(function() {	
				const userNum = $('#userNum').val();
				
				if(checkNum === userNum) {
					alert('인증 성공하였습니다.');
				}
				else {
					alert('인증 실패하였습니다. 다시 입력해주세요.');
				}
			});
			
		}
	});
	
});
</script>

</html>