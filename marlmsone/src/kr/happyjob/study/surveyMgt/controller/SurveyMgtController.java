package kr.happyjob.study.surveyMgt.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import javax.websocket.server.PathParam;

//import org.apache.catalina.util.RequestUtil;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.surveyMgt.dao.SurveyMgtDao;
import kr.happyjob.study.surveyMgt.domain.LecSearchItem;
import kr.happyjob.study.surveyMgt.domain.LecSurveyPageResolver;
import kr.happyjob.study.surveyMgt.model.SurveyMgtVo;
import kr.happyjob.study.surveyMgt.service.SrvyMgtService;

@Controller
@RequestMapping("/adm")
public class SurveyMgtController {
	
	@Autowired
	SurveyMgtDao surveyMgtDao;
	@Autowired
	SrvyMgtService srvyMgtService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();
	
	/**
	 * 설문조사(관리자) 초기화면 및 목록 모델에 담아 뿌리기
	 */
	@RequestMapping("/a_surveyControl.do")
	public String surveyMgt(LecSearchItem lsc, Model model, @RequestParam Map<String, Object> paramMap,
	                         HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
	    logger.info("+ Start " + className + ".serveyMgt");
	    logger.info("   - paramMap : " + paramMap);
	       
	    // 반환할 데이터를 담을 Map 객체
	    Map<String, Object> result = new HashMap<String, Object>();
	    
	    // 설문조사 리스트를 받아 모델에 담기
	    List<SurveyMgtVo> srvyList = srvyMgtService.selectSrvyMgtList(paramMap);
	    int totalCnt = srvyMgtService.srvyMgtCnt(paramMap);
	    
	    LecSurveyPageResolver lecSrvyPageResolver = new LecSurveyPageResolver(totalCnt, lsc);
	    
	    // 리스트에서 페이지에 맞는 데이터 추출
	    int startIndex = Math.max((lsc.getPage() - 1) * lsc.getPageSize(), 0);
	    int endIndex = Math.min(startIndex + lsc.getPageSize(), srvyList.size());
	    List<SurveyMgtVo> list = srvyList.subList(startIndex, endIndex);
	    
	    model.addAttribute("list", list);
	    model.addAttribute("totalCnt", totalCnt);
	    model.addAttribute("lpr", lecSrvyPageResolver);
	    
	    System.out.println("==========totalCnt:: " + totalCnt);
	    
	    // session에서 ID 가져오고 Map에 담기
	    String loginID = (String) session.getAttribute("loginID");
	    paramMap.put("loginID", loginID);

	    logger.info("+ End " + className + ".serveyMgt");
	    
	    LocalDateTime dateTime = LocalDateTime.now();
	    System.out.println("dateTime :::::::::::::::::::::::::::::::::::::" + dateTime);
	    
	    return "surveyMgt/surveyMgt";
	}
	
	/** 
	 * 상세목록 조회하기
	 * */
	@RequestMapping("/detailSrvyList")
	@ResponseBody
	public Map<String, Object> detailSrvy(Model model, @RequestParam Map<String, Object> paramMap,
													@RequestParam("lec_id") String lec_id,
													@RequestParam("lec_name") String lec_name, @RequestParam("tutor_name") String tutor_name,
													HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".detailSrvyList");
		logger.info("   - paramMap : " + paramMap);
		
        // JSON 응답 생성
        Map<String, Object> resultMap = new HashMap<>();
        
        List<SurveyMgtVo> detailSrvyList = srvyMgtService.detailSrvyList(paramMap);
        
        resultMap.put("detailSrvyList", detailSrvyList);
        
        if(detailSrvyList.size() > 0) {
	        for( SurveyMgtVo a : detailSrvyList) {
	        	System.out.println(a.getLec_id());
	        }
        }
        
        int detailTotalCnt = srvyMgtService.detailSrvyCnt(paramMap);
        resultMap.put("detailTotalCnt", detailTotalCnt);

        logger.info("+ End " + className + ".detailSrvyList");
        return resultMap;
            
    }
	
	@RequestMapping("/detailTutorNmSrvyList")
	@ResponseBody
	public Map<String, Object> detailNmSrvy(LecSearchItem lsc, Model model, @RequestParam Map<String, Object> paramMap,
													@RequestParam("lec_id") String lec_id,
													@RequestParam("lec_name") String lec_name, @RequestParam("tutor_name") String tutor_name,
													HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".detailSrvyNmList");
		logger.info("   - paramMap : " + paramMap);
		
		
		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int cpage = Integer.valueOf((String) paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
		
		int startpos = (cpage-1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		
        // JSON 응답 생성
        Map<String, Object> resultMap = new HashMap<>();
        
        List<SurveyMgtVo> detailSrvyTutorNmList = srvyMgtService.detailSrvyTutorNmList(paramMap);
        resultMap.put("detailSrvyTutorNmList", detailSrvyTutorNmList);
        
        if(detailSrvyTutorNmList.size() > 0) {
	        for( SurveyMgtVo a : detailSrvyTutorNmList) {
	        	System.out.println(a.getLec_id());
	        }
        }
        
        
        
        int detailNmTotalCnt = srvyMgtService.detailTutorNameSrvyCnt(paramMap);      
        
        resultMap.put("detailNmTotalCnt", detailNmTotalCnt);

        logger.info("+ End " + className + ".detailSrvyNmList");
        return resultMap;
            
    }
	
	@RequestMapping("/surveyResult")
	@ResponseBody
	public Map<String, Object> surveyResult(Model model, @RequestParam Map<String, Object> paramMap,
									HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
	    logger.info("+ Start " + className + ".surveyResult");
	    logger.info("   - paramMap : " + paramMap);

	    int lec_id = Integer.parseInt(paramMap.get("lec_id").toString());
		
	    List<SurveyMgtVo> resultNumList = srvyMgtService.srvyResult(paramMap);
		List<SurveyMgtVo> resultList = srvyMgtService.srvyResultLast(paramMap);
		
	    logger.info("+ End " + className + ".surveyResult");
	    
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    resultMap.put("resultNumList", resultNumList);
	    resultMap.put("resultList", resultList);
 		
		return resultMap;
	}
	
	
//	@GetMapping("/holidayInfoAPI")
//	public ResponseEntity holidayInfoAPI(@PathParam("year") String year, @PathParam("month") String month) {
//	    ArrayList<HashMap> responseHolidayArr = new ArrayList<>();
//	    DateAPI dateAPI = new DateAPI();
//	    
//	    // 공휴일이 발견된 횟수 저장
//	    int holidayCnt = 0;
//	    
//	    for (int solYear = 2024; solYear <= 2025; solYear++) {
//	        for (int solMonth = 1; solMonth <= 12; solMonth++) {
//	            try {
//	                String solYearStr = String.valueOf(solYear);
//	                String solMonthStr = String.valueOf(solMonth);
//
//	                Map<String, Object> holidayMap = dateAPI.holidayInfoAPI(solYearStr, solMonthStr);
//	                Map<String, Object> response = (Map<String, Object>) holidayMap.get("response");
//	                Map<String, Object> body = (Map<String, Object>) response.get("body");
//
//	                int totalCount = (int) body.get("totalCount");
//
//	                if (totalCount <= 0) {
//	                    System.out.println("공휴일 없음");
//	                    System.out.println("body = " + body);
//	                } else if (totalCount == 1) {
//	                    HashMap<String, Object> items = (HashMap<String, Object>) body.get("items");
//	                    HashMap<String, Object> item = (HashMap<String, Object>) items.get("item");
//	                    if("Y".equals(item.get("isHoliday"))) {
//		                    responseHolidayArr.add(item);
//		                    System.out.println("item = " + item);	                    	
//	                    	holidayCnt++;
//	                    }
//	                } else {
//	                    HashMap<String, Object> items = (HashMap<String, Object>) body.get("items");
//	                    ArrayList<HashMap<String, Object>> item = (ArrayList<HashMap<String, Object>>) items.get("item");
//	                    for (HashMap<String, Object> itemMap : item) {
//	                    	if("Y".equals(itemMap.get("isHoliday"))) {
//		                        System.out.println("itemMap = " + itemMap);
//		                        responseHolidayArr.add(itemMap);	                    		
//		                        holidayCnt++;
//	                    	}
//	                    }
//	                }
//	            } catch (Exception e) {
//	                e.printStackTrace();
//	            }
//	        }
//	    }
//	    System.out.println("총 공휴일 개수:: " + holidayCnt);
//	    return new ResponseEntity<>(responseHolidayArr, HttpStatus.OK);
//	}
}
