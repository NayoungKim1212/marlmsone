package kr.happyjob.study.adm.controller;

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

import kr.happyjob.study.adm.model.CourseSizeModel;
import kr.happyjob.study.adm.model.PeopleMngModel;
import kr.happyjob.study.adm.service.CourseSizeService;

@Controller
@RequestMapping("/adm/")
public class CourseSizeController {
	
	@Autowired
	CourseSizeService courseSizeService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	/**
	 * 수강인원 초기화면
	 */
	@RequestMapping("courseSize.do")
	public String courseSize(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".courseSize");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".courseSize");

		return "adm/courseSize";
	}
	
	/* 강의 목록 조회 */
	@RequestMapping("selectCourse.do")
	public String selectCourse(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectCourse");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); // 페이지
		int pageIndex = (currentPage - 1) * pageSize;
		String searchWord = (String) paramMap.get("searchWord");
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("searchWord", searchWord);
		
		// 강의 리스트 가져오기
		List<CourseSizeModel> lecList = courseSizeService.lecList(paramMap);
		model.addAttribute("lecList", lecList);
		logger.info("lecList:" + lecList);

		// 강의 목록 카운트 조회
		int totalCnt = courseSizeService.lecListCount(paramMap);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", currentPage);

		logger.info("   - totalCnt : " + totalCnt);
		logger.info("   - pageSize : " + pageSize);
		logger.info("   - currentPage : " + currentPage);
		logger.info("+ End " + className + ".selectCourse");

		return "adm/crsSizeList";
	}
	
	/* 수강인원 단건 조회 */
	@RequestMapping("showChart.do")
	@ResponseBody
	public Map<String, Object> showChart(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".showChart");
		logger.info("   - paramMap : " + paramMap);
		
		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		List<CourseSizeModel> courseSizeModel = courseSizeService.selectSizeInfo(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("courseSizeModel", courseSizeModel);
		
		logger.info("+ End " + className + ".showChart");

		return resultMap;
	}

}
