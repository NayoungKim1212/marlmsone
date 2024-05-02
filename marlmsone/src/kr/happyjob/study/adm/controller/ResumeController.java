package kr.happyjob.study.adm.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.adm.model.AdmLectureDto;
import kr.happyjob.study.adm.model.StudentResumeDto;
import kr.happyjob.study.adm.service.ResumeControlService;

@Controller
@RequestMapping("/adm/")
public class ResumeController {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	ResumeControlService resumeControlService;
	
	@RequestMapping("a_resumeControl.do")
	public String resumeControlMain() throws Exception {
		
		logger.info("=====START projectControl");
	
		logger.info("=====END projectControl");
		
		return "adm/resumeControl";
	}
	
	@RequestMapping("allLectureList")
	public String getAllLectureList(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("=====START getAllLectureList");
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); 
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); 
		int pageIndex = (currentPage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<AdmLectureDto> allLectureList = resumeControlService.getAllLectureList(paramMap);
		int lectureListTotalCount = resumeControlService.lectureListTotalCount();
		
		model.addAttribute("lectureList", allLectureList);
		model.addAttribute("totalCount", lectureListTotalCount);
		
		logger.info("=====END getAllLectureList");
		
		return "adm/resumeControlLectureList";
	}
	
	@RequestMapping("studentResumeList/{lectureId}")
	public String getStudentResumeList(@PathVariable String lectureId, Model model) throws Exception {
		logger.info("=====START getStudentResumeList");
		
		List<StudentResumeDto> studentResumeList = resumeControlService.getStudentResumeList(lectureId);
		int studentResumeTotalCount = resumeControlService.studentResumeTotalCount(lectureId);
		
		model.addAttribute("studentResumeList", studentResumeList);
		model.addAttribute("totalCount", studentResumeTotalCount);
		
		logger.info("=====END getStudentResumeList");
		
		return "adm/studentResumeList";
	}
	
	@RequestMapping("resumeDownload/{lectureId}/{studentId}")
	public void studentResumeDownLoad(@PathVariable String lectureId, 
																	   @PathVariable String studentId, 
																	   HttpServletResponse response) throws Exception {
		
		logger.info("=====START studentResumeDownLoad");
		
		logger.info("lectureId : " + lectureId);
		logger.info("studentId : " + studentId);
		
		
		StudentResumeDto studentResume = resumeControlService.getStudentResume(lectureId, studentId);
		
		String studentResumeFilePath = studentResume.getResumeUrl();
		String studentResumeFileName = studentResume.getResumeFileName();

		logger.info("studentResumeFileName : " + studentResumeFileName);
		
		File file = new File(studentResumeFilePath);
		
		byte fileByte[] = FileUtils.readFileToByteArray(file);
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(studentResumeFileName,"UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte); 
		response.getOutputStream().flush();
	    response.getOutputStream().close();

		logger.info("=====END studentResumeDownLoad");
	}
	
	
}
