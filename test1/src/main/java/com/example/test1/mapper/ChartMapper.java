package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Chart;

@Mapper
public interface ChartMapper {
	List<Chart> chartData(HashMap<String,Object> map);
	List<Chart> areaData(HashMap<String,Object> map);
	List<Chart> areaGuData(HashMap<String,Object> map);
	List<Chart> areaDongData(HashMap<String,Object> map);
}
