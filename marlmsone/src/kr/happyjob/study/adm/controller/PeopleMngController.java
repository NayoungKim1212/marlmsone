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

import kr.happyjob.study.adm.model.PeopleMngModel;
import kr.happyjob.study.adm.service.PeopleMngService;

@Controller
@RequestMapping("/adm/")
public class PeopleMngController {
	
	@Autowired
	PeopleMngService peopleMngService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	// 학생 관리	
	@RequestMapping("studentControl.do")
	public String tutor_lec_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		// 강의 리스트 가져오기
		List<PeopleMngModel> list_lec = peopleMngService.lec_list(paramMap);
		model.addAttribute("list_lec", list_lec);
		logger.info("lec_list:" + list_lec);
		
		return "adm/studentMng";
	}

	/* 강의 리스트 */
	@RequestMapping("plist_lec.do")
	public String lec_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
 
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); // 페이지
		int pageIndex = (currentPage - 1) * pageSize;
		String searchWord_lec = (String) paramMap.get("searchWord_lec");
		logger.info("+ Start " + className + ".plist_lec");
		logger.info("   - paramMap : " + paramMap);

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("searchWord_lec", searchWord_lec);

		logger.info("   - putparamMap : " + paramMap);

		// 강의 리스트 가져오기
		List<PeopleMngModel> list_lec = peopleMngService.lec_list(paramMap);
		model.addAttribute("list_lec", list_lec);
		logger.info("lec_list:" + list_lec);

		// 강의 목록 카운트 조회
		int totalCount = peopleMngService.countList_lec(paramMap);
		model.addAttribute("totalCnt_lec", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage_lec", currentPage);

		logger.info("   - totalCnt : " + totalCount);
		logger.info("   - pageSize : " + pageSize);
		logger.info("   - currentPage : " + currentPage);

		logger.info("+ End " + className + ".plist_lec");

		return "adm/lecList";
	}

	/* 학생 리스트 */
	@RequestMapping("list_std.do")
	public String std_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("   - paramMap : " + paramMap);

		String searchKey_std = (String) paramMap.get("searchKey_std");
		String searchWord_std = (String) paramMap.get("searchWord_std");
		int currentPage_std = Integer.parseInt((String) paramMap.get("currentPage_std")); // 현재
		
		logger.info("   - currentPage_std : " + currentPage_std);																			// 페이지
																					// 번호
		int pageSize_std = Integer.parseInt((String) paramMap.get("pageSize_std")); // 페이지																	// 사이즈
		int pageIndex_std = (currentPage_std - 1) * pageSize_std;
		
		logger.info("   - pageIndex_std : " + currentPage_std);	
		logger.info("+ Start " + className + ".list_std");
		logger.info("   - paramMap : " + paramMap);

		paramMap.put("pageIndex_std", pageIndex_std);
		paramMap.put("pageSize_std", pageSize_std);
		paramMap.put("searchWord_std", searchWord_std);

		// 학생 목록 조회
		List<PeopleMngModel> list_std = peopleMngService.std_list(paramMap);
		model.addAttribute("list_std", list_std);
		logger.info("   - list_std : " + list_std);

		// 학생 목록 카운트 조회
		int totalCount= peopleMngService.countList_std(paramMap);
	
		model.addAttribute("totalCnt_std", totalCount);
		model.addAttribute("pageSize_std", pageSize_std);
		model.addAttribute("currentPage_std", currentPage_std);

		logger.info("   - totalCnt : " + totalCount);
		logger.info("   - pageSize : " + pageSize_std);
		logger.info("   - currentPage : " + currentPage_std);

		logger.info("+ End " + className + ".list_std");
		
		return "adm/stdList";
	}
	
	// 학생 정보 단건 조회
	@RequestMapping("user_info.do")
	@ResponseBody
	public Map<String, Object> select_adv (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".user_info");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		PeopleMngModel user_model = peopleMngService.user_info(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("user_model", user_model);
		
		logger.info("+ End " + className + ".user_info");
		
		return resultMap;
	}
	
	//학생 강의 수강정보 리스트
	@RequestMapping("slist_lec.do")
	public String slec_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		String user_type=(String) paramMap.get("user_type");
		
		logger.info("   - putparamMap : " + paramMap);

		// 상세정보창 강의목록 가져오기
		if(user_type.equals("b")){ //강사
			List<PeopleMngModel> tlist_lec = peopleMngService.tlec_list(paramMap);
			model.addAttribute("tlist_lec", tlist_lec);
			logger.info("tlec_list:" + tlist_lec);
			int tut_lec_count = peopleMngService.tut_lec_count(paramMap);
			model.addAttribute("tut_lec_count", tut_lec_count);
			logger.info("tut_lec_count:" + tut_lec_count);
			return "adm/tutLecList";
			
		}else if(user_type.equals("a")){ //학생
			List<PeopleMngModel> slist_lec = peopleMngService.std_lec_info(paramMap);
			model.addAttribute("slist_lec", slist_lec);
			logger.info("slec_list:" + slist_lec);
			//강의 숫자 조회
			int std_lec_count = peopleMngService.std_lec_count(paramMap);
			model.addAttribute("std_lec_count", std_lec_count);
			logger.info("std_lec_count:" + std_lec_count);
			return "adm/stdLecList";
			
		}
				
		return "list_std.do";
	}
	
	//유저 정지
	@RequestMapping("ban_user.do")
	@ResponseBody
	public Map<String, Object> deleteComnDtlCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".ban_user");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "회원 탈퇴 되었습니다.";
		
		peopleMngService.ban_user(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".ban_user");
		
		return resultMap;
	}
	
	// 학생 수강 신청
	@RequestMapping("std_lec_reg.do")
	@ResponseBody
	public Map<String, Object> std_lec_reg(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".std_lec_reg");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "수강 신청 되었습니다.";
		
		peopleMngService.std_lec_reg(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".std_lec_reg");
		
		return resultMap;
	}
	
	// 학생 수강 신청 취소
	@RequestMapping("std_lec_del.do")
	@ResponseBody
	public Map<String, Object> std_lec_del(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".std_lec_del");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "수강 취소 되었습니다.";
		
		peopleMngService.std_lec_del(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".std_lec_del");
		
		return resultMap;
	}
	
	
	/* 강사 */
	
	/* 강사 관리 초기 화면*/
	@RequestMapping("tutorControl.do")
	public String tutor_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.info("   - paramMap : " + paramMap);
		return "adm/tutorMng";
	}
	
	/* 강사 리스트 */
	@RequestMapping("list_tut.do")
	public String tut_list(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("   - paramMap : " + paramMap);

		String searchKey = (String) paramMap.get("searchKey");
		String searchWord = (String) paramMap.get("searchWord");
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재
		logger.info("   - currentPage : " + currentPage);																			// 페이지
																					// 번호
		int pageSize= Integer.parseInt((String) paramMap.get("pageSize")); // 페이지
																			// 사이즈
		int pageIndex = (currentPage - 1) * pageSize;
		logger.info("   - pageIndex : " + pageIndex);	
		logger.info("+ Start " + className + ".list_tut");
		logger.info("   - paramMap : " + paramMap);

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("searchWord", searchWord);

		// 강사 목록 조회
		List<PeopleMngModel> list_tut = peopleMngService.tut_list(paramMap);
		model.addAttribute("list_tut", list_tut);
		logger.info("   - list_tut : " + list_tut);

		// 강사 목록 카운트 조회
		int totalCount = peopleMngService.countList_tut(paramMap);
		model.addAttribute("totalCnt", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage", currentPage);

		logger.info("   - totalCnt : " + totalCount);
		logger.info("   - pageSize : " + pageSize);
		logger.info("   - currentPage : " + currentPage);

		logger.info("+ End " + className + ".list_tut");
	
	
		return "adm/tutList";	
		
	}
	
	// 강사 승인
	@RequestMapping("apv_tut.do")
	@ResponseBody
	public Map<String, Object> apv_tut(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".apv_tut");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "강사 승인 되었습니다.";
		
		peopleMngService.apv_tut(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".apv_tut");
		
		return resultMap;
	}


}
