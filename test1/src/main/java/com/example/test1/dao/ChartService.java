package com.example.test1.dao;

import java.util.HashMap;

public interface ChartService {
	HashMap<String, Object> ChartData(HashMap<String, Object> map);
	HashMap<String, Object> areaData(HashMap<String, Object> map);
	HashMap<String, Object> itemSelect(HashMap<String, Object> map);
	HashMap<String, Object> codeList(HashMap<String, Object> map);
	HashMap<String, Object> weatherData(HashMap<String, Object> map);
	
}
