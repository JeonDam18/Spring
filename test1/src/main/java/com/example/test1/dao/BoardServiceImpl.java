package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.mapper.StudentMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Student;
import com.example.test1.model.User;

//예외처리는 이곳에서 해야한다
@Service
public class BoardServiceImpl implements BoardService{
	@Autowired
	BoardMapper BoardMapper;
	

	//게시글조회
	@Override
	public HashMap<String, Object> searchBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub

		HashMap<String, Object> resultMap = new HashMap<>();
		List<Board> list = BoardMapper.selectBoardList(map);
		int count = BoardMapper.boardCnt(map);
		resultMap.put("list",list);
		resultMap.put("count",count);		
		resultMap.put("result","success");
		
		return resultMap;	
	}
	
	//게시글 삭제
	@Override
	public HashMap<String, Object> deleteBoard(HashMap<String, Object> map) {
		 System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {			
			BoardMapper.deleteBoard(map);
			resultMap.put("message", "삭제되었습니다.");
		} catch (Exception e) {

			resultMap.put("message", "예기치 못한 문제가 발생했습니다.");			
		}
		

			return resultMap;
	}

	@Override
	public HashMap<String, Object> insertBoard(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			BoardMapper.insertBoard(map);
			
			resultMap.put("result", "success");
			resultMap.put("message", "저장되었습니다.");
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("message", "오류입니다.!!!!");
		}
		 
		return resultMap;
	}
	
	//게시물 상세
	@Override
	public HashMap<String, Object> BoardDetail(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Board board = BoardMapper.BoardList(map);
		List<Board> comment = BoardMapper.boardComments(map);
		resultMap.put("list",board);
		resultMap.put("comment",comment);
		return resultMap;
	}

	/*
	 * @Override public HashMap<String, Object> BoardComments(HashMap<String,
	 * Object> map) {
	 * 
	 * HashMap<String, Object> resultMap = new HashMap<String, Object>();
	 * List<Board> list = BoardMapper.boardComments(map);
	 * resultMap.put("list",list);
	 * 
	 * return resultMap; }
	 */
}
