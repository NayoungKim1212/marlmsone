package kr.happyjob.study.login.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.login.model.UsrMnuAtrtModel;
import kr.happyjob.study.login.service.LoginService;
import kr.happyjob.study.login.service.MailSendService;
import kr.happyjob.study.system.model.ComnCodUtilModel;



@Controller

public class LoginController {

   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   @Autowired
   LoginService loginService;
   
   /*
   @Autowired
   MailSendService mailSendService;
	*/

   /**
* index 접속 시 로그인 페이지로 이동한다.
* 
* @param   Model result - Spring model object
* @param   Map paramMap - Request Param object
* @param   HttpServletRequest request - Servlet request object
* @param   HttpServletResponse response - Servlet response object
* @param   HttpSession session - Http session Object
* @return   String - page navigator
* @throws Exception
*/

   
   
   
   @RequestMapping("login.do")
   public String index(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

	  logger.info("+ Start LoginController.login.do");
	  
	  
      logger.info("+ End LoginController.login.do");

      return "/login/login";
   }

   /**
* 사용자 로그인을 처리한다.
* 
* @param   Model result - Spring model object
* @param   Map paramMap - Request Param object
* @param   HttpServletRequest request - Servlet request object
* @param   HttpServletResponse response - Servlet response object
* @param   HttpSession session - Http session Object
* @return   String - page navigator
* @throws Exception
*/
   @RequestMapping("loginProc.do")
   @ResponseBody
   public Map<String, Object> loginProc(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start LoginController.loginProc.do");
	  logger.info("   - ParamMap : " + paramMap);
	    
	      // 사용자 로그인
	  LgnInfoModel lgnInfoModel = loginService.loginProc(paramMap);
	  
	  String result;
	  String resultMsg;
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  
	  if (lgnInfoModel != null) {
	     result = "SUCCESS";
	     resultMsg = "사용자 로그인 정보가 일치 합니다.";
	     //System.out.println("asdf" + lgnInfoModel.getApproval_cd());
	     //System.out.println("y".equals(lgnInfoModel.getApproval_cd()));
	     //System.out.println("asdf" + lgnInfoModel.getApproval_cd());
	     //System.out.println("n".equals(lgnInfoModel.getApproval_cd()));
	     
	     // 사용자 메뉴 권한 조회
	     paramMap.put("usr_sst_id", lgnInfoModel.getUsr_sst_id());
	     paramMap.put("userType",lgnInfoModel.getMem_author());
	     // 메뉴 목록 조회 0depth
	     List<UsrMnuAtrtModel> listUsrMnuAtrtModel = loginService.listUsrMnuAtrt(paramMap);
	     // 메뉴 목록 조회 1depth
	     for(UsrMnuAtrtModel list : listUsrMnuAtrtModel){
	        Map<String, Object> resultMapSub = new HashMap<String, Object>();
	        resultMapSub.put("lgn_Id", paramMap.get("lgn_Id")); 
	        resultMapSub.put("hir_mnu_id", list.getMnu_id());
	        resultMapSub.put("userType",lgnInfoModel.getMem_author());
	        list.setNodeList(loginService.listUsrChildMnuAtrt(resultMapSub));
	     }
	     
	     session.setAttribute("loginId",lgnInfoModel.getLgn_id());                  // 로그인 ID
	     session.setAttribute("userNm",lgnInfoModel.getUsr_nm());                   // 사용자 성명
	     session.setAttribute("usrMnuAtrt", listUsrMnuAtrtModel);
	     session.setAttribute("userType", lgnInfoModel.getMem_author());            // 로그인 사용자 권한  
	     																			//	A: 학생 B: 강사 C: 관리자
	     session.setAttribute("serverName", request.getServerName());
	
	     resultMap.put("loginId",lgnInfoModel.getLgn_id()); 
	     resultMap.put("userNm",lgnInfoModel.getUsr_nm()); 
	     resultMap.put("usrMnuAtrt", listUsrMnuAtrtModel);
	     resultMap.put("userType", lgnInfoModel.getMem_author());
	     resultMap.put("serverName", request.getServerName());
	     
		} else {
	
	         result = "FALSE";
	         resultMsg = "사용자 로그인 정보가 일치하지 않습니다.";
	    }
	    
	    resultMap.put("result", result);
	    resultMap.put("resultMsg", resultMsg);
	    resultMap.put("serverName", request.getServerName());
	  
	  
	    logger.info("+ End LoginController.loginProc.do");
	
	    return resultMap;
   }
   
   
   /**
* 로그아웃
* @param request
* @param response
* @param session
* @return
*/
   @RequestMapping(value = "/loginOut.do")
   public ModelAndView loginOut(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
                  
      ModelAndView mav = new ModelAndView();
      session.invalidate();
      mav.setViewName("redirect:/login.do");
      
      return mav;
   }
   /*회원가입*/
   @RequestMapping("register.do")
   @ResponseBody
   public Map<String, Object> registerUser(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
	   logger.info("+ Start " + className + ".registerUser");
	   logger.info("   - paramMap : " + paramMap);
		
	   String action = (String)paramMap.get("action");
	   String result = "FAIL";
	   String resultMsg = "가입 실패";
	   
	   // 가입 관련 코드
	   if("I".equals(action)) {
		   int check = loginService.registerUser(paramMap);
		   if(check > 0){
			   result = "SUCCESS";
			   resultMsg = "가입 완료";
		   }
	   }
	   
	   //전문기술 - 공통 코드 관련 가져오는 메소드들
	   List<ComnCodUtilModel> lg = ComnCodUtil.getComnCod("LanguageCD");
	   
	   for(ComnCodUtilModel lgitem : lg) {
		   String groupitem = lgitem.getGrp_cod();
		   String dtlitem = lgitem.getDtl_cod();
		   
		   try {
			   String paramitem = (String) paramMap.get(dtlitem);
			   
			   paramMap.put("skillgrpcd", groupitem);
			   paramMap.put("skilldtlcd", dtlitem);
			   
			   //insert 
			   
		   } catch (Exception e) {
			   
		   }
	   }   
	   
	   List<ComnCodUtilModel> web = ComnCodUtil.getComnCod("webCD");
	   
	   for(ComnCodUtilModel webitem : web) {
		   String groupitem = webitem.getGrp_cod();
		   String dtlitem = webitem.getDtl_cod();
		   
		   try {
			   String paramitem = (String) paramMap.get(dtlitem);
			   
			   paramMap.put("skillgrpcd", groupitem);
			   paramMap.put("skilldtlcd", dtlitem);
			   
			   //insert 
			   
		   } catch (Exception e) {
			   
		   }
	   }   
	   
	   List<ComnCodUtilModel> db = ComnCodUtil.getComnCod("DBCD");
	   
	   for(ComnCodUtilModel dbitem : db) {
		   String groupitem = dbitem.getGrp_cod();
		   String dtlitem = dbitem.getDtl_cod();
		   
		   try {
			   String paramitem = (String) paramMap.get(dtlitem);
			   
			   paramMap.put("skillgrpcd", groupitem);
			   paramMap.put("skilldtlcd", dtlitem);
			   
			   //insert 
			   
		   } catch (Exception e) {
			   
		   }
	   }
	   
	   
	   List<ComnCodUtilModel> ws = ComnCodUtil.getComnCod("WSCD");
	   
	   for(ComnCodUtilModel wsitem : ws) {
		   String groupitem = wsitem.getGrp_cod();
		   String dtlitem = wsitem.getDtl_cod();
		   
		   try {
				   String paramitem = (String) paramMap.get(dtlitem);
				   
				   paramMap.put("skillgrpcd", groupitem);
				   paramMap.put("skilldtlcd", dtlitem);
			   
			   //insert 
			   
		   } catch (Exception e) {
			   
		   }
	   }
	   
	   // 반환
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   resultMap.put("result", result);
	   resultMap.put("resultMsg", resultMsg);
	   
	   logger.info("+ End " + className + ".registerUser");
	   
	   return resultMap;
   }
   
   
   /*loginID 중복체크*/
   @RequestMapping(value="check_loginID", method=RequestMethod.POST)
   @ResponseBody
   public int check_loginID(LgnInfoModel model) throws Exception{
	   
	   logger.info("+ Start " + className + ".loginID_check");
	   int result = loginService.check_loginID(model);
	   logger.info("+ End " + className + ".loginID_check");
	   return result;
   }
   
   /*이메일 중복체크*/
   @RequestMapping(value="check_email", method=RequestMethod.POST)
   @ResponseBody
   public int check_email(LgnInfoModel model) throws Exception{
	   logger.info("+ Start " + className + ".loginID_check");
	   int result = loginService.check_email(model);
	   logger.info("+ End " + className + ".loginID_check");
	   return result;
   }
   
/**
*  사용자 id 찾기
*/
   @RequestMapping("selectFindInfoId.do")
   @ResponseBody
   public Map<String, Object> selectFindInfoId(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".selectFindInfoId");
  
      logger.info("   - paramMap : " + paramMap);
	  String result = "FALSE";
	  String resultMsg = "조회 실패";
	  
	  int cnt = loginService.selectFindIdCnt(paramMap);
	  String id = "";
	  if (cnt > 0) { 
		  result = "SUCCESS";
		  resultMsg = "조회 성공";
		   id = loginService.selectFindId(paramMap);
	  }
  

	  Map<String, Object> resultMap = new HashMap<String, Object>();
	
	  resultMap.put("result", result);
	  resultMap.put("resultMsg", resultMsg);
	  if(id!=null || !id.equals(""))
		  resultMap.put("id", id);
	
	  logger.info("+ End " + className + ".selectFindInfoId");
	  
	  System.out.println("resultMap ID 확인 : " + resultMap.get("id"));
	  
      return resultMap;
   }
   
   
   
   //사용자 pw 조회
   @RequestMapping("selectFindInfoPw.do")
   @ResponseBody
   public Map<String, Object> selectFindInfoPw(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
		  logger.info("+ Start " + className + ".selectFindInfoPw");
		  
		  logger.info("   - paramMap : " + paramMap);
		  
		  String result = "FALSE";
		  String resultMsg = "조회 실패";
		  int cnt = loginService.selectFindPwCnt(paramMap);
		  
		  if (cnt > 0) {  
			  result = "SUCCESS";
			  resultMsg = "조회 성공";
		  }
		  
		  Map<String, Object> resultMap = new HashMap<String, Object>();
		
		  resultMap.put("result", result);
		  resultMap.put("resultMsg", resultMsg);
		  
		  logger.info("+ End " + className + ".selectFindInfoPw");
      
		  return resultMap;
   }
   
   
   //사용자 pw 변경
   @RequestMapping("updateFindPw.do")
   @ResponseBody
   public Map<String, Object> updateFindPw(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		   HttpServletResponse response, HttpSession session) throws Exception {
	   
	   logger.info("+ Start " + className + ".updateFindPw");
	   
	   logger.info("   - paramMap : " + paramMap);
	   
	   String result = "FALSE";
	   String resultMsg = "변경 실패";
	   int cnt = loginService.updatePw(paramMap);
	   
	   if (cnt > 0) {  
		   result = "SUCCESS";
		   resultMsg = "변경 성공";
	   }
	   
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   
	   resultMap.put("result", result);
	   resultMap.put("resultMsg", resultMsg);
	   
	   logger.info("+ End " + className + ".updateFindPw");
	   
	   return resultMap;
   }
   
   
   /**사용자 PW 찾기 ID 체크*/
   @RequestMapping("registerIdCheck.do")
   @ResponseBody
   public Map<String, Object> registerIdCheck(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	   
	   logger.info("+ Start " + className + ".registerIdCheck");
	   
	   logger.info("   - paramMap : " + paramMap);

	  String result;
	  String resultMsg;
	  LgnInfoModel registerIdCheck= loginService.registerIdCheck(paramMap);
	  
	  if (registerIdCheck != null) {  
		  result = "SUCCESS";
		  resultMsg = "조회 성공";

		}else {
		      result = "FALSE";
		      resultMsg = "조회 실패";
		  	  }
	  
	  Map<String, Object> resultMap = new HashMap<String, Object>();

	  resultMap.put("result", result);
	  resultMap.put("resultMsg", resultMsg);
	  resultMap.put("resultModel", registerIdCheck);
	  
/*	  System.out.println(result);
	  System.out.println(resultMsg);
	  System.out.println(registerIdCheck);
	  System.out.println(resultMap);*/
	  
	  logger.info("+ End " + className + ".registerIdCheck");
	   
	   return resultMap;
   }
   
   
   /**메일 발송*/
   /*
   @RequestMapping("sendmail.do")
   @ResponseBody
   public Map<String, Object> emailSendAuth(Model model, HttpServletRequest request, HttpServletResponse response, 
		   	HttpSession session) throws Exception {
	   logger.info("+ Start " + className + ".emailSendAuth");

	   String emailNum = request.getParameter("email");
	   String authNumId = "";
	   authNumId = mailSendService.RandomNum();
	   System.out.println(authNumId);
	   System.out.println(emailNum);
	   mailSendService.sendEmail(emailNum, authNumId);
	   
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   
	   //mv.setViewName("login/login");
	   resultMap.put("emailNum", emailNum);
	   resultMap.put("authNumId", authNumId);

	   System.out.println(emailNum);
	   System.out.println(authNumId);
	   System.out.println(resultMap);
	   logger.info("+ End " + className + ".emailSendAuth");
   
	   return resultMap;
   }
    */
   @RequestMapping("checklist.do")
   @ResponseBody
   public Map<String, Object> checklist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start LoginController.checklist.do");
      logger.info("   - ParamMap : " + paramMap);
   
      //전문기술 공통코드 
      List<ComnCodUtilModel> listlistCod = ComnCodUtil.getComnCod("LanguageCD");
      List<ComnCodUtilModel> weblistCod = ComnCodUtil.getComnCod("webCD");
      List<ComnCodUtilModel> dblistCod = ComnCodUtil.getComnCod("DBCD");
      List<ComnCodUtilModel> wslistCod = ComnCodUtil.getComnCod("WSCD");
      List<ComnCodUtilModel> sklcdlistCod = ComnCodUtil.getComnCod("SKLCD"); //등급
      List<ComnCodUtilModel> areacdlistCod = ComnCodUtil.getComnCod("areaCD"); //희망근무지역
      
      Map<String, Object> resultMap = new HashMap<String, Object>();
      resultMap.put("listlistCod", listlistCod);
      resultMap.put("weblistCod", weblistCod);
      resultMap.put("dblistCod", dblistCod);
      resultMap.put("wslistCod", wslistCod);
      resultMap.put("sklcdlistCod", sklcdlistCod);
      resultMap.put("areacdlistCod", areacdlistCod);
  
      logger.info("+ End LoginController.checklist.do");
      logger.info("확인 weblistCod:"+weblistCod);
      logger.info("확인 sklcdlistCod:"+sklcdlistCod);
      return resultMap;
   }   
   
/*	@RequestMapping("saveFileTest.do")
	@ResponseBody
	public Map<String, Object> saveFileTest(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start saveFileTest");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		
		
		if ("I".equals(action)) {
			//CmntBbsService.insertCmntBbs(paramMap, request); // 게시글 신규 저장 
			logger.info("  action  :  " + action);
			LoginService.insertFile(paramMap,request);
		} else if("U".equals(action)) {
			//CmntBbsService.updateCmntBbs(paramMap, request); // 게시글 수정 저장
			logger.info("  action  :  " + action);
			LoginService.updateFile(paramMap,request);
		} else {
			logger.info("  action  :  " + action);
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End saveFileTest");
		
		return resultMap;
	}*/
   
}