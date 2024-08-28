package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.StudentMapper;
import com.example.test1.model.Emp;
import com.example.test1.model.Student;

@Service
public class StudentServiceImpl implements StudentService{

	@Autowired
	StudentMapper studentMapper;
	
	@Override
	public List<Student> searchStudentList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return studentMapper.selectStudentList();
	}

	@Override
	public Student searchQwer() {
		// TODO Auto-generated method stub
		Student s = studentMapper.qwer();
		return s;
	}

	@Override
	public HashMap<String, Object> searchStu(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			// db호출 데이터, 
			// 결과(성공,실패), 메시지(성공메시지, 오류메시지)
			Student s = studentMapper.selectStu(map);
			resultMap.put("stu", s);
			resultMap.put("result", "success");
			String msg  =
					s != null ? "조회했습니다!" : "학번을 확인해주세요.";
			resultMap.put("message", msg);
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			resultMap.put("message", "db조회 오류");
		}
		return resultMap;
	}

	@Override
	public List<Emp> searchEmp() {
		// TODO Auto-generated method stub
		return studentMapper.selectEmp();
	}

	@Override
	public HashMap<String ,Object> searchSubject() {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<>();
		List<Student> subject = studentMapper.selectSubject();
		List<Student> student = studentMapper.selectStudentList();
		resultMap.put("subList", subject);
		resultMap.put("stuList", student); 
		
		return resultMap;
		
	}
}