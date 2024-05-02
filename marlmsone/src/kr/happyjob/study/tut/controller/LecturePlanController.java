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

import kr.happyjob.study.system.service.ComnCodService;
import kr.happyjob.study.tut.model.LecturePlanModel;
import kr.happyjob.study.tut.model.LectureRoomModel;
import kr.happyjob.study.tut.service.LecturePlanService;
@Controller
@RequestMapping("/tut")
public class LecturePlanController {
	
	@Autowired
	LecturePlanService lecturePlanService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 강의계획서 초기 화면
	 */
	@RequestMapping("lecturePlan.do")
	public String initLecture(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		paramMap.put("tutor_id", session.getAttribute("loginId"));

		// 강의 리스트 가져오기
		List<LecturePlanModel> lecList = lecturePlanService.tutorLecList(paramMap);
		model.addAttribute("lecList", lecList);
		logger.info("lecList:" + lecList);
		
		// 강의 분류명 가져오기
		List<LecturePlanModel> typeList = lecturePlanService.lecTypeList(paramMap);
		model.addAttribute("typeList", typeList);
		logger.info("typeList:" + typeList);
		
		//강의실 리스트가져오기
		List<LectureRoomModel> lecRoom = lecturePlanService.room_name(paramMap);
		model.addAttribute("lecRoom", lecRoom);
		return "tut/lecNotice";
	}
	
	/**
	 * 강의 목록 조회
	 */
	@RequestMapping("fLectureList.do")
	public String fLectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		paramMap.put("tutor_id", session.getAttribute("loginId"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); 
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); 
		int pageIndex = (currentPage - 1) * pageSize;
		String searchWord = (String) paramMap.get("searchWord");
		
		logger.info("+ Start " + className + ".fLectureList");
		logger.info("   - paramMap : " + paramMap);

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("searchWord_lec", searchWord);

		logger.info("   - putparamMap : " + paramMap);

		// 강의 리스트 가져오기
		List<LecturePlanModel> lecList = lecturePlanService.tutorLecList(paramMap);
		model.addAttribute("lecList", lecList);
		logger.info("lecList:" + lecList);

		// 강의 목록 카운트 조회
		int totalCount = lecturePlanService.countLecList(paramMap);
		model.addAttribute("totalCnt", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", currentPage);
		
		logger.info("lecList:" + lecList);

		logger.info("+ End " + className + ".fLectureList");


		return "/tut/lecNoticeList";
	}
	
	// 모달 강의정보
	@RequestMapping("fLecInfo.do")
	@ResponseBody
	public Map<String, Object> select_adv(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".fLecInfo");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 모달창 강의정보 출력
		LecturePlanModel lec_info = lecturePlanService.plan_one(paramMap);
		
		//주차 계획 리스트 출력
		List<LecturePlanModel> week_plan=lecturePlanService.week_list(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("lec_info", lec_info);
		resultMap.put("week_plan", week_plan);

		logger.info("+ End " + className + ".fLecInfo");

		return resultMap;
	}

	//계획서 저장
	@RequestMapping("savePlan.do")
	@ResponseBody
	public Map<String, Object> save_advice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		logger.info("+ Start " + className + ".savePlan");
		logger.info("   - paramMap : " + paramMap);
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		lecturePlanService.plan_register(paramMap);
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".savePlan");
		
		return resultMap;
	}
	
	//주간계획 저장
	@RequestMapping("saveWeekplan.do")
	@ResponseBody
	public Map<String, Object> week_plan_insert(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@RequestParam(value="week[]") List<String> week,@RequestParam(value="learn_goal[]") List<String> learn_goal,@RequestParam(value="learn_con[]") List<String> learn_con) throws Exception {
		
		logger.info("week:"+week);
		logger.info("learn_goal:"+learn_goal);
		logger.info("learn_con:"+learn_con);
	
		for (int i = 0; i < week.size(); i++) {
			paramMap.put("week",week.get(i));
			paramMap.put("learn_goal",learn_goal.get(i));
			paramMap.put("learn_con",learn_con.get(i));
			
			//체크해서 값이 없으면 insert 있으면 수정
			if(lecturePlanService.chk_week(paramMap)>0){
				lecturePlanService.week_up(paramMap);
			}else{
				lecturePlanService.week_register(paramMap);
			}
		}
		
		logger.info("+ Start " + className + ".saveWeekplan");
		logger.info("   - paramMap : " + paramMap);
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveWeekplan");
		
		return resultMap;
	}
	
	//주간 계획삭제
	@RequestMapping("delWeekPlan.do")
	@ResponseBody
	public Map<String, Object> deleteComnDtlCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".delWeekPlan");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		lecturePlanService.week_del(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".delWeekPlan");
		
		return resultMap;
	}
}


