package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.example.test1.constants.ResMessage;
import com.example.test1.mapper.ChartMapper;
import com.example.test1.model.Chart;
import com.mysql.cj.protocol.Message;

@Service
public class ChartServiceImpl implements ChartService{
	@Autowired
	ChartMapper chartmapper;
	
	@Override
	public HashMap<String, Object> ChartData(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		List<Chart> list = chartmapper.chartData(map);
	
		resultMap.put("list",list);		
		
		return resultMap;
	}

	@Override
	public HashMap<String, Object> areaData(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			System.out.println(map);
			List<Chart> list = null;
			if(!map.get("gu").equals("")) {
					list = chartmapper.areaDongData(map);
			}else if(!map.get("si").equals("")) {
				list = chartmapper.areaGuData(map);
			}else {
				list = chartmapper.areaData(map);				
			}
			resultMap.put("list",list);
		} catch (Exception e) {
			resultMap.put("result","fail");
		}		
		return resultMap;
	}

	@Override
	public HashMap<String, Object> itemSelect(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		List<Chart> list = chartmapper.itemSelect(map);
	
		resultMap.put("list",list);		
		
		return resultMap;
	}
	@Override
	public HashMap<String, Object> codeList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			List<Chart> list = chartmapper.codeList(map);
			resultMap.put("codeList", list);
			resultMap.put("message",ResMessage.SUCCESS);	
		} catch (DataAccessException e) {
			resultMap.put("message","데이터베이스 접근 에러");				
			resultMap.put("result",ResMessage.DB_ACCESS_ERROR);							
		} catch (PersistenceException e) {
			resultMap.put("message","Mybatis 구문에러");				
			resultMap.put("result",ResMessage.MYBATIS_ERROR);						
		} catch (Exception e) {
			resultMap.put("message","알수없는오류");				
			resultMap.put("result",ResMessage.UNKOWN_ERROR);				
		}
		
		return resultMap;
	}

	@Override
	public HashMap<String, Object> weatherData(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<>();
		Chart list = chartmapper.weatherData(map);
		System.out.println(list);
		resultMap.put("list",list);		
		
		return resultMap;
	}
	
	/*
	 * public String PhoneNumberCheck(String to) throws CoolsmsException {
	 * 
	 * String api_key = "NCSHONZYXFYSSMEB"; String api_secret =
	 * "UNNGPMH4FUXIRCPQY2VSJPZFOZTB80QE"; Message coolsms = new Message(api_key,
	 * api_secret);
	 * 
	 * Random rand = new Random(); String numStr = ""; for(int i=0; i<4; i++) {
	 * String ran = Integer.toString(rand.nextInt(10)); numStr+=ran; }
	 * 
	 * HashMap<String, String> params = new HashMap<String, String>();
	 * params.put("to", to); // 수신전화번호 (ajax로 view 화면에서 받아온 값으로 넘김)
	 * params.put("from", "01072791324"); // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	 * params.put("type", "sms"); params.put("text", "인증번호는 [" + numStr + "] 입니다.");
	 * 
	 * coolsms.send(params); // 메시지 전송
	 * 
	 * return numStr;
	 * 
	 * }
	 */

}
