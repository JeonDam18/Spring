package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.SchoolMapper;
import com.example.test1.model.School;



@Service
public class SchoolServiceImpl implements SchoolService{
	
	@Autowired
	SchoolMapper schoolMapper;
	
	//학생리스트 조회
	@Override
	public HashMap<String, Object> selectSchoolList(HashMap<String, Object> map) {
	
		HashMap<String, Object> resultMap = new HashMap<>();
		List<School> list = schoolMapper.selectSchoolList(map);
		int count = schoolMapper.stuCnt(map);
		resultMap.put("list",list);
		resultMap.put("count",count);		
		resultMap.put("result","success");
		
		return resultMap;	
	}

	@Override
	public HashMap<String, Object> stuInfoList(HashMap<String, Object> map) {
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<>();
		List<School> list = schoolMapper.stuInfo(map);
		resultMap.put("list",list);
		resultMap.put("result","success");
		
		return resultMap;
	}

	@Override
	public HashMap<String, Object> stuUpdate(HashMap<String, Object> map) {
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			schoolMapper.stuUpdate(map);	
			resultMap.put("result","success");			
		} catch (Exception e) {
			resultMap.put("result","fail");
		}
		
		return resultMap;
	}

}
