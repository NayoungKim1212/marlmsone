package kr.happyjob.study.tut.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Multipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.tut.model.TutorLearningMaterials;
import kr.happyjob.study.tut.model.TutorLectureDto;
import kr.happyjob.study.tut.model.UpdateLearnMatDto;
import kr.happyjob.study.tut.service.TutorLearnMaterialsService;

@Controller
@RequestMapping("/tut/")
public class TutorLearnMaterialsController {
	
		// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();
		
		@Autowired
		TutorLearnMaterialsService tutorLearnMaterialsService;
		
		//강의 목록 관리 메인!
		@RequestMapping("t_learningMaterials.do")
		public String MaterialsMain(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("학습 자료 메인 " + className + ".t_learningMaterials");
			logger.info("=====START MaterialsMain");
			
			logger.info("session ID 값 : " + session.getAttribute("loginId"));
			model.addAttribute("loginId", session.getAttribute("loginId"));
			
			Map<String, Object> param = new HashMap<>();
			param.put("tutorId", session.getAttribute("loginId"));
			
			//강의 리스트 불러오기
			List<TutorLectureDto> lectureList = tutorLearnMaterialsService.getLectureList((String) session.getAttribute("loginId"));
			model.addAttribute("lectureList", lectureList);
			
			logger.info("=====END MaterialsMain");
		
	        return "tut/tutorLearnMaterials";
		}
		
		// 학습 자료 리스트
		@RequestMapping("tutorLearnMatList")
		public String getLearnMatList(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
			
			logger.info("=====학습 자료 리스트 " + className + ".tutorLearnMatList");
			
			Enumeration<String> attributeNames = session.getAttributeNames();
			while(attributeNames.hasMoreElements()) {
				String attributeName = attributeNames.nextElement();
				Object attributeValue = session.getAttribute(attributeName);
				System.out.println("세션 속성 이름 : " + attributeName + ", 값: " + attributeValue);
			}
			
			logger.info("session ID 값 : " + session.getAttribute("loginId"));
			model.addAttribute("loginId", session.getAttribute("loginId"));
			
			int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); 
			int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); 
			int pageIndex = (currentPage - 1) * pageSize;
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			logger.info("   - putparamMap : " + paramMap);
			
			List<TutorLearningMaterials> learningMatList = tutorLearnMaterialsService.getTutorLearnMatList(paramMap);
			int learnMatTotalCount = tutorLearnMaterialsService.learnMatTotalCount(paramMap);
			
			logger.info("learningMatList TotalCount = " +  learnMatTotalCount);
			
			model.addAttribute("totalCount", learningMatList.size());
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("totalCount", learnMatTotalCount);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("learningMatList", learningMatList);
		
			return "/tut/tutorLearnMaterialsList";
		}
		
		// 학습자료 상세정보
		@RequestMapping("getDetailLearnMat.do")
		@ResponseBody
		public Map<String, Object> getDetailLearnMat(@RequestParam(name="learnDataId") int param) throws Exception {
			
			logger.info("====== START getDetailLearnMat");
			logger.info("====== paramData: " + param);
			
			TutorLearningMaterials detailLearnMat = tutorLearnMaterialsService.getDetailLearnMat(param);
			
			Map<String, Object> result = new HashMap<>();
			result.put("detailLearnMat", detailLearnMat);
			
			logger.info("====== END getDetailLearnMat");
			
			return result;
		}
		
		// 학습자료 등록
		@RequestMapping("saveLearningMaterials.do")
		@ResponseBody
		public Boolean saveLearningMaterials(@RequestParam(name="lecture_value") String lectureValue,
																								@RequestParam(name="title") String title,
																								@RequestParam(name="content") String content,
																								@RequestParam(name="file") MultipartFile learningFile)  throws Exception {
			
			logger.info("학습 자료 저장 " + className + ".saveLearningMaterials");
			logger.info("학습 자료 강의명 : " +  lectureValue );
			logger.info("학습 자료 제목 : " +  title);
			logger.info("학습 자료 내용 : " +  content);
			logger.info("학습 자료 파일: " +  learningFile);
			
			Map<String, Object> learningData = new HashMap<String, Object>();
			
			learningData.put("lectureValue", lectureValue);
			learningData.put("title", title);
			learningData.put("content", content);
			learningData.put("learningFile", learningFile);
			
			int temp_data = tutorLearnMaterialsService.insert_learningMaterials(learningData);
			
			logger.info("temp_data : " +  temp_data);
			
			Boolean status = false;
			if(temp_data > 0) {
				status = true;
			}
			
			return status;
		}
		
		// 학습자료 수정
		@RequestMapping("updateLearnMat.do")
		@ResponseBody
		public Boolean updateLearnMat(@ModelAttribute UpdateLearnMatDto updateLearnMatDto) throws Exception {
			logger.info("=====START updateLearnMat");
			logger.info("=====updateLearnMatDto.getUpdateFile() : "  + updateLearnMatDto.getUpdateFile());
			
			Boolean status = false;
			Boolean updateFileStatus = false;
			if(updateLearnMatDto.getUpdateFile() == null) {
				logger.info("=====updateLearnMatDto.getUpdateFile() : "  + updateLearnMatDto.getUpdateFile());
				updateFileStatus = false;
			} else {
				updateFileStatus = true;
			}
			
			logger.info("updateFileStatus : " + updateFileStatus);
			logger.info("updateLearnMaterialsFile : " + updateLearnMatDto.getUpdateFile());
			
			Map<String, Object> updateLearnMatData = new HashMap<String, Object>();
			
			updateLearnMatData.put("learnMatId", updateLearnMatDto.getLearnMatId());
			updateLearnMatData.put("updateLearnTitle", updateLearnMatDto.getUpdateLearnTitle());
			updateLearnMatData.put("updateLearnContent", updateLearnMatDto.getUpdateLearnContent());
			updateLearnMatData.put("updateFileStatus", updateFileStatus);	
			updateLearnMatData.put("updateLearnMaterialsFile",  updateLearnMatDto.getUpdateFile());
			
			 status = tutorLearnMaterialsService.updateLearnMat(updateLearnMatData);
			
			logger.info("=====END updateLearnMat");
			
			return status;
		}
		
		// 학습자료 삭제
		@RequestMapping("deleteLearnMat.do/{learnMatId}")
		@ResponseBody
		public Boolean deleteLearnMat(@PathVariable int learnMatId) throws Exception {
			logger.info("=====START deleteLearnMat");
			
			logger.info("learnMatId : " + learnMatId);
			
			Boolean status = false;
			
			status = tutorLearnMaterialsService.deleteLearnMat(learnMatId);
			
			logger.info("=====END deleteLearnMat");
			
			return status;
		}
		
		//학습자료 파일 다운로드
		@RequestMapping("fileDownload/{fileName:.+}")
		public void learnMatFileDownLoad(@PathVariable String fileName, HttpServletResponse response) throws IOException {
			logger.info("=====START learnMatFileDownLoad");
			logger.info("=====PathVariable : " + fileName);
			
			File file = new File("V:\\FileRepository\\tutor\\"+ fileName);
			
			String originalFileName = fileName.substring(fileName.lastIndexOf("_") + 1);
			logger.info("=====originalFileName : " + originalFileName);
			
			logger.info("===== file : " + file.getPath());
			
			byte fileByte[] = FileUtils.readFileToByteArray(file);
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8")+"\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(fileByte); 
			response.getOutputStream().flush();
		    response.getOutputStream().close();
			
			logger.info("=====END learnMatFileDownLoad");
		}
	}