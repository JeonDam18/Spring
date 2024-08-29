package com.example.test1.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.UserService;
import com.google.gson.Gson;

@Controller
public class UserController {
	@Autowired
	UserService UserService;
	
	@Autowired
	HttpSession session;
	
	//로그인
	@RequestMapping("/login.do") 
    public String login(Model model) throws Exception{

        return "/login";
    }
	
	//회원가입
	@RequestMapping("/join.do") 
	public String join(Model model) throws Exception{
		
		return "/join";
	}
	//유저 정보
	@RequestMapping("/user-view.do") 
    public String userinfo(HttpServletRequest request,Model model,@RequestParam HashMap<String, Object> map) throws Exception{
		System.out.println(map); 
        request.setAttribute("userId", map.get("userId"));
		return "/user-view";
    }
	//아이디체크
	@RequestMapping("/idcheck.do") 
    public String idcheck(HttpServletRequest request,Model model,@RequestParam HashMap<String, Object> map) throws Exception{
		System.out.println(map); 
        request.setAttribute("userId", map.get("userId"));
		return "/join";
    }
	
	//유저리스트
	@RequestMapping("/user-list.do") 
	public String userlist(Model model) throws Exception{
		
		return "/user-list";
	}
	
	//유저 정보
	@RequestMapping(value = "/user-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String user_List(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = UserService.UserList(map);
		return new Gson().toJson(resultMap);
	}
	//회원가입
	@	RequestMapping(value = "/user-join.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String user_join(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = UserService.userJoin(map);
		return new Gson().toJson(resultMap);
	}
	
	//아이디체크
	@RequestMapping(value = "/user-check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String user_check(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = UserService.Userinfo(map);
		return new Gson().toJson(resultMap);
	}	
		     
	//유저 정보
	@RequestMapping(value = "/user-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String user_view(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = UserService.Userinfo(map);
		return new Gson().toJson(resultMap);
	}	
	@RequestMapping(value = "/user-login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String user_login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("controller"+map); 
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = UserService.userLogin(map);
		return new Gson().toJson(resultMap);
	}
}
