package com.example.test1.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;

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

import com.example.test1.dao.BoardService;
import com.example.test1.mapper.BoardMapper;
import com.google.gson.Gson;

@Controller
public class BoardController {
	// 주소 : board/list.do
	// 목록 : board/list.dox
	// db : tbl_board;
	// view : 테이블형태로 출력 (번호,제목,작성자,조회수,작성일)
	@Autowired
	BoardService BoardService;
	
	@Autowired
	BoardMapper boardMapper;
	
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
	@RequestMapping("/fileUpload.dox")
    public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("boardNo") int boardNo, HttpServletRequest request,HttpServletResponse response, Model model)
    {
        String url = null;
        String path=System.getProperty("user.dir");
        System.out.println(path);
        try {
 
            //String uploadpath = request.getServletContext().getRealPath(path);
            String uploadpath = path;
            String originFilename = multi.getOriginalFilename();
            String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
            long size = multi.getSize();
            String saveFileName = genSaveFileName(extName);
            
            System.out.println("uploadpath : " + uploadpath);
            System.out.println("originFilename : " + originFilename);
            System.out.println("extensionName : " + extName);
            System.out.println("size : " + size);
            System.out.println("saveFileName : " + saveFileName);
//            String path2 = System.getProperty("user.dir");
            System.out.println("Working Directory = " + path + "\\src\\webapp\\img");
            if(!multi.isEmpty()){
                File file = new File(path + "\\src\\main\\webapp\\img", saveFileName);
                multi.transferTo(file);
                
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("filename", saveFileName);
                map.put("path", "../img/" + saveFileName);
                map.put("boardNo", boardNo);
                
                // insert 쿼리 실행
                boardMapper.insertBoardFile(map);
                
                model.addAttribute("filename", multi.getOriginalFilename());
                model.addAttribute("uploadPath", file.getAbsolutePath());
                
                return "redirect:board-list.do";
            }
        }catch(Exception e) {
            System.out.println(e);
        }
        return "redirect:board-list.do";
    }
    
    // 현재 시간을 기준으로 파일 이름 생성
    private String genSaveFileName(String extName) {
        String fileName = "";
        
        Calendar calendar = Calendar.getInstance();
        fileName += calendar.get(Calendar.YEAR);
        fileName += calendar.get(Calendar.MONTH);
        fileName += calendar.get(Calendar.DATE);
        fileName += calendar.get(Calendar.HOUR);
        fileName += calendar.get(Calendar.MINUTE);
        fileName += calendar.get(Calendar.SECOND);
        fileName += calendar.get(Calendar.MILLISECOND);
        fileName += extName;
        
        return fileName;
    }
}
