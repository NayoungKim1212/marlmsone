package kr.happyjob.study.std.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.std.model.SubmittedWorkVo;
import kr.happyjob.study.std.service.SubmittedWorkService;

@Controller
@RequestMapping("/std/")
public class SubmittedWorkController {
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();
	
	@Autowired
	SubmittedWorkService submittedWorkService;
	
	/** 과제 관리 초기 화면*/ 
	@RequestMapping("/submittedWork.do")
	public String submittedWork (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
			logger.info("+ Start " + className + ".submittedWork");
			logger.info("   - paramMap : " + paramMap);
			logger.info("+ End " + className + ".submittedWork");
		return "/std/submittedWork";
	}
	
	/** 과제 목록 출력*/ 
	@RequestMapping("/submitList.do")
	public String submitList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".submitList");
		logger.info("   - paramMap : " + paramMap);
		
		int cpage = Integer.valueOf((String) paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
		
		String loginID = (String)session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		int startpos = (cpage-1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<SubmittedWorkVo> listdata = submittedWorkService.submitList(paramMap);
		
		int listcnt = submittedWorkService.submitcnt(paramMap);
		model.addAttribute("listdata", listdata);
		model.addAttribute("listcnt", listcnt);
		
		logger.info("+ End " + className + ".submitList");

		
		return "/std/submittedWorkList";
	}
	
/*	
	@RequestMapping("/submitList.do")
	public String submitList (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{

			String std_id = (String) session.getAttribute("loginId");
			paramMap.put("loginID", std_id);
			
			logger.info("+ Start " + className + ".fHwkList");
			logger.info("   - paramMap : " + paramMap);
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
					
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			List<SubmittedWorkVo> submitList = submittedWorkService.submitList(paramMap);

			
			model.addAttribute("pageSize",pageSize);
			model.addAttribute("currentPage",currentPage);
			model.addAttribute("hwkList",submitList);
			
			logger.info("+ End " + className + ".fHwkList");
		
			return "/std/submittedWorkList";
	}
	*/
	
	
	/** 과제 등록 */
	@RequestMapping(value= "/submitSave.do")
	@ResponseBody	
	public Map<String, Object> submitSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".submitSave");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String)session.getAttribute("loginId");
		paramMap.put("std_id", loginID);
		
		int returnData = submittedWorkService.submitSave(paramMap, request);

		String result ="";
		String msg ="";
		
		Map<String, Object> returnMap = new HashMap<>();
		
		if(returnData>0){
			result="sucess";
			msg="등록에 성공했습니다";
			returnMap.put("result", result);
			returnMap.put("msg", msg);
		}else{
			result="fail";
			msg="등록에 실패했습니다";
			returnMap.put("result", result);
			returnMap.put("msg", msg);
		}
		
		return returnMap;
	}
	
	
	/** 개별조회 (업로드 파일 가져오기)*/
	@RequestMapping("getFile.do")
	@ResponseBody	
	@Transactional
	public Map<String, Object> getFile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".getFile");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String)session.getAttribute("loginId");
		paramMap.put("std_id", loginID);
		
		logger.info("아이디 추가 전달 > "+paramMap);
		// 반환할 데이터를 담을 Map 객체
		Map<String, Object> returnmap = new HashMap<>();

		SubmittedWorkVo selinfo = submittedWorkService.getFile(paramMap);	
		
		returnmap.put("selinfo", selinfo);
		
		logger.info("컨트롤러 마지막 문제 발생 없음!!!!!!!!!!!: "+returnmap );
		logger.info("+ End " + className + ".noticeView");
		
	
		
		return returnmap;
	}	
	
	
	/** 과제 수정*/
	@RequestMapping(value= "/submitModify.do")
	@ResponseBody	
	public Map<String, Object> submitModify(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		
		logger.info("+ Start " + className + ".submitSave");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String)session.getAttribute("loginId");
		paramMap.put("std_id", loginID);
		
		int returnData = submittedWorkService.submitModify(paramMap, request);

		String result ="";
		String msg ="";
		
		Map<String, Object> returnMap = new HashMap<>();
		
		if(returnData>0){
			result="sucess";
			msg="수정에 성공했습니다";
			returnMap.put("result", result);
			returnMap.put("msg", msg);
		}else{
			result="fail";
			msg="수정에 실패했습니다";
			returnMap.put("result", result);
			returnMap.put("msg", msg);
		}
		
		return returnMap;
	}
	
	@RequestMapping("submitDownload.do")
	@ResponseBody	// body 에만 담아서 데이터 리턴을 위함
	@Transactional
	public Map<String, Object> noticeDownload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticeDownload");
		logger.info("   - paramMap : " + paramMap);
		String loginID = (String)session.getAttribute("loginId");
		paramMap.put("std_id", loginID);
		
		SubmittedWorkVo getInfo = submittedWorkService.getFile(paramMap);
		
		//실제 저장된 주소 
		String file = getInfo.getSubmit_url();
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		  
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(getInfo.getSubmit_fname(),"UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte); 
		response.getOutputStream().flush();
	    response.getOutputStream().close();		
		return null;
	}	

}
