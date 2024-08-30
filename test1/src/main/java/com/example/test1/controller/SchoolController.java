package com.example.test1.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.SchoolService;
import com.google.gson.Gson;

@Controller
public class SchoolController {
	@Autowired
	SchoolService schoolService;
	//학생조회
	@RequestMapping("/school-stu.do") 
    public String schoolList(Model model) throws Exception{
        return "/school-stu";
    }
	//학생정보출력
	@RequestMapping("/school-stuView.do") 
	public String stuViewList(HttpServletRequest request,Model model,@RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("stuNo", map.get("stuNo"));
		return "/school-stuView";
	}
	@RequestMapping("/school-stuInfoUpdate.do") 
	public String stuUpdate(HttpServletRequest request,Model model,@RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("stuNo", map.get("stuNo"));
		return "/school-stuInfoUpdate";
	}

	@RequestMapping(value = "/stu-update.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stu_update(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
		= new HashMap<String, Object>();
		resultMap = schoolService.stuUpdate(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/school-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String school_view(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = schoolService.selectSchoolList(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/stu-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String school_stu_view(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
		= new HashMap<String, Object>();
		resultMap = schoolService.stuInfoList(map);
		return new Gson().toJson(resultMap);
	}
}
