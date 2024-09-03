package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Student;

public interface BoardService {
	//게시글조회
	HashMap<String, Object> searchBoard(HashMap<String, Object> map);
	
	//게시글삭제
	HashMap<String, Object> deleteBoard(HashMap<String, Object> map);
	
	//게시글 게시
	HashMap<String,Object> insertBoard(HashMap<String, Object> map);
	
	//게시물 상세
	HashMap<String,Object> BoardDetail(HashMap<String, Object> map);

	//댓글
	/* HashMap<String,Object> BoardComments(HashMap<String, Object> map); */
	
	
}
