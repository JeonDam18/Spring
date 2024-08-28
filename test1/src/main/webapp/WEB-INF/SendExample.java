public class SendExample {
    public static void main(String[] args) {    
        /*
         * 서버에서 받은 API_KEY, API_SECRET를 입력해주세요.
         */
        String api_key = "NCSSWCWNR4NHXXOF"; // 발급받은 api_key
        String api_secret = "QHK7S8YTQ6KRD54A70BO4KMAUXDIJADM"; // 발급받은 api_secret
        Coolsms coolsms = new Coolsms(api_key, api_secret);
    
        HashMap<String, String> set = new HashMap<String, String>();
        set.put("to", "01000000000"); // 수신번호(문자를 받을 사람)
        set.put("from", "029302266"); // 발신번호(문자를 보낼 사람)
        set.put("text", "Test Message"); // 문자내용
        set.put("type", "sms"); // 문자 타입

        
        JSONObject result = coolsms.send(set); // 보내기&전송결과받기
        if (result.get("status") == true) {
            // 메시지 보내기 성공 및 전송결과 출력
            System.out.println("성공");            
            System.out.println(result.get("group_id")); // 그룹아이디
            System.out.println(result.get("result_code")); // 결과코드
            System.out.println(result.get("result_message"));  // 결과 메시지
            System.out.println(result.get("success_count")); // 메시지아이디
            System.out.println(result.get("error_count"));  // 여러개 보낼시 오류난 메시지 수
        } else {
            // 메시지 보내기 실패
            System.out.println("실패");
            System.out.println(result.get("code")); // REST API 에러코드
            System.out.println(result.get("message")); // 에러메시지
        }        
    }    
}