package kr.happyjob.study.tut.controller;

import java.util.Enumeration;
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

import kr.happyjob.study.tut.model.LectureStudentDto;
import kr.happyjob.study.tut.model.TutorLearningMaterials;
import kr.happyjob.study.tut.model.TutorLectureDto;
import kr.happyjob.study.tut.service.LectureStudentService;
import kr.happyjob.study.tut.service.TutorLearnMaterialsService;

@Controller
@RequestMapping("/tut/")
public class LectureStudentController {
	
		// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();
		
		@Autowired
		LectureStudentService lectureStudentService;
	
		// 수강생 정보 페이지
		@RequestMapping("lectureStudentInfo.do")
		public String lectureStudentInfoPage(Model model, HttpSession session) throws Exception {
			
			logger.info("=====START lectureStudentInfoPage");
			
			model.addAttribute("loginId", session.getAttribute("loginId"));
			
			logger.info("=====END lectureStudentInfoPage");
		
	        return "tut/lectureStudentInfo";
		}
		
		// 강사 강의 리스트
		@RequestMapping("tutorLectureList")
		public String getTutorLectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
					
			logger.info("=====START getTutorLectureList");
			logger.info("=====학습 자료 리스트 " + className + ".getTutorLectureList");
					
			Enumeration<String> attributeNames = session.getAttributeNames();
			while(attributeNames.hasMoreElements()) {
				String attributeName = attributeNames.nextElement();
				Object attributeValue = session.getAttribute(attributeName);
				System.out.println("세션 속성 이름 : " + attributeName + ", 값: " + attributeValue);
			}
					
			logger.info("session ID 값 : " + session.getAttribute("loginId"));
			model.addAttribute("loginId", session.getAttribute("loginId"));
			
			paramMap.put("tutorId", (String) session.getAttribute("loginId"));
					
			int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); 
			int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); 
			int pageIndex = (currentPage - 1) * pageSize;
					
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
					
			logger.info("   - putparamMap : " + paramMap);
					
			List<TutorLectureDto> lectureList = lectureStudentService.getLectureList(paramMap);
					
			int tutorLectureTotalCount = lectureStudentService.tutorLectureTotalCount(paramMap);
					
			logger.info("learningMatList TotalCount = " +  tutorLectureTotalCount);
					
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("totalCount", tutorLectureTotalCount);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("lectureList", lectureList);
				
			logger.info("=====END getTutorLectureList");
					
			return "/tut/tutorLectureList";
		}
		
		// 강의 상세자료
		@RequestMapping("tutorLectureDetail")
		@ResponseBody
		public Map<String, Object> getTutorLectureDetail(@RequestParam Map<String, Object> paramMap) throws Exception {
			logger.info("=====START getTutorLectureDetail");
			logger.info("===== paramData : " + paramMap);
			
			TutorLectureDto detailTutorLecture = lectureStudentService.getDetailTutorLecture(paramMap);
			
			Map<String, Object> result = new HashMap<>();
			result.put("detailTutorLecture", detailTutorLecture);
			
			logger.info("=====END getTutorLectureDetail");
			
			return result;
		}
		
		// 수강생 리스트
		@RequestMapping("LectureStudentList")
		public String getLectureStudentList(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
					
			logger.info("=====START getLectureStudentList");
			logger.info("=====수강생 리스트 " + className + ".getLectureStudentList");
				
			int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); 
			int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); 
			int pageIndex = (currentPage - 1) * pageSize;
					
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			logger.info("searchKey : " + paramMap.get("searchKey"));
			logger.info("studentValue : " + paramMap.get("studentValue"));
							
			List<LectureStudentDto> lectureStudentList = lectureStudentService.getLectureStudentList(paramMap);
					
			int LectureStudentTotalCount = lectureStudentService.lectureStudentTotalCount(paramMap);
					
			logger.info("learningMatList TotalCount = " +  LectureStudentTotalCount);
					
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("totalCount", LectureStudentTotalCount);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("lectureStudentList", lectureStudentList);
			model.addAttribute("lectureValue", paramMap.get("lectureValue"));
				
			logger.info("=====END getTutorLectureList");
					
			return "/tut/lectureStudentList";
		}
		
		// 수강생 상세자료
		@RequestMapping("lectureStudentDetail")
		@ResponseBody
		public Map<String, Object> getLectureStudentDetail(@RequestParam Map<String, Object> paramMap) throws Exception {
			logger.info("=====START getLectureStudentDetail");
			logger.info("===== paramData : " + paramMap);
			
			List<LectureStudentDto> detailLectureStudent = lectureStudentService.getDetailLectureStudent(paramMap);
			
			Map<String, Object> result = new HashMap<>();
			result.put("detailTutorLecture", detailLectureStudent);
			
			logger.info("=====END getLectureStudentDetail");
			
			return result;
		}
		
		@RequestMapping("lectureStudentApprove")
		@ResponseBody
		public Boolean lectureStudentApprove(@RequestParam Map<String, Object> paramMap) throws Exception {
			logger.info("=====START lectureStudentApprove");
			logger.info("===== paramData : " + paramMap);
			
			Boolean status = false;
			
			status = lectureStudentService.approveLectureStudent(paramMap);
			
			logger.info("=====END lectureStudentApprove");
			
			return status;
		}
		
		@RequestMapping("lectureStudentCancle")
		@ResponseBody
		public Boolean lectureStudentCancle(@RequestParam Map<String, Object> paramMap) throws Exception {
			logger.info("=====START lectureStudentCancle");
			logger.info("===== paramData : " + paramMap);
			
			Boolean status = false;
			
			status = lectureStudentService.cancleLectureStudent(paramMap);
			
			logger.info("=====END lectureStudentCancle");
			
			return status;
		}
	}