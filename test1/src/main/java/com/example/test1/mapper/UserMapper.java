package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.User;


@Mapper
public interface UserMapper {
	
	User userLogin(HashMap<String,Object> map);
	
	void userJoin(HashMap<String,Object> map);
	
	 User UserInfo(HashMap<String,Object> map);
	 
	 List<User> userList(HashMap<String,Object> map);
}
