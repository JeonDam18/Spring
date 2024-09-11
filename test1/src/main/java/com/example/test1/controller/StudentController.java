package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.StudentService;
import com.example.test1.model.Emp;
import com.example.test1.model.Student;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Controller
public class StudentController {
	
	@Autowired
	StudentService studentService;
	
	@RequestMapping("/student.do") 
    public String main(Model model) throws Exception{

        return "/student-list";
    }
	
	@RequestMapping("/emp.do") 
    public String emp(Model model) throws Exception{

        return "/emp-list";
    }
	
	@RequestMapping("/test.do") 
    public String test(Model model) throws Exception{

        return "/test";
    }
	@RequestMapping("/subject.do")
	public String subejct(Model model) throws Exception{
		
		return "subject-list";
	}
	
	
	
	@RequestMapping(value = "/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchBbsList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		
		List<Student> list = studentService.searchStudentList(map);
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return new Gson().toJson(resultMap);
	}
	
	
	@RequestMapping(value = "/ok.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String qwer(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		
		Student stu = studentService.searchQwer();
		resultMap.put("stu", stu);
		resultMap.put("result", "success");
		// {stu : {stuNo:20153075,stuName:옥한빛...}, 
				// result : success}
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/search.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String search(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
				= studentService.searchStu(map);
		return new Gson().toJson(resultMap);
	}
	
	
	@RequestMapping(value = "/empList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String emp(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		
		List<Emp> list = studentService.searchEmp();
		resultMap.put("list", list);
		resultMap.put("result", "success");
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/sub-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String sub_lsit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		
		resultMap = studentService.searchSubject();
		return new Gson().toJson(resultMap);
	}
	
	//게시글 선택삭제
	/*
	 * @RequestMapping(value = "/emp-check.dox", method = RequestMethod.POST,
	 * produces = "application/json;charset=UTF-8")
	 * 
	 * @ResponseBody public String emp_check(Model model, @RequestParam
	 * HashMap<String, Object> map) throws Exception { HashMap<String, Object>
	 * resultMap = new HashMap<String, Object>(); String json =
	 * map.get("selectItem").toString(); ObjectMapper mapper = new ObjectMapper();
	 * List<Object> list = mapper.readValue(json, new
	 * TypeReference<List<Object>>(){}); map.put("list", list);
	 * System.out.println(map); resultMap = studentService.searchEmp(map); return
	 * new Gson().toJson(resultMap); }
	 */
}

