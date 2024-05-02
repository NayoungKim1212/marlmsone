package kr.happyjob.study.register.controller;

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

import kr.happyjob.study.register.model.RegisterListModel;
import kr.happyjob.study.register.service.RegisterListService;
import kr.happyjob.study.tut.model.LecturePlanModel;

@Controller
@RequestMapping("/register/")
public class RegisterController {

	@Autowired
	RegisterListService registerListService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 강의관리 초기화면
	 */
	@RequestMapping("registerListControl.do") // url 이름이랑 메소드 이름 동일하게 setting
	public String registerList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("===== 강의 목록  페이지 =====");

		paramMap.put("tutor_id", session.getAttribute("loginId"));

		// 강의실 리스트 가져오기
		List<RegisterListModel> lecrmList = registerListService.lecrmList(paramMap);
		model.addAttribute("lecrmList", lecrmList);

		// 강사 리스트 가져오기
		List<RegisterListModel> tutList = registerListService.tutList(paramMap);
		model.addAttribute("tutList", tutList);
		
		// 강의 분류명 가져오기
		List<RegisterListModel> typeList = registerListService.lecTypeList(paramMap);
		model.addAttribute("typeList", typeList);
		logger.info("typeList:" + typeList);

		return "register/register";
	}

	/**
	 * 강의목록 리스트
	 */
	@RequestMapping("listLec.do")
	public String listLec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".registerList");
		logger.info(" - paramMap : " + paramMap);

		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));

		int startpos = (currentPage - 1) * pageSize;

		paramMap.put("startpos", startpos);
		paramMap.put("pageSize", pageSize);

		// 목록 조회
		List<RegisterListModel> lec_List = registerListService.lec_List(paramMap);

		// 목록 조회 카운트
		int lec_Total = registerListService.lec_Total(paramMap);

		System.out.println("lec_List : " + lec_List);
		System.out.println("lec_Total : " + lec_Total);

		model.addAttribute("lec_List", lec_List);
		model.addAttribute("lec_Total", lec_Total);

		logger.info("+ End " + className + ".registerList");
		logger.info("lec_List : " + lec_List);

		return "register/registerList";
	}
	
	/* 학생 목록 조회 */
	@RequestMapping("stdList.do")
	public String stdList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".stdList");
		logger.info(" - paramMap : " + paramMap);

		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));

		int startpos = (currentPage - 1) * pageSize;

		paramMap.put("startpos", startpos);
		paramMap.put("pageSize", pageSize);

		// 목록 조회
		List<RegisterListModel> stdList = registerListService.stdList(paramMap);

		// 목록 조회 카운트
		int std_Total = registerListService.std_Total(paramMap);

		System.out.println("stdList : " + stdList);
		System.out.println("std_Total : " + std_Total);

		model.addAttribute("stdList", stdList);
		model.addAttribute("std_Total", std_Total);

		logger.info("+ End " + className + ".registerList");
		logger.info("stdList : " + stdList);

		return "register/stdList";

	}
	
	// 모달 강의정보
	@RequestMapping("lecInfo.do")
	@ResponseBody
	public Map<String, Object> selectLecInfo(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".selectLecInfo");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		String action = (String)paramMap.get("action");
		
		// 모달창 강의정보 출력
		RegisterListModel lec_info = registerListService.lec_info(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("lec_info", lec_info);

		logger.info("lec_info : " + lec_info);
		logger.info("+ End " + className + ".selectLecInfo");

		return resultMap;
	}

	/* 강의 등록 */
	@RequestMapping("saveRegister.do")
	@ResponseBody
	public Map<String, Object> registerListControlSave(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".registerListControlSave");
		logger.info(" - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String max_pnum = (String)paramMap.get("max_pnum");
		String process_day = (String)paramMap.get("process_day");
		String lecrm_id = (String)paramMap.get("lecrm_id");
		
		int lecInfo = 0;
		
		if(action.equals("I")) {
			if(max_pnum.equals("")) {
				paramMap.put("max_pnum", null);	
			}
			if(process_day.equals("")) paramMap.put("process_day", null);
			if(lecrm_id.equals("")) paramMap.put("lecrm_id", null);
			System.out.println("lecrm_id : " + lecrm_id);
			lecInfo = registerListService.registerListControlSave(paramMap);
			System.out.println("lecInfo : " + lecInfo);
		} 
		if(action.equals("U")){
			System.out.println("수정action : ===" + action);
			lecInfo = registerListService.registerListControlUpdate(paramMap);
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", "SUCCESS");
		resultMap.put("resultMsg", "등록 되었습니다.");
		resultMap.put("lecInfo", lecInfo);

		
		logger.info("+ End " + className + ".registerListControlSave");

		return resultMap;
	}
	
	//강의 삭제
	@RequestMapping("delRegister.do")
	@ResponseBody
	public Map<String, Object> delRegister(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".delRegister");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		System.out.println("삭제  action == " + action);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";		
		
		registerListService.delRegister(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".delRegister");
		
		return resultMap;
	}
	
}
