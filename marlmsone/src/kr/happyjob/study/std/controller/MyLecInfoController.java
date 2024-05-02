package kr.happyjob.study.std.controller;

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

import kr.happyjob.study.std.model.MyLecInfoVo;
import kr.happyjob.study.std.model.SurveyInfoVo;

import kr.happyjob.study.adv.service.AdviceService;
import kr.happyjob.study.std.service.MyLecInfoService;

@Controller
@RequestMapping("/std/")
public class MyLecInfoController {
	
	@Autowired
	AdviceService adviceService;
	
	@Autowired
	MyLecInfoService myLecInfoService;

	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 나의 수강목록 초기화면
	 */
	@RequestMapping("myLecInfo.do")
	public String myLectureInfo( Model model, 
						         @RequestParam Map<String, Object> paramMap, 
						         HttpServletRequest request,
						         HttpServletResponse response, 
						         HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".myLectureInfo");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".myLectureInfo");

		return "std/myLecInfo";
	}
	
	/**
	 * 나의 수강목록 목록
	 */
	@RequestMapping("myLecList.do")
	public String myLecList( Model model, 
						     @RequestParam Map<String, Object> paramMap, 
						     HttpServletRequest request,
						     HttpServletResponse response, 
						     HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".myLecList");
		logger.info("   - paramMap : " + paramMap);
		
		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int currentPage = Integer.valueOf((String)paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String)paramMap.get("pageSize"));		
		int startPos = (currentPage - 1) * pageSize;
		
		paramMap.put("startPos", startPos);
		paramMap.put("pageSize", pageSize);
		
		// session 에서 id 가져오기 -> Map 으로 넣기
		String loginID = (String)session.getAttribute("loginId");
		paramMap.put("loginID", loginID);		
		
		List<MyLecInfoVo> listData = myLecInfoService.myLecList(paramMap);
		int listCnt = myLecInfoService.myLecListCnt(paramMap);
		
		logger.info("listData : " + listData);
		logger.info("listCnt : " + listCnt);
		
		model.addAttribute("listData", listData);
		model.addAttribute("listCnt", listCnt);		
		
		logger.info("+ End " + className + ".myLecList");

		return "std/myLecList";
	}
	
	/**
	 * 나의 수강목록 상세보기
	 */
	@RequestMapping("myLecDetail.do")
	public String myLecDetail( Model model, 
							   @RequestParam Map<String, Object> paramMap, 
						       HttpServletRequest request,
						       HttpServletResponse response, 
						       HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".myLecDetail");
		logger.info("   - paramMap : " + paramMap);
		
		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";		
		int lec_id = Integer.valueOf((String)paramMap.get("lec_id"));
		
		paramMap.put("lec_id", lec_id);
		
		// 나의 수강목록 상세보기
		List<MyLecInfoVo> listData = myLecInfoService.myLecDetail(paramMap);
		int listCnt = myLecInfoService.myLecDetailCnt(paramMap);
		
		model.addAttribute("result", result);
		model.addAttribute("resultMsg", resultMsg);

		model.addAttribute("listData", listData);
		model.addAttribute("listCnt", listCnt);
		
		logger.info("+ End " + className + ".myLecDetail");

		return "std/myLecDetail";
	}
	
	/**
	 * 설문조사 클릭 시 설문조사 문항 조회
	 */
	@RequestMapping("surveyItemList.do")	
	public String surveyItemList( Model model, 
						          @RequestParam Map<String, Object> paramMap, 
						          HttpServletRequest request,
						          HttpServletResponse response, 
						          HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".surveyItemList");
		logger.info("   - paramMap : " + paramMap);
		
		List<SurveyInfoVo> listData = myLecInfoService.surveyItemList(paramMap);
		int listCnt = myLecInfoService.surveyItemListCnt(paramMap);
		
		logger.info("listData : " + listData);
		logger.info("listCnt : " + listCnt);
		
		model.addAttribute("lec_id", paramMap.get("lec_id"));
		model.addAttribute("lec_name", paramMap.get("lec_name"));
		model.addAttribute("tut_name", paramMap.get("tut_name"));
		model.addAttribute("listData", listData);
		model.addAttribute("listCnt", listCnt);
		
		logger.info("+ End " + className + ".surveyItemList");

		return "std/surveyItemList";
	}
	
	// 설문조사 제출
	@RequestMapping("/submitSurvey.do")
	@ResponseBody
	public Map<String, Object> submitSurvey( Model model, 
										     @RequestParam Map<String, Object> paramMap, 
										     HttpServletRequest request,
										     HttpServletResponse response, 
										     HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".submitTest");		
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("std_id", session.getAttribute("loginId"));
		
		int submitSurvey = myLecInfoService.submitSurvey(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if ( submitSurvey > 0 ) {
			resultMap.put("result","SUCCESS");
			resultMap.put("resultMsg","설문조사가 제출되었습니다.");
			
			resultMap.put("lec_id",paramMap.get("lec_id"));
			resultMap.put("test_id",paramMap.get("test_id"));
		} else {
			resultMap.put("result","FAIL");
		}
		
		logger.info("+ End " + className + ".submitTest");
		
		return resultMap;
	}	
}