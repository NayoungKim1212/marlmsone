package kr.happyjob.study.surveyMgt.controller;

import java.time.LocalDateTime;
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

import kr.happyjob.study.surveyMgt.dao.SurveyMgtDao;
import kr.happyjob.study.surveyMgt.domain.LecSearchItem;
import kr.happyjob.study.surveyMgt.domain.LecSurveyPageResolver;
import kr.happyjob.study.surveyMgt.model.SurveyMgtVo;
import kr.happyjob.study.surveyMgt.service.SrvyMgtService;


@Controller
@RequestMapping("/tut")
public class TutorSurveyMgt {
	
	@Autowired
	SurveyMgtDao surveyMgtDao;
	@Autowired
	SrvyMgtService srvyMgtService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();
	
	/**
	 * 설문조사(강사) 초기화면 및 목록 모델에 담아 뿌리기
	 */
	@RequestMapping("/t_surveyControl.do")
	public String tutorSurveyMgt(LecSearchItem lsc, Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		logger.info("+ Start " + className + ".serveyMgt");
		logger.info("   - paramMap : " + paramMap);
		
		// 반환할 데이터를 담을 Map 객체
		Map<String, Object> result = new HashMap<String, Object>();
		
		paramMap.put("loginId", (String) session.getAttribute("loginId"));
		
		// 설문조사 리스트를 받아 모델에 담기
		List<SurveyMgtVo> srvyList = srvyMgtService.selectSrvyMgtTutorList(paramMap);
		int totalCnt = srvyMgtService.srvyMgtTutorCnt(paramMap);
		
		logger.info("session ID 값 : " + session.getAttribute("loginId"));
	
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
		
		return "surveyMgt/surveyMgtTutor";
	}

}
