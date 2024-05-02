package kr.happyjob.study.std.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.happyjob.study.std.model.StdLearningMaterialsModel;
import kr.happyjob.study.std.service.StdLearnMaterialsService;

@Controller
@RequestMapping("/std")
public class StdLearnMaterialsController {
	
	@Autowired
	StdLearnMaterialsService stdLearnMaterialsService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger 
	private final String className = this.getClass().toString();

	// 학생 관리	
	@RequestMapping("s_learningMaterials.do")
	public String MaterialsMain(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		logger.info("==========학습자료 페이지=========");
		
		return "std/stdLearnMaterials";
	}
	
	// 학습 자료 리스트
	@RequestMapping("stdLearnMatList")
	public String getLearnMatList(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		
		logger.info("=====학습 자료 리스트 " + className + ".stdLearnMatList");
		
		logger.info("session ID 값 : " + session.getAttribute("loginId"));
		paramMap.put("loginId", session.getAttribute("loginId"));
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); 
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); 
		int pageIndex = (currentPage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		logger.info("   - putparamMap : " + paramMap);
		
		List<StdLearningMaterialsModel> learningMatList = stdLearnMaterialsService.stdLearnMatList(paramMap);
		int learnMatTotalCount = stdLearnMaterialsService.learnMatTotalCount(paramMap);
		
		logger.info("learningMatList TotalCount = " +  learnMatTotalCount);
		
		model.addAttribute("totalCount", learningMatList.size());
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totalCount", learnMatTotalCount);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("learningMatList", learningMatList);
	
		return "/std/stdLearnMaterialsList";
	}
	
	// 학습 자료 모달
	@RequestMapping("stdLearnMatDetail.do")
	@ResponseBody
	public Map<String, Object> stdLearnMatDetail(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".stdLearnMatDetail");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 모달창 정보 출력
		StdLearningMaterialsModel std_detail = stdLearnMaterialsService.std_detail(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("std_detail", std_detail);
		
		logger.info("+ End " + className + ".stdLearnMatDetail");
		
		return resultMap;
	}
	
	// 첨부파일 다운로드
	@RequestMapping("fileDownload.do")
	public void fileDownload(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".fileDownload");
		logger.info("   - paramMap : " + paramMap);
		
		String learn_data_id = (String) paramMap.get("learn_data_id");
		paramMap.put(learn_data_id, Integer.parseInt(learn_data_id));
		
		StdLearningMaterialsModel selectfile = stdLearnMaterialsService.std_detail(paramMap);
		
		String file = selectfile.getLearn_url();
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(selectfile.getLearn_fname(),"UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte); 
		response.getOutputStream().flush();
	    response.getOutputStream().close();
		
		logger.info("+ End " + className + ".fileDownload");		
	}
}
