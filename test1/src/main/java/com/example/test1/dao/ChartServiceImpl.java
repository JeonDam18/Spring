package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ChartMapper;
import com.example.test1.model.Chart;

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
				if(map.get("si").equals("세종특별자치시")) {
					list = chartmapper.areaDongData(map);
				}
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

}
