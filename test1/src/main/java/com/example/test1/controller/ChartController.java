package com.example.test1.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.dao.ChartService;
import com.example.test1.dao.ChartServiceImpl;
import com.example.test1.mapper.BoardMapper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Controller
public class ChartController {
	
	@Autowired
	ChartService chartService;
	
	@Autowired
	BoardMapper boardMapper;
	
	
	
	@RequestMapping("/chart.do") 
    public String boardList(Model model) throws Exception{

        return "/chart";
	}
	
	@RequestMapping("/payment.do") 
    public String payment(Model model) throws Exception{

        return "/payment";
	}
	@RequestMapping("/area.do") 
	public String area(Model model) throws Exception{
		
		return "/area";
	}
	@RequestMapping("/sampleJuso.do") 
	public String juso(Model model) throws Exception{
		
		return "/SampleJuso";
	}
	@RequestMapping("/jusoPopup.do") 
	public String jusoPopup(Model model) throws Exception{
		
		return "/jusoPopup";
	}
	@RequestMapping("/juso.do") 
	public String jusoPop(Model model) throws Exception{
		
		return "/juso";
	}
	@RequestMapping("/file.do") 
	public String fileUpload(Model model) throws Exception{
		
		return "/file";
	}
	// coolSMS 테스트 화면
	@RequestMapping("/sms.do")
	public String mySms() {
		return "sms";
	}
	// 아이템 정렬
	@RequestMapping("/item.do")
	public String itemView(Model model) throws Exception{
		return "item";
	}
	
	@RequestMapping("/api1.do")
	public String api1(Model model) throws Exception{
		return "api1";
	}
	
	
	    
	// coolSMS 구현 로직 연결  
	/*
	 * @RequestMapping("/check/sendSMS") public @ResponseBody String
	 * sendSMS(@RequestParam(value="to") String to) throws CoolsmsException { return
	 * ChartService.PhoneNumberCheck(to); }
	 */
	@RequestMapping(value = "/weather.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String weather(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = chartService.weatherData(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/chart-data.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String chart_data(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
		= new HashMap<String, Object>();
		resultMap = chartService.ChartData(map);
		return new Gson().toJson(resultMap);
	}
	//ITEM리스트
	@RequestMapping(value = "/item-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String item_list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
		= new HashMap<String, Object>();
		String json = map.get("selectItem").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		resultMap = chartService.itemSelect(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/code-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String code_list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
		= new HashMap<String, Object>();
		resultMap = chartService.codeList(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/area.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String area(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = chartService.areaData(map);
		return new Gson().toJson(resultMap);
	}
}
