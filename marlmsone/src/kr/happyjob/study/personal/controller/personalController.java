package kr.happyjob.study.personal.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
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

import org.apache.commons.io.FileUtils;

import kr.happyjob.study.personal.model.PersonalVO;
import kr.happyjob.study.personal.service.PersonalService;

@Controller
@RequestMapping("/personal/")
public class personalController {
	
	@Autowired
	PersonalService personalService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	/**
	 * 마이 페이지 초기화면
	 */
	@RequestMapping("personalInfo.do")
	public String personalInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".personalInfo");
		logger.info("   - paramMap : " + paramMap);
		
		// 세션에서 ID 값 가져오기
		paramMap.put("loginId",session.getAttribute("loginId"));
		
		// 해당 ID 값으로 정보 조회하여 Model 에 담아 전송
		PersonalVO userInfo = personalService.getUserInfo(paramMap);
		model.addAttribute("userInfo", userInfo);
		
		logger.info("+ End " + className + ".personalInfo");

		return "personal/personalInfo";
	}
	
	/**
	 * 마이 페이지 저장
	 */
	@RequestMapping("personalSave.do")
	@ResponseBody
	public Map<String, Object> personalSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".personalSave");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		// 세션에서 ID 값 가져오기
		String id = (String)session.getAttribute("loginId");
		
		int sreturn = 0;
		String result = "";
		String resultmsg = "";
		// ID 일치 시 업데이트
		if(id.equals((String)paramMap.get("loginId"))){
			sreturn = personalService.updateUserInfo(paramMap, request);
		}
		
		if(sreturn >= 0) {
			result = "S";
			resultmsg = "저장 되었습니다.";
		} else {
			result = "F";			
			resultmsg = "저장에 실패 했습니다.";
		}
		
		returnmap.put("result",result);
		returnmap.put("resultmsg",resultmsg);
		
		logger.info("+ End " + className + ".personalSave");
		
		return returnmap;
	}
	
	/**
	 * 마이 페이지 - 이력서 다운로드
	 */
	@RequestMapping("personalDownload.do")
	public void personalDownload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".personalDownload");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginId", (String)session.getAttribute("loginId"));
		// 해당 ID 값으로 정보 조회하여 Model 에 담아 전송
		PersonalVO userInfo = personalService.getUserInfo(paramMap);
		
		// 물리경로
		String file = userInfo.getResume_url();
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(userInfo.getResume_fname(),"UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte); 
		response.getOutputStream().flush();
	    response.getOutputStream().close();

		logger.info("+ End " + className + ".personalDownload");
		return;
	}
	
	/**
	 * 마이 페이지 - 비밀번호 변경
	 */
	@RequestMapping("personalPwdChange.do")
	@ResponseBody 
	public Map<String, Object> personalPwdChange(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".personalPwdChange");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<>();
		String msg = "비밀번호 변경 완료";

		paramMap.put("loginId", (String)session.getAttribute("loginId"));
		
		int result = personalService.updatePwd(paramMap);
		if(result==3){
			msg = "FAIL2";	// 현재 비밀번호 == 새 비밀번호 일 때
		} else if(result==4) {
			msg = "FAIL3";	// 조회된 비밀번호 != 현재 비밀번호
		} else{
			if(result<1){
				msg = "FAIL1";	// 알 수 없는 오류로 변경에 실패하였을 때
			}
		}
		returnmap.put("resultmsg", msg);
		
		logger.info("+ End " + className + ".personalPwdChange");
		return returnmap;
	}
	
	/**
	 * 마이페이지 - 현재 비밀번호 체크 일치여부
	 */
	@RequestMapping("checkPwd.do")
	@ResponseBody 
	public Map<String, Object> checkPwd(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".checkPwd");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<>();
		String msg = "FAIL";

		paramMap.put("loginId", (String)session.getAttribute("loginId"));
		int result = personalService.checkPwd(paramMap);
		if(result == 1)
			msg = "SUCCESS";	// 현재 비밀번호 일치 
		
		returnmap.put("resultmsg", msg);
		
		logger.info("+ End " + className + ".checkPwd");
		return returnmap;
	}
	
	/**
	 * 마이페이지 - 탈퇴
	 */
	@RequestMapping("personalQuit.do")
	@ResponseBody 
	public Map<String, Object> personalQuit(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".personalQuit");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<>();
		String msg = "FAIL";
		
		paramMap.put("loginId", (String)session.getAttribute("loginId"));
		
		int result = personalService.personalQuit(paramMap);
		if(result>0)
			msg = "SUCCESS";
		
		returnmap.put("resultmsg", msg);
		
		logger.info("+ End " + className + ".personalQuit");
		return returnmap;
	}

}// end Class

