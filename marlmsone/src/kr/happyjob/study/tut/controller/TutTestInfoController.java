package kr.happyjob.study.tut.controller;

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

import kr.happyjob.study.std.model.TestDetailVo;
import kr.happyjob.study.std.model.TestUserVo;
import kr.happyjob.study.std.model.TestResultVo;
import kr.happyjob.study.tut.model.TutTestInfoVo;

import kr.happyjob.study.std.service.MyTestInfoService;
import kr.happyjob.study.tut.service.TutTestInfoService;

@Controller
@RequestMapping("/tut/")
public class TutTestInfoController {
	
	@Autowired
	MyTestInfoService myTestInfoService;

	@Autowired
	TutTestInfoService tutTestInfoService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 강사의 시험출제 목록 초기화면
	 */
	@RequestMapping("testGenerate.do")
	public String myTestInfo( Model model, 
						      @RequestParam Map<String, Object> paramMap, 
						      HttpServletRequest request,
						      HttpServletResponse response, 
						      HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".myTestInfo");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".myTesetInfo");

		return "tut/testGenerate";
	}
	
	
	/**
	 * 강사의 시험출제 목록 조회
	 */
	@RequestMapping("tutTestList.do")
	public String tutTestList( Model model, 
					 	       @RequestParam Map<String, Object> paramMap, 
						       HttpServletRequest request,
						       HttpServletResponse response, 
						       HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".tutTestList");
		logger.info("   - paramMap : " + paramMap);
		
		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int currentPage = Integer.valueOf((String)paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String)paramMap.get("pageSize"));		
		int startPos = (currentPage - 1) * pageSize;
		
		paramMap.put("startPos", startPos);
		paramMap.put("pageSize", pageSize);
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		List<TutTestInfoVo> listData = tutTestInfoService.tutTestList(paramMap);
		int listCnt = tutTestInfoService.tutTestListCnt(paramMap);
		
		logger.info("listData : " + listData);
		logger.info("listCnt : " + listCnt);
		
		model.addAttribute("listData", listData);
		model.addAttribute("listCnt", listCnt);		
		
		logger.info("+ End " + className + ".tutTestList");

		return "tut/tutTestList";
	}
	
	/**
	 * 시험지 생성 (문제은행 추출)
	 */
	@RequestMapping("generateTest.do")
	@ResponseBody
	public Map<String, Object>  generateTest( Model model, 
						        			  @RequestParam Map<String, Object> paramMap, 
						        			  HttpServletRequest request,
						        			  HttpServletResponse response, 
						        			  HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".generateTest");
		logger.info("   - paramMap : " + paramMap);
		
		int lec_id = Integer.valueOf((String)paramMap.get("lec_id"));
		int generate_cnt = Integer.valueOf((String)paramMap.get("generate_cnt"));
		int res = 0;
		String result = "";
		String resultMsg = "";
		

		paramMap.put("lec_id", lec_id);
		paramMap.put("generate_cnt", generate_cnt);
		
		// 시험문제 생성
		List<TestDetailVo> listData = tutTestInfoService.generateTest(paramMap);
		int listCnt = listData.size();
		
		logger.info("listData : " + listData);
		logger.info("listCnt : " + listCnt);

		/*model.addAttribute("listData", listData);
		model.addAttribute("listCnt", listCnt);*/
		paramMap.put("listData", listData);
		paramMap.put("listCnt", listCnt);

		
		// 시험지 등록
		res = tutTestInfoService.registerTest(paramMap);
		if (res > 0) {
			result = "SUCCESS";
			resultMsg = "시험 문제가 출제되었습니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);			
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".generateTest");

		return resultMap;
	}
	
	/**
	 * 시험지 상세보기
	 */
	@RequestMapping("tutTestDetail.do")
	public String tutTestDetail( Model model, 
						         @RequestParam Map<String, Object> paramMap, 
						         HttpServletRequest request,
						         HttpServletResponse response, 
						         HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".tutTestDetail");
		logger.info("   - paramMap : " + paramMap);		
		
		List<TestDetailVo> listData = tutTestInfoService.tutTestDetail(paramMap);
		int listCnt = listData.size();
		logger.info("listCnt : " + listCnt);
		
		model.addAttribute("listData", listData);
		model.addAttribute("listCnt", listCnt);

		if (listCnt > 0) {
			model.addAttribute("lec_name", paramMap.get("lec_name"));
			model.addAttribute("test_id", paramMap.get("test_id"));
			model.addAttribute("test_name", listData.get(0).getTest_name());
		}		
		
		logger.info("+ End " + className + ".tutTestDetail");

		return "tut/tutTestDetail";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 시험응시 클릭 시 시험문제 항목 조회
	 */
	@RequestMapping("testItemList.do")	
	public String testItemList( Model model, 
						        @RequestParam Map<String, Object> paramMap, 
						        HttpServletRequest request,
						        HttpServletResponse response, 
						        HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".testItemList");
		logger.info("   - paramMap : " + paramMap);
		
		List<TestDetailVo> listData = myTestInfoService.testItemList(paramMap);
		int listCnt = myTestInfoService.testItemListCnt(paramMap);
		
		logger.info("listData : " + listData);
		logger.info("listCnt : " + listCnt);
		
		model.addAttribute("lec_id", paramMap.get("lec_id"));		
		model.addAttribute("lec_name", paramMap.get("lec_name"));
		model.addAttribute("test_id", paramMap.get("test_id"));
		model.addAttribute("tut_name", paramMap.get("tut_name"));
		model.addAttribute("listData", listData);
		model.addAttribute("listCnt", listCnt);
		
		logger.info("+ End " + className + ".testItemList");

		return "std/testItemList";
	}
	
	// 시험 응시(제출)
	@RequestMapping("/submitTest.do")
	@ResponseBody
	public Map<String, Object> submitTest( Model model, 
										   @RequestParam Map<String, Object> paramMap, 
										   HttpServletRequest request,
										   HttpServletResponse response, 
										   HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".submitTest");		
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("std_id", session.getAttribute("loginId"));
		
		int submitTest = myTestInfoService.submitTest(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if ( submitTest > 0 ) {
			resultMap.put("result", "SUCCESS");			
			resultMap.put("lec_id", paramMap.get("lec_id"));
			resultMap.put("test_id", paramMap.get("test_id"));
		} else {
			resultMap.put("result","FAIL");
		}
		
		logger.info("+ End " + className + ".submitTest");
		
		return resultMap;
	}
	
	/**
	 * 시험 결과 조회
	 */
	@RequestMapping("testResult.do")	
	public String testResult( Model model, 
						      @RequestParam Map<String, Object> paramMap, 
						      HttpServletRequest request,
						      HttpServletResponse response, 
						      HttpSession session ) throws Exception {
		
		logger.info("+ Start " + className + ".testResult");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("std_id", session.getAttribute("loginId"));
		
		
		TestUserVo data = myTestInfoService.searchTestUser(paramMap);	
		List<TestResultVo> dataList = myTestInfoService.searchTestResult(paramMap);
		int listCnt = myTestInfoService.searchTestResultCnt(paramMap);

		
		model.addAttribute("data", data);
		model.addAttribute("dataList", dataList);
		model.addAttribute("listCnt", listCnt);
		
		logger.info("+ End " + className + ".testResult");

		return "std/testResult";
	}
}