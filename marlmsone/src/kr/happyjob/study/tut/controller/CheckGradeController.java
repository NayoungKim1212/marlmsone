package kr.happyjob.study.tut.controller;

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

import kr.happyjob.study.tut.model.CheckGradesModel;
import kr.happyjob.study.tut.service.CheckGradeService;

@Controller
@RequestMapping("/tut/")
public class CheckGradeController {
	
		@Autowired
		CheckGradeService checkGradeService;
	
		// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();
			
		
		/**
		 * 성적관리  초기 화면
		 */
		@RequestMapping("checkGrades.do")
		public String checkGrades(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			paramMap.put("tutor_id", session.getAttribute("loginId"));

			logger.info("+ Start " + className + ".checkGrades");
			logger.info("   - paramMap : " + paramMap);
			
			//강의명 리스트 가져오기 
			List<CheckGradesModel>lecList = checkGradeService.lecList(paramMap);
			model.addAttribute("lecList", lecList);
			logger.info("lecList:" + lecList);
			
			//시험명 리스트 가져오기 
			List<CheckGradesModel>testNameList = checkGradeService.testNameList(paramMap);
			model.addAttribute("testNameList", testNameList);
			logger.info("testNameList" + testNameList);
			
			logger.info("===== 성적 관리  페이지 =====");
		
		return "tut/checkGrades";
		}
		
		

		/**
		 * 성적관리 목록 리스트
		 */
		@RequestMapping("checkGradesList.do")
		public String checkGradesList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
		    
			paramMap.put("tutor_id", session.getAttribute("loginId"));

			logger.info("+ Start " + className + ".checkGradesList");
			logger.info(" - paramMap : " + paramMap);
			int cpage = Integer.valueOf((String) paramMap.get("cpage"));
			int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));

			int startpos = (cpage - 1) * pagesize;

			paramMap.put("startpos", startpos);
			paramMap.put("pagesize", pagesize);
			
			logger.info("   - putparamMap : " + paramMap);
		
			//시험목록 조회
			List<CheckGradesModel> checkgradeList = checkGradeService.checkgradeList(paramMap);
			
			//시험목록카운트 조회
			int totalGradeCnt = checkGradeService.totalGradeCnt(paramMap);
			
			model.addAttribute("checkgradeList", checkgradeList);
			model.addAttribute("totalGradeCnt", totalGradeCnt);
			
			logger.info("+ End " + className + ".checkGradesList");
			
			return "tut/checkGradesList";
		}
		
		
		/*응시자 시험 결과 조회*/
		@RequestMapping("checkStdList.do")
		public String checkStdList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
		
			logger.info("+ Start " + className + ".checkStdList");
			logger.info(" - paramMap : " + paramMap);
			
			int cpage = Integer.valueOf((String) paramMap.get("cpage"));
			int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));

			int startpos = (cpage - 1) * pagesize;

			paramMap.put("startpos", startpos);
			paramMap.put("pagesize", pagesize);
			
			//응시자 목록 조회
			List<CheckGradesModel> checkStdList = checkGradeService.checkStdList(paramMap);
			model.addAttribute("checkStdList", checkStdList);
			
			//응시자 수 
			int checkStdCount = checkGradeService.checkStdCount(paramMap);
			model.addAttribute("checkStdCount", checkStdCount);
			
			logger.info("+ End " + className + ".checkStdList");
		
			return "tut/checkGradesStd";
		}
		
		
}

