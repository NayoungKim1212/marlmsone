package kr.happyjob.study.tut.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.tut.model.StudentProjectDto;
import kr.happyjob.study.tut.model.TutorLearningMaterials;
import kr.happyjob.study.tut.model.TutorLectureDto;
import kr.happyjob.study.tut.model.TutorProjectDto;
import kr.happyjob.study.tut.model.UpdateTutorProjectDto;
import kr.happyjob.study.tut.service.LectureStudentService;
import kr.happyjob.study.tut.service.TutorLearnMaterialsService;
import kr.happyjob.study.tut.service.TutorProjectService;

@Controller
@RequestMapping("/tut/")
public class projectControlController {
	
		// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();
		
		@Autowired
		TutorLearnMaterialsService tutorLearnMaterialsService;
		
		@Autowired
		LectureStudentService lectureStudentService;
		
		@Autowired
		TutorProjectService tutorProjectService;
		
		// 과제 관리 페이지 로드
		@RequestMapping("projectControl.do")
		public String projectControlMain(Model model, HttpSession session) throws Exception {
			
			logger.info("=====START projectControl");
		
			logger.info("session ID 값 : " + session.getAttribute("loginId"));
			model.addAttribute("loginId", session.getAttribute("loginId"));
			
			Map<String, Object> param = new HashMap<>();
			param.put("tutorId", session.getAttribute("loginId"));
			
			//강의 리스트 불러오기
			List<TutorLectureDto> lectureList = tutorLearnMaterialsService.getLectureList((String) session.getAttribute("loginId"));
			model.addAttribute("lectureList", lectureList);
			
			logger.info("=====END projectControl");
		
	        return "tut/projectControl";
		}
		
		// 수업정보 데이터 가져오기
		@RequestMapping("projectLectureDetail")
		@ResponseBody
		public Map<String, Object> getTutorLectureDetail(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
			logger.info("=====START getTutorLectureDetail");
		
			TutorLectureDto detailTutorLecture = lectureStudentService.getDetailTutorLecture(paramMap);
		
			Map<String, Object> result = new HashMap<>();
			result.put("detailTutorLecture",detailTutorLecture);
			logger.info("=====END getTutorLectureDetail");
			
			return result;
		}
		
		//과제 정보 리스트 가져오기
		@RequestMapping("tutorProjectList")
		public String getTutorProjectList(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
			logger.info("=====START getTutorProjectList" );
			
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
			
			List<TutorProjectDto> tutorProjectList = tutorProjectService.getTutorProjectList(paramMap);
			int TutorProjectTotalCount = tutorProjectService.tutorProjectTotalCount(paramMap);
			
			logger.info("tutorProjectList : " +  tutorProjectList);
			logger.info("TutorProjectTotalCount  = " +  TutorProjectTotalCount);
			
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("totalCount", TutorProjectTotalCount);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("tutorProjectList", tutorProjectList);
			
			return "/tut/tutorProjectList";
		}
		
		//과제 정보 디테일 가져오기
		@RequestMapping("getDetailTutorProject")
		@ResponseBody
		public Map<String, Object> getDetailTutorProject(@RequestParam(name="projectDateId") int param) throws Exception {
			logger.info("====== START getDetailTutorProject");
			logger.info("====== paramData: " + param);
			
			TutorProjectDto detailTutorProject = tutorProjectService.getDetailTutorProject(param);
			
			Map<String, Object> result = new HashMap<>();
			result.put("detailTutorProject", detailTutorProject);
			
			logger.info("====== END getDetailTutorProject");
			
			return result;
		}
		
		// 과제등록
		@RequestMapping("saveLectureProject")
		@ResponseBody
		public Boolean saveLectureProject(@RequestParam(name="lectureValue") String lectureValue,
																	@RequestParam(name="projectTitle") String projectTitle,
																	@RequestParam(name="proejectContent") String proejectContent,
																	@RequestParam(name="projectSubmitDate") String projectSubmitDate,
																	@RequestParam(name="projectDeadLineDate") String projectDeadLineDate,
																	@RequestParam(name="file") MultipartFile projectFile) throws Exception {
			
			logger.info("=====START saveLectureProject ");
			
			logger.info("강의 ID : " + lectureValue);
			logger.info("과제 제목 : " + projectTitle);
			logger.info("과제 내용 : " + proejectContent);
			logger.info("과제 제출일 : " + projectSubmitDate);
			logger.info("과제 제출일 : " + projectDeadLineDate);
			logger.info("과제 파일 : " + projectFile);
	
			Map<String, Object> projectData = new HashMap<String, Object>();
			
			projectData.put("lectureValue", lectureValue);
			projectData.put("projectTitle", projectTitle);
			projectData.put("proejectContent", proejectContent);
			projectData.put("projectSubmitDate", projectSubmitDate);
			projectData.put("projectDeadLineDate", projectDeadLineDate);
			projectData.put("projectFile", projectFile);

			int temp_data = tutorProjectService.insertTutorProject(projectData);
			
			logger.info("temp_data : " +  temp_data);
			
			Boolean status = false;
			if(temp_data > 0) {
				status = true;
			}
			
			logger.info("=====END saveLectureProject ");
			
			return status;
		}
		
		//과제수정
		@RequestMapping("updateTutorProject")
		@ResponseBody
		public Boolean updateTutorProject(@ModelAttribute UpdateTutorProjectDto updateTutorProjectDto) throws Exception {
			logger.info("=====START updateTutorProject");
			logger.info("=====updateLearnMatDto.getUpdateFile() : "  + updateTutorProjectDto.getUpdateFile());
			
			Boolean status = false;
			Boolean updateFileStatus = false;
			
			if(updateTutorProjectDto.getUpdateFile() == null) {
				logger.info("=====updateLearnMatDto.getUpdateFile() : "  + updateTutorProjectDto.getUpdateFile());
				updateFileStatus = false;
			} else {
				updateFileStatus = true;
			}
			
			logger.info("updateFileStatus : " + updateFileStatus);
			logger.info("updateLearnMaterialsFile : " + updateTutorProjectDto.getUpdateFile());
		
			Map<String, Object> updateTutorProjectData = new HashMap<String, Object>();
			
			updateTutorProjectData.put("projectId", updateTutorProjectDto.getProjectId());
			updateTutorProjectData.put("updateProjectTitle", updateTutorProjectDto.getUpdateProjectTitle());
			updateTutorProjectData.put("updateProjectContent", updateTutorProjectDto.getUpdateProjectContent());
			updateTutorProjectData.put("updateProjectSubmitDate", updateTutorProjectDto.getUpdateProjectSubmitDate());
			updateTutorProjectData.put("updateProjectDeadLineDate", updateTutorProjectDto.getUpdateProjectDeadLineDate());
			updateTutorProjectData.put("updateFileStatus", updateFileStatus);			
			updateTutorProjectData.put("updateFile", updateTutorProjectDto.getUpdateFile());
			
			status = tutorProjectService.updateTutorProject(updateTutorProjectData);
			
			logger.info("=====End updateTutorProject");
			
			return status;
		}
		
		//과제삭제
		@RequestMapping("deleteTutorProject/{projectId}")
		@ResponseBody
		public Boolean deleteTutorProject(@PathVariable int projectId) throws Exception {
			logger.info("=====START deleteTutorProject");
			
			Boolean status = false;
			
			status = tutorProjectService.deleteTutorProject(projectId);
			
			logger.info("=====END deleteTutorProject");
			
			return status;
		}
		
		@RequestMapping("showStudentProject/{projectId}")
		public String showStudentProject(@PathVariable int projectId, Model model) throws Exception {
			
			logger.info("===== START showStudentProject");
			
			List<StudentProjectDto> studentProjectList = tutorProjectService.getStudentProjectList(projectId);
			
			logger.info("===== END showStudentProject");
			
			model.addAttribute("totalCount", studentProjectList.size());
			model.addAttribute("studentProjectList", studentProjectList);
			
			return "/tut/studentProjectList";
			
		}
		
		@RequestMapping("tutorProject/fileDownLoad/{projectId}")
		public void projectFileDownLoad(@PathVariable int projectId, HttpServletResponse response) throws Exception {
			logger.info("===== START projectFileDownLoad");
			
			TutorProjectDto detailTutorProject = tutorProjectService.getDetailTutorProject(projectId);
			
			String tutorProjectUrl = detailTutorProject.getHwk_url();
			String tutorProjectFileName = detailTutorProject.getHwk_fname();
			
			File file = new File(tutorProjectUrl);
			
			byte fileByte[] = FileUtils.readFileToByteArray(file);
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(tutorProjectFileName,"UTF-8")+"\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(fileByte); 
			response.getOutputStream().flush();
		    response.getOutputStream().close();
			
			logger.info("===== END projectFileDownLoad");
		}
		
		@RequestMapping("studentProject/fileDownLoad/{submitId}")
		public void studentProjectFileDownLoad(@PathVariable String submitId, HttpServletResponse response) throws Exception {
			logger.info("===== START studentProjectFileDownLoad");
			
			StudentProjectDto studentProject = tutorProjectService.getStudentProject(submitId);
			
			String studentProjectUrl = studentProject.getSubmit_url();
			String studentProjectFileName = studentProject.getSubmit_fname();
			
			File file = new File(studentProjectUrl);
			
			byte fileByte[] = FileUtils.readFileToByteArray(file);
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(studentProjectFileName,"UTF-8")+"\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(fileByte); 
			response.getOutputStream().flush();
		    response.getOutputStream().close();
			
			logger.info("===== END studentProjectFileDownLoad");
		}
	}