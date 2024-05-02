package kr.happyjob.study.employ.controller;

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

import kr.happyjob.study.employ.model.EmploymentModel;
import kr.happyjob.study.employ.service.EmploymentService;
import kr.happyjob.study.register.model.RegisterListModel;

@Controller
@RequestMapping("/employ/")
public class EmploymentController {

	@Autowired
	EmploymentService employmentService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger 
	private final String className = this.getClass().toString();
	
	
	// 초기 화면
	@RequestMapping("employmentInfo.do")
	public String empInfo(Model model, @RequestParam Map<String, Object> paramMap
			,HttpSession session) throws Exception{
		
		logger.info("===== 취업 목록  페이지 =====");
		
		List<EmploymentModel> compinfo = employmentService.compinfo(paramMap);
		model.addAttribute("compinfo", compinfo);
		
		return "employ/employ";
	}
	
	// 취업 목록 리스트
	@RequestMapping("listEmp.do")
	public String listLec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".listLec");
		logger.info(" - paramMap : " + paramMap);

		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));

		int startpos = (currentPage - 1) * pageSize;

		paramMap.put("startpos", startpos);
		paramMap.put("pageSize", pageSize);

		// 목록 조회
		List<EmploymentModel> empInfo = employmentService.empInfo(paramMap);
		logger.info("empInfo"+empInfo);
		
		// 목록 조회 카운트
		int emp_Total = employmentService.emp_Total(paramMap);

		System.out.println("empInfo : " + empInfo);
		System.out.println("emp_Total : " + emp_Total);

		model.addAttribute("empInfo", empInfo);
		model.addAttribute("emp_Total", emp_Total);

		logger.info("+ End " + className + ".listLec");
		logger.info("empInfo : " + empInfo);

		return "employ/employList";
	}
	
	/* 학생 목록 조회 */
	@RequestMapping("empstdList.do")
	public String empstdList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".empstdList");
		logger.info(" - paramMap : " + paramMap);

		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));

		int startpos = (currentPage - 1) * pageSize;

		paramMap.put("startpos", startpos);
		paramMap.put("pageSize", pageSize);

		// 목록 조회
		List<EmploymentModel> stdList = employmentService.stdList(paramMap);

		// 목록 조회 카운트
		int std_Total = employmentService.std_Total(paramMap);

		System.out.println("stdList : " + stdList);
		System.out.println("std_Total : " + std_Total);

		model.addAttribute("stdList", stdList);
		model.addAttribute("std_Total", std_Total);

		logger.info("+ End " + className + ".empstdList");
		logger.info("stdList : " + stdList);

		return "employ/empstdList";
	}
	
	// 학생 모달 정보
	@RequestMapping("stdDetail.do")
	public String stdDetail(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".stdDetail");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 모달창 강의정보 출력
		List<EmploymentModel> std_info = employmentService.std_info(paramMap);
		int lec_count = employmentService.lec_count(paramMap);

		model.addAttribute("std_info", std_info);
		model.addAttribute("lec_count", lec_count);

		logger.info("std_info : " + std_info);
		logger.info("lec_count : " + lec_count);
		logger.info("+ End " + className + ".stdDetail");

		return "employ/stdlecList";
	}
	
	// 학생 모달 정보
	@RequestMapping("stdInfoDetail.do")
	@ResponseBody
	public Map<String, Object> stdInfoDetail(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".stdInfoDetail");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 모달창 강의정보 출력
		List<EmploymentModel> std_detail = employmentService.std_detail(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("std_detail", std_detail);
		
		logger.info("+ End " + className + ".stdInfoDetail");
		
		return resultMap;
	}
	
	// 취업 등록 모달
	@RequestMapping("stdEmploy.do")
	@ResponseBody
	public Map<String, Object> stdEmploy(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".stdEmploy");
		logger.info("   - paramMap : " + paramMap);

		String action = (String)paramMap.get("action");
		
		String result = "SUCCESS";
		String resultMsg = "등록 되었습니다.";
		
		String reday = (String)paramMap.get("resign_day");
		
		if(action.equals("I")) {
			System.out.println("action : =====" + action);
			
			if (reday.equals("")) {
				reday = null;
				paramMap.put("resign_day", reday);
			}
			employmentService.stdemploy(paramMap);
		} 
		if(action.equals("U")){
			System.out.println("수정action : ===" + action);
			if (reday.equals("")) {
				reday = null;
				paramMap.put("resign_day", reday);
			}
			employmentService.update_emp(paramMap);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".stdEmploy");
		
		return resultMap;
	}
	
	// 모달 연락처, 이름 가져오기
	@RequestMapping("stdinfo.do")
	@ResponseBody
	public Map<String, Object> stdinfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".stdinfo");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		EmploymentModel stdinfo = employmentService.stdinfo(paramMap);
		System.out.println("stdinfo : " + stdinfo);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("stdinfo", stdinfo);
		
		logger.info("+ End " + className + ".stdinfo");
		
		return resultMap;
	}
	//취업정보삭제
	@RequestMapping("delEmploy.do")
	@ResponseBody
	public Map<String, Object> delEmploy(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".delEmploy");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";		
		
		employmentService.delEmploy(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".delEmploy");
		
		return resultMap;
	}
}
