package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.UserMapper;
import com.example.test1.model.User;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	UserMapper UserMapper;
	
	
	//로그인
	@Override
	public HashMap<String, Object> userLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
				HashMap<String, Object> resultMap = new HashMap<>();
				System.out.println(map);
				try {
					User user = UserMapper.userLogin(map);
					System.out.println(user);
					if(user != null) {
						resultMap.put("list",user);
						resultMap.put("message","success");						
					}
					
				} catch (Exception e) {
					resultMap.put("message", "fail");
				}
				
				return resultMap;	
	}
	
	
	//회원가입
	@Override
	public HashMap<String, Object> userJoin(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			System.out.println(map);
			UserMapper.userJoin(map);
			
			resultMap.put("result", "success");
			resultMap.put("message", "저장되었습니다.");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", "오류입니다.!!!!");
		}
		 
		return resultMap;
	}
	
	//유저정보
	@Override
	public HashMap<String, Object> Userinfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = UserMapper.UserInfo(map);
		if(user != null) {
			resultMap.put("list",user);
			resultMap.put("message", "아이디중복");
		}else {
			resultMap.put("message", "아이디사용가능");
		}
		
		return resultMap;
	} 
}
