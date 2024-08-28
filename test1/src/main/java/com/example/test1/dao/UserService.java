package com.example.test1.dao;

import java.util.HashMap;


public interface UserService {
		
	
	HashMap<String, Object> userLogin(HashMap<String, Object> map);
		
	HashMap<String, Object> userJoin(HashMap<String, Object> map);
	
	//유저 정보
	HashMap<String,Object> Userinfo(HashMap<String, Object> map);
		
}
