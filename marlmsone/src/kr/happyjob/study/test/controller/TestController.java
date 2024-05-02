package kr.happyjob.study.test.controller;

import java.util.HashMap;

import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.bouncycastle.asn1.dvcs.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.test.model.TestModel;
import kr.happyjob.study.test.service.TestService;
import kr.happyjob.study.sample.service.SampleComnCodService;

@Controller
@RequestMapping("/tut/")
public class TestController {

	@Autowired
	TestService testService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/*
	 * 시험관리 초기화면
	 */
	@RequestMapping("testControl.do")
	public String testControl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className);
		logger.info("   - paramMap : " + paramMap);


		// 시험분류 목록 출력
		List<TestModel> lectureListData = testService.lectureListData(paramMap);

		model.addAttribute("lecList",lectureListData);
		
		logger.info("+ End " + className);

		return "tut/testControl";
	}

	/*
	 * 시험관리 목록 가져오기
	 */
	@RequestMapping("testList.do")
	public String testList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className);
		logger.info("   - paramMap : " + paramMap);
		
		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int cpage = Integer.valueOf((String) paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));

		int startpos = (cpage - 1) * pagesize;

		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);

		List<TestModel> listdata = testService.getListData(paramMap);
		int listcnt = testService.testListCnt(paramMap);
		model.addAttribute("listdata", listdata);
		model.addAttribute("listcnt", listcnt);
		
		List<TestModel> lectureListData = testService.lectureListData(paramMap);
		model.addAttribute("lectureListData", lectureListData);
		
		logger.info("+ End " + className + ".testlist");

		return "tut/testList";

	}
		
	
	

	/*
	 * 시험 문제 등록 저장/수정하기
	 */
	@RequestMapping("testSave.do")
	@ResponseBody
	public Map<String, Object> testSave(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className);
		logger.info("   -save paramMap : " + paramMap);

		

		String action = (String) paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		int que_ans = Integer.parseInt(String.valueOf(paramMap.get("que_ans")));
		int lec_type_id = Integer.parseInt(String.valueOf(paramMap.get("lec_type_id")));
		
		paramMap.put("que_ans", que_ans);
		paramMap.put("lec_type_id", lec_type_id);
		
		logger.info("que_ans"+  que_ans);
		
		int resultcode = 0;
		
		// 신규 등록일 때
	    if ("I".equals(action)) {
	    	resultcode = testService.saveActive(paramMap);
	        logger.info(" ====resultMap 결과값? : " + resultcode);
	        //return resultMap;
	    }
	    // 수정일 때
	    else if ("U".equals(action)) {
		  if (paramMap.get("que_id") != null && !((String) paramMap.get("que_id")).isEmpty()) {
	          int que_id = Integer.parseInt(String.valueOf(paramMap.get("que_id")));
	          paramMap.put("que_id", que_id);
	          resultcode = testService.testModify(paramMap);
	         
	          logger.info(" ====수정일때 resultMap 결과값? : " + resultcode);
	    }else {
            resultcode = -1; // que_id가 비어 있으면 실패로 처리
            logger.error("que_id가 없습니다.");
        }
	    
	    logger.info("+ End " + className);
	    }
	    // 예외 처리: action 값이 I 또는 U가 아닌 경우
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    resultMap.put("result", resultcode);
	    
	    if(resultcode < 0) {
	    	//resultMap.put("result", "FAIL");
		    resultMap.put("resultMsg", "잘못된 요청입니다.");
	    } else {
		    resultMap.put("resultMsg", "저장되었습니다");
	    }
	    
	    
	    return resultMap;
	}
		
		

	/*
	 * 시험 문제 수정조회
	 * 
	 */
	@RequestMapping("testModifyList.do")
	@ResponseBody
	public Map<String,Object>testModifyList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className);
		logger.info("   -modify paramMap : " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<>();
		TestModel selinfo = testService.testModifyList(paramMap);
		
		resultMap.put("selinfo", selinfo);
		
		logger.info("+ End " + className);
		
		return resultMap;
	}

	/*
	 * 시험 문제 등록 비활성화하기
	 */
	@RequestMapping("testDeactivate.do")
	@ResponseBody
	public Map<String, Object> testDeactivate(Model model, @RequestParam Map<String,Object> requestData,
	        HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	    
		StringTokenizer st = new StringTokenizer((String)requestData.get("selectedItems"), " ");
		
		String result = "SUCCESS";
		String deactResultMsg = "수정 되었습니다.";
		
		Map<String, Integer> resultMap = new HashMap<>();;
		while(st.hasMoreElements()){
			resultMap.put("que_id", Integer.parseInt(st.nextToken()));
			int deletecnt = testService.testDeactivate(resultMap);
		}
		
		requestData.put("result", result);
	    requestData.put("deactResultMsg", deactResultMsg);
	    
	    return requestData;
	}
}

