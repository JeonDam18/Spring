package com.example.test1.dao;

import java.util.HashMap;

public interface SchoolService {
 
	HashMap<String, Object> selectSchoolList(HashMap<String, Object> map);
	
	HashMap<String, Object> stuInfoList(HashMap<String, Object> map);
	
	HashMap<String, Object> stuUpdate(HashMap<String, Object> map);
}
