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

import com.example.test1.dao.BoardService;
import com.google.gson.Gson;

@Controller
public class BoardController {
	// 주소 : board/list.do
	// 목록 : board/list.dox
	// db : tbl_board;
	// view : 테이블형태로 출력 (번호,제목,작성자,조회수,작성일)
	@Autowired
	BoardService BoardService;
	
	//게시글 목록 페이지
	@RequestMapping("/board-list.do") 
    public String boardList(Model model) throws Exception{

        return "/board-list";
    }
	
	//게시글 상세보기
	@RequestMapping("/board-view.do") 
    public String boardView(HttpServletRequest request,Model model,@RequestParam HashMap<String, Object> map) throws Exception{
 
        request.setAttribute("boardNo", map.get("boardNo"));
		return "/board-view";
    }
	
	   
	//게시글 등록 페이지
		@RequestMapping("/board-insert.do") 
	    public String boardInsert(Model model) throws Exception{

	        return "/board-insert";
	    }


	//게시글 상세
	@RequestMapping(value = "/board-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String board_view(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = BoardService.BoardDetail(map);
		return new Gson().toJson(resultMap);
	}	
		
	//게시글 출력
	@RequestMapping(value = "/board-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String board_list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = BoardService.searchBoard(map);
		return new Gson().toJson(resultMap);
	}
	//게시글 삭제
	@RequestMapping(value = "/board-delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String board_delete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = BoardService.deleteBoard(map);
		return new Gson().toJson(resultMap);
	}
	//게시글 게시
	@RequestMapping(value = "/board-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String board_insert(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap 
			= new HashMap<String, Object>();
		resultMap = BoardService.insertBoard(map);
		return new Gson().toJson(resultMap);
	}
}
