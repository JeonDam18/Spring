package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.example.test1.mapper.UserMapper;
import com.example.test1.model.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserMapper UserMapper;

	@Autowired
	HttpSession session;

	// 로그인
	@Override
	public HashMap<String, Object> userLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<>();
		System.out.println("login :::::" + map);
		try {
			User user = new User();
			user = UserMapper.userLogin(map);
			if (user == null) {
				User idCheck = UserMapper.UserInfo(map);
				if (idCheck == null) {
					resultMap.put("message", "아이디를 확인하세요");
				} else {
					resultMap.put("message", "비밀번호를 확인하세요");
				}
			} else {
				resultMap.put("list", user);
				resultMap.put("result", "success");
				resultMap.put("message", "로그인 성공!");
			}
		} catch (Exception e) {
			resultMap.put("message", "로그인실패!");
		}

		return resultMap;
	}

	// 회원가입
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

	// 유저정보
	@Override
	public HashMap<String, Object> Userinfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = UserMapper.UserInfo(map);

		if (user != null) {
			resultMap.put("list", user);
			resultMap.put("message", "아이디중복");
		} else {
			resultMap.put("message", "아이디사용가능");
		}

		return resultMap;
	}

	// 유저 리스트
	@Override
	public HashMap<String, Object> UserList(HashMap<String, Object> map) {
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<User> user = UserMapper.userList(map);

		resultMap.put("list", user);

		return resultMap;

	}
}
