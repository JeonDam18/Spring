package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import com.example.test1.model.Emp;
import com.example.test1.model.Student;

public interface StudentService {
	// 게시글 조회
	List<Student> searchStudentList(HashMap<String, Object> map);
	
	Student searchQwer();
	
	HashMap<String, Object> searchStu(HashMap<String, Object> map);
	
	List<Emp> searchEmp();
	
	HashMap<String, Object> searchSubject();
	
	
	
	
	
	
	
	
}