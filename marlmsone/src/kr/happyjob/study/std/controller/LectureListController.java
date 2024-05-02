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

import kr.happyjob.study.std.model.LectureModel;
import kr.happyjob.study.std.service.LectureService;
import kr.happyjob.study.tut.model.LecturePlanModel;


@Controller
@RequestMapping("/std/")
public class LectureListController {

	@Autowired
	LectureService lectureService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger 
	private final String className = this.getClass().toString();
	
	
	// 초기 화면
	@RequestMapping("lectureList.do")
	public String empInfo(Model model, @RequestParam Map<String, Object> paramMap
			,HttpSession session) throws Exception{
		
		logger.info("===== 강의 목록  페이지 =====");
		
		return "std/lecture";
	}
	
	// 강의 목록 리스트
	@RequestMapping("lecList.do")
	public String listLec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		paramMap.put("std_id", session.getAttribute("loginId"));
		
		logger.info("+ Start " + className + ".lecList");
		logger.info(" - paramMap : " + paramMap);

		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));

		int startpos = (currentPage - 1) * pageSize;

		paramMap.put("startpos", startpos);
		paramMap.put("pageSize", pageSize);

		// 목록 조회
		List<LectureModel> lecList = lectureService.lecList(paramMap);
		logger.info("lecList"+lecList);
		
		// 목록 조회 카운트
		int lecTotal = lectureService.lecTotal(paramMap);

		System.out.println("lecList : " + lecList);
		System.out.println("lecTotal : " + lecTotal);

		model.addAttribute("lecList", lecList);
		model.addAttribute("lecTotal", lecTotal);

		logger.info("+ End " + className + ".lecList");
		logger.info("empInfo : " + lecList);

		return "std/lectureList";
	}
	
	// 모달 강의정보
	@RequestMapping("lecInfo.do")
	@ResponseBody
	public Map<String, Object> lecInfo(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".lecInfo");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 모달창 강의정보 출력
		LectureModel lecInfo = lectureService.lecInfo(paramMap);
		
		//주차 계획 리스트 출력
		List<LectureModel> week_plan=lectureService.week_plan(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("lecInfo", lecInfo);
		resultMap.put("week_plan", week_plan);

		logger.info("+ End " + className + ".lecInfo");

		return resultMap;
	}
	
	// 수강 신청
	@RequestMapping("lecReg.do")
	@ResponseBody
	public Map<String, Object> lecReg(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		paramMap.put("std_id", session.getAttribute("loginId"));
		
		logger.info("+ Start " + className + ".lecReg");
		logger.info("   - paramMap : " + paramMap);
				
		String result = "SUCCESS";
		String resultMsg = "수강 신청 되었습니다.";
		
		int lecReg = lectureService.lecReg(paramMap);
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".lecReg");
		
		return resultMap;
	}
}
