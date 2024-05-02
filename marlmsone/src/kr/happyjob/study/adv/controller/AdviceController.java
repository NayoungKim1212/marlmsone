package kr.happyjob.study.adv.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.adv.model.AdviceVo;
import kr.happyjob.study.adv.model.LecInfoVo;
import kr.happyjob.study.adv.model.LecStdInfoVo;
import kr.happyjob.study.adv.service.AdviceService;

@Controller
@RequestMapping("/adv/")
public class AdviceController {
	
	@Autowired
	AdviceService adviceService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 공지사항 초기화면
	 */
	@RequestMapping("advice.do")
	public String advice( Model model, 
						  @RequestParam Map<String, Object> paramMap, 
						  HttpServletRequest request,
						  HttpServletResponse response, 
						  HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".advice");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".advice");

		return "adv/advice";
	}
	
	/**
	 * 강의 목록
	 */
	@RequestMapping("lecList.do")
	public String lecList( Model model, 
						   @RequestParam Map<String, Object> paramMap, 
						   HttpServletRequest request,
						   HttpServletResponse response, 
						   HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".lecList");
		logger.info("   - paramMap : " + paramMap);
		
		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int currentPage = Integer.valueOf((String)paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String)paramMap.get("pageSize"));		
		int startPos = (currentPage - 1) * pageSize;
		String loginID = (String)session.getAttribute("loginId");
		String userType = (String)session.getAttribute("userType");
		
		paramMap.put("startPos", startPos);
		paramMap.put("pageSize", pageSize);

		if (userType.equals("B")) {
			paramMap.put("tut_id", loginID);	
		}
		
		// 강의목록 조회
		List<LecInfoVo> listData = adviceService.lecList(paramMap);
		int listCnt = adviceService.lecListCnt(paramMap);
		
		logger.info("listData : " + listData);
		logger.info("listCnt : " + listCnt);
		
		model.addAttribute("listData", listData);
		model.addAttribute("listCnt", listCnt);		
		
		logger.info("+ End " + className + ".lecList");

		return "adv/lecList";
	}
	
	/**
	 * 상담 목록
	 */
	@RequestMapping("advList.do")
	public String advList( Model model, 
						   @RequestParam Map<String, Object> paramMap, 
						   HttpServletRequest request,
						   HttpServletResponse response, 
						   HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".advList");
		logger.info("   - paramMap : " + paramMap);
		
		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int currentPage = Integer.valueOf((String)paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String)paramMap.get("pageSize"));		
		int startPos = (currentPage - 1) * pageSize;
		
		paramMap.put("startPos", startPos);
		paramMap.put("pageSize", pageSize);
		
		// session 에서 id 가져오기 -> Map 으로 넣기
		String loginID = (String)session.getAttribute("loginId");
		String userType = (String)session.getAttribute("userType");
		
		if (userType.equals("B")) {
			paramMap.put("tut_id", loginID);	
		}
			
		// 상담 목록 조회
		List<AdviceVo> listData = adviceService.advList(paramMap);
		// 상담 목록 카운트 조회
		int listCnt = adviceService.advListCnt(paramMap);
		
		logger.info("listData : " + listData);
		logger.info("listCnt : " + listCnt);
		
		model.addAttribute("listData", listData);
		model.addAttribute("listCnt", listCnt);
		
		logger.info("+ End " + className + ".advList");

		return "adv/advList";
	}
	
	/**
	 * 상담 상세보기
	 */
	@RequestMapping("advDetail.do")
	@ResponseBody
	public Map<String, Object> advDetail( Model model, 
						     			  @RequestParam Map<String, Object> paramMap, 
						     			  HttpServletRequest request,
						     			  HttpServletResponse response, 
						     			  HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".advDetail");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		String loginID = (String)session.getAttribute("loginId");
		
		// 상담 상세보기
		AdviceVo data = adviceService.advDetail(paramMap);
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("data", data);
		resultMap.put("loginID", loginID);
		
		logger.info("   - resultMap : " + resultMap);
		logger.info("+ End " + className + ".saveAdvice");

		return resultMap;
	}
	
	/**
	 * 모달창 강의 목록
	 */
	@RequestMapping("mlecList.do")
	public String mlecList( Model model, 
						   @RequestParam Map<String, Object> paramMap, 
						   HttpServletRequest request,
						   HttpServletResponse response, 
						   HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".mlecList");
		logger.info("   - paramMap : " + paramMap);		
		
		String loginID = (String)session.getAttribute("loginId");
		String userType = (String)session.getAttribute("userType");
		
		if (userType.equals("B")) {
			paramMap.put("tut_id", loginID);	
		}
		
		List<LecInfoVo> listData = adviceService.lecList(paramMap);
		int listCnt = adviceService.lecListCnt(paramMap);
		
		logger.info("listData : " + listData);
		logger.info("listCnt : " + listCnt);
		
		model.addAttribute("listData", listData);
		model.addAttribute("listCnt", listCnt);		
		
		logger.info("+ End " + className + ".mlecList");

		return "adv/mlecList";
	}
	
	/**
	 * 모달창 학생 목록
	 */
	@RequestMapping("mlecStdList.do")
	public String mlecStdList( Model model, 
						       @RequestParam Map<String, Object> paramMap, 
						       HttpServletRequest request,
						       HttpServletResponse response, 
						       HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".mstdList");
		logger.info("   - paramMap : " + paramMap);
		
		List<LecStdInfoVo> listData = adviceService.lecStdList(paramMap);
		int listCnt = adviceService.lecStdListCnt(paramMap);
		
		logger.info("listData : " + listData);
		logger.info("listCnt : " + listCnt);
		
		model.addAttribute("listData", listData);
		model.addAttribute("listCnt", listCnt);	
		
		logger.info("+ End " + className + ".mstdList");

		return "adv/mlecStdList";
	}
	
	/**
	 * 상담 저장(등록/수정)
	 */
	@RequestMapping("advSave.do")
	@ResponseBody
	public Map<String, Object> advSave( Model model, 
						   				@RequestParam Map<String, Object> paramMap, 
						   				HttpServletRequest request,
										HttpServletResponse response, 
										HttpSession session ) throws Exception {
		
				
		logger.info("+ Start " + className + ".saveAdvice");
		logger.info("   - paramMap : " + paramMap);

		String action = (String)paramMap.get("action");
		String result = "";
		String resultMsg = "";
		int res = 0;
		
		if ("I".equals(action)) {			// 상담 신규 등록
			
			// 사용자 정보를 상담자ID 파라미터에 저장
			paramMap.put("tut_id", session.getAttribute("loginId"));			
			res = adviceService.advRegister(paramMap);
			logger.info("adviceService.advRegister res : " + res);
			if (res > 0) {
				result = "SUCCESS";
				resultMsg = "등록 하였습니다.";
			}
			
		} else if ("U".equals(action)) {	// 상담 수정
			res = adviceService.advUpdate(paramMap);
			if (res > 0) {
				result = "SUCCESS";
				resultMsg = "수정 하였습니다.";
			}
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("   - resultMap : " + resultMap);
		logger.info("+ End " + className + ".saveAdvice");

		return resultMap;
	}
	
	
	/**
	 * 상담 삭제
	 */
	@RequestMapping("advDelete.do")
	@ResponseBody
	public Map<String, Object> advDelete( Model model, 
						   				  @RequestParam Map<String, Object> paramMap, 
						   				  HttpServletRequest request,
										  HttpServletResponse response, 
										  HttpSession session ) throws Exception {
				
		logger.info("+ Start " + className + ".advDelete");
		logger.info("   - paramMap : " + paramMap);

		int res = 0;
		String result = "";
		String resultMsg = "";
		
		// 상담 삭제
		res = adviceService.advDelete(paramMap);
		logger.info("adviceService.advRegister res : " + res);
		
		if (res > 0) {
			result = "SUCCESS";
			resultMsg = "삭제 하였습니다.";			
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("   - resultMap : " + resultMap);
		logger.info("+ End " + className + ".advDelete");

		return resultMap;
	}
	
	
	/*
	*//**
	 * 공지사항 파일 없이 저장
	 *//*
	@RequestMapping("noticesave.do")
	@ResponseBody	// body 에만 담아서 데이터 리턴을 위함
	public Map<String, Object> noticesave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticesave");
		logger.info("   - paramMap : " + paramMap);
		
		// 반환할 데이터를 담을 Map 객체
		Map<String, Object> returnmap = new HashMap<>();
		
		// JSON 형태로 넘겨준 param 값 가져오기 Object 타입 -> 캐스팅 필요
		String action = (String)paramMap.get("action");
		
		// session 에서 id 가져오기 -> Map 으로 넣기
		String loginID = (String)session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		// 신규 등록이면
		int sreturn = 0;
		String result = "";
		String resultmsg = "";
		if("I".equals(action)){
			sreturn = noticeService.noticesave(paramMap);
			//System.out.println((String)paramMap.get("ititle"));
		} else if("U".equals(action)){
			sreturn = noticeService.noticeupdate(paramMap);
		} else if("D".equals(action)){
			sreturn = noticeService.noticedelete(paramMap);
		}
		
		if(sreturn>=0){
			result = "S";
			
			if("D".equals(action))
				resultmsg = "삭제되었습니다.";
			else
				resultmsg = "저장되었습니다.";
			
		} else {
			result = "F";
			
			if("D".equals(action))
				resultmsg = "삭제 실패하였습니다.";
			else
				resultmsg = "저장 실패하였습니다.";
		}
		
		returnmap.put("result", result);
		returnmap.put("resultmsg", resultmsg);
		
		logger.info("+ End " + className + ".noticesave");
		
		return returnmap;
	}
	
	
	*//**
	 * 공지사항 상세 조회
	 *//*
	@RequestMapping("noticedtl.do")
	@ResponseBody	// body 에만 담아서 데이터 리턴을 위함
	public Map<String, Object> noticedtl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticedtl");
		logger.info("   - paramMap : " + paramMap);
		
		// 반환할 데이터를 담을 Map 객체
		Map<String, Object> returnmap = new HashMap<>();
		noticeService.noticehitupdate(paramMap);
		Noticevo selinfo = noticeService.noticedtl(paramMap);	

		returnmap.put("selinfo", selinfo);
		
		logger.info("+ End " + className + ".noticedtl");
		
		return returnmap;
	}*/
	
	
}
