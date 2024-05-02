package kr.happyjob.study.tut.service;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.tut.dao.TutorProjectDao;
import kr.happyjob.study.tut.model.StudentProjectDto;
import kr.happyjob.study.tut.model.TutorLearningMaterials;
import kr.happyjob.study.tut.model.TutorLectureDto;
import kr.happyjob.study.tut.model.TutorProjectDto;

@Service
public class TutorProjectServiceImpl implements TutorProjectService{

	@Autowired
	TutorProjectDao tutorProjectDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.tutorProjectPath}")
	private String tutorProjectPath;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// 과제정보 리스트 가져오기
	@Override
	public List<TutorProjectDto> getTutorProjectList(Map<String, Object> paramMap) throws Exception {
		logger.info("===== START getTutorProjectList");
		logger.info("paramMap : " + paramMap);
		
		List<TutorProjectDto> result = tutorProjectDao.getTutorProjectList(paramMap);
		
		logger.info("getTutorProjectList : "  + result);	
		return result;
	}

	// 과제정보 총 갯수
	@Override
	public int tutorProjectTotalCount(Map<String, Object> paramMap) throws Exception {
		
		return tutorProjectDao.tutorProjectTotalCount(paramMap);
		
	}

	//과제정보 디테일
	@Override
	public TutorProjectDto getDetailTutorProject(int param) throws Exception {
		
		TutorProjectDto tutorProjectData = tutorProjectDao.getDetailTutorProject(param);
		logger.info("learnMatData FileName : " + tutorProjectData.getHwk_fname());
		
		String fileName = tutorProjectData.getHwk_fname();
		String originalFileName = fileName.substring(fileName.lastIndexOf("_") + 1);
		
		logger.info("learnMatData originalFileName : " + originalFileName);
		
		tutorProjectData.setProject_orginal_fname(originalFileName);
		
		return tutorProjectData;
		
	}
	
	//과제등록
	@Override
	public int insertTutorProject(Map<String, Object> paramMap) throws Exception {
		
		logger.info("paramMap 확인 : " + paramMap);
		
		String uploadDir = rootPath + tutorProjectPath;
		UUID uuid = UUID.randomUUID();
		MultipartFile projectFile = (MultipartFile) paramMap.get("projectFile");
		
		File uploadPath = new File(uploadDir);
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		logger.info("=====upload Path" + uploadDir);
		
		String projectFileName = projectFile.getOriginalFilename();
		String saveFileName = uuid.toString() + "_" + projectFileName;
		
		long fileSize = projectFile.getSize();
		String projectFileSize = String.valueOf(fileSize) + "Byte"; 
		
		String filePath = uploadDir + File.separator + saveFileName;
		logger.info("=====filePath = " + filePath);
		logger.info("=====FileSize : " + projectFileSize);
		
		Integer.parseInt((String) paramMap.get("lectureValue"));
		
		TutorProjectDto tutorProjectDto = new TutorProjectDto();
		
		tutorProjectDto.setLectureId(Integer.parseInt((String) paramMap.get("lectureValue")));
		tutorProjectDto.setProjectTitle((String) paramMap.get("projectTitle"));
		tutorProjectDto.setProjectContent((String) paramMap.get("proejectContent"));
		tutorProjectDto.setStartDate((String) paramMap.get("projectSubmitDate"));
		tutorProjectDto.setDeadLineDate((String) paramMap.get("projectDeadLineDate"));
		tutorProjectDto.setHwk_fname(saveFileName);
		tutorProjectDto.setHwk_url(filePath);
		tutorProjectDto.setHwk_fsize(projectFileSize);
		
		//DTO에 값 담기
		int result = tutorProjectDao.insertTutorProejct(tutorProjectDto);
		
		File dest = new File(filePath);
		projectFile.transferTo(dest);
		
		return result;
	}

	//과제 수정
	@Override
	public Boolean updateTutorProject(Map<String, Object> paramMap) throws Exception {
		
		logger.info("paramMap 확인 : " + paramMap);
		
		Boolean status = false;
		int result = 0;
		
		if((Boolean)paramMap.get("updateFileStatus") == false) {
			 result = tutorProjectDao.updateTutorProject(paramMap);
			 
			 if(result > 0) {
				 status = true;
			 }
		} else {
			String uploadDir = rootPath + tutorProjectPath;
			UUID uuid = UUID.randomUUID();
			MultipartFile updateProjectFile = (MultipartFile) paramMap.get("updateFile");
			
			File uploadPath = new File(uploadDir);
			if(!uploadPath.exists()) {
				uploadPath.mkdirs();
			}
			
			logger.info("=====upload Path" + uploadDir);
			
			String updateProjectFileName = updateProjectFile.getOriginalFilename();
			String saveUpdateFileName = uuid.toString() + "_" + updateProjectFileName;
			
			long updatefileSize = updateProjectFile.getSize();
			String updateProjectFileSize = String.valueOf(updatefileSize) + "Byte"; 
			
			String updateFilePath = uploadDir + File.separator + saveUpdateFileName;
			
			paramMap.put("saveUpdateFileName", saveUpdateFileName);
			paramMap.put("updateProjectFileSize", updateProjectFileSize);
			paramMap.put("updateFilePath", updateFilePath);
			
			result = tutorProjectDao.updateTutorProject(paramMap);
			
			if (result > 0) {
				File dest = new File(updateFilePath);
				updateProjectFile.transferTo(dest);
				status = true;
			} 
		}
		return status;
	}

	//과제 삭제
	@Override
	public Boolean deleteTutorProject(int projectId) throws Exception {
		
		int result = tutorProjectDao.deleteTutorProject(projectId);
		
		Boolean status = false;
		
		if(result > 0) {
			status = true;
		}
		
		return status;
	}

	@Override
	public List<StudentProjectDto> getStudentProjectList(int projectId) throws Exception {
		
		return tutorProjectDao.getStudentProjectList(projectId);
	}

	@Override
	public StudentProjectDto getStudentProject(String submitId) throws Exception {
		
		return tutorProjectDao.getStudentProject(submitId);
	}
	
	

}
