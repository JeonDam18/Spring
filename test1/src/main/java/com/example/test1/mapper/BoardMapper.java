package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Student;
import com.example.test1.model.User;

@Mapper
public interface BoardMapper {
	 List<Board> selectBoardList(HashMap<String,Object> map);
	
	 //게시물 상세
	 Board BoardList(HashMap<String,Object> map);
	 
	 int boardCnt(HashMap<String,Object> map);
	
	 //게시글 삭제
	 void deleteBoard(HashMap<String,Object> map);
	 
	 void insertBoard(HashMap<String,Object> map);
	 
	 void insertBoardFile(HashMap<String,Object> map);
	 
	 List<Board> boardComments(HashMap<String,Object> map);
}
