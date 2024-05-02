package kr.happyjob.study.tut.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.tut.dao.TutorLearnMaterialsDao;
import kr.happyjob.study.tut.model.TutorLearningMaterials;
import kr.happyjob.study.tut.model.TutorLectureDto;

@Service
public class TutorLearnMaterialsServiceImpl implements TutorLearnMaterialsService{
	
	@Autowired
	TutorLearnMaterialsDao tutorLearnMaterialsDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.tutorPath}")
	private String tutorPath;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Override
	public List<TutorLearningMaterials> getTutorLearnMatList(Map<String, Object> paramMap) throws Exception {
		logger.info("===== START getTutorLearnMatList START");
		logger.info("paramMap : " + paramMap);
		
		List<TutorLearningMaterials> result = tutorLearnMaterialsDao.getTutorLearnMatList(paramMap);
		
		logger.info("TutorLearningMaterials : "  + result);		
		
		return result;
		
	}
	
	// 학습자료 Total Count
	@Override
	public int learnMatTotalCount(Map<String, Object> paramMap) throws Exception {
		return tutorLearnMaterialsDao.learnMatTotalCount(paramMap);
	}
	
	// 학습자료 리스트
	@Override
	public List<TutorLectureDto> getLectureList(String tutorId) throws Exception {
		
		logger.info("=========getLectureLIst test");
		logger.info("parameter : " + tutorId);
		
		List<TutorLectureDto> result = tutorLearnMaterialsDao.getLectureList(tutorId);
	
		logger.info("Lecture Data Dao : " + tutorLearnMaterialsDao.getLectureList(tutorId));
		logger.info("lecture DATA : " +  result);
		
		return result;
	}
	
	// 학습자료 등록
	@Override
	public int insert_learningMaterials(Map<String, Object> paramMap) throws Exception {
		
		logger.info("paramMap 확인 : " + paramMap);
		
		String uploadDir = rootPath + tutorPath;
		UUID uuid = UUID.randomUUID();
		MultipartFile learningFile = (MultipartFile) paramMap.get("learningFile");
		
		File uploadPath = new File(uploadDir);
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		logger.info("=====upload Path" + uploadDir);

		String learningFileName = learningFile.getOriginalFilename();
		String saveFileName = uuid.toString() + "_" + learningFileName;
		
		long fileSize = learningFile.getSize();
		String learningFileSize = String.valueOf(fileSize) + "Byte"; 
		
		String filePath = uploadDir + File.separator + saveFileName;
		logger.info("=====filePath = " + filePath);
		logger.info("=====FileSize : " + learningFileSize);
		
		
		Integer.parseInt((String) paramMap.get("lectureValue"));
		
		// Dto에 값 담기
		TutorLearningMaterials tutorLearnMatDto = new TutorLearningMaterials();
		tutorLearnMatDto.setLectureId(Integer.parseInt((String) paramMap.get("lectureValue")));
		tutorLearnMatDto.setLearnTitle((String) paramMap.get("title"));
		tutorLearnMatDto.setLearnContent((String) paramMap.get("content"));
		tutorLearnMatDto.setMaterials_fname(saveFileName);
		tutorLearnMatDto.setMaterials_url(filePath);
		tutorLearnMatDto.setMaterials_fsize(learningFileSize);
		
		int result = tutorLearnMaterialsDao.insertLearnMaterials(tutorLearnMatDto);
		
		File dest = new File(filePath);
		learningFile.transferTo(dest);
		
		return result;
	}

	// 학습자료 상세정보
	@Override
	public TutorLearningMaterials getDetailLearnMat(int param) throws Exception {
		
		TutorLearningMaterials learnMatData =  tutorLearnMaterialsDao.getDetailLearnMat(param);
		
		logger.info("learnMatData FileName : " + learnMatData.getMaterials_fname());
		
		String fileName = learnMatData.getMaterials_fname();
		String originalFileName = fileName.substring(fileName.lastIndexOf("_") + 1);
		
		logger.info("learnMatData originalFileName : " + originalFileName);
		
		learnMatData.setMaterials_orginal_fname(originalFileName);
		
		return learnMatData;
	}

	// 학습자료 수정
	@Override
	public Boolean updateLearnMat(Map<String, Object> paramMap) throws Exception {
		
		logger.info("paramMap 확인 : " + paramMap);
		
		Boolean status = false;
		int result = 0;
				
		
		if((Boolean)paramMap.get("updateFileStatus") == false) {
			 result = tutorLearnMaterialsDao.updateLearnMat(paramMap);
			 
			 if(result > 0) {
				 status = true;
			 }
			 
		} else {
			
			String uploadDir = rootPath + tutorPath;
			UUID uuid = UUID.randomUUID();
			MultipartFile updateProjectFile = (MultipartFile) paramMap.get("updateLearnMaterialsFile");
			
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
			
			 result = tutorLearnMaterialsDao.updateLearnMat(paramMap);
			 
				if (result > 0) {
					File dest = new File(updateFilePath);
					updateProjectFile.transferTo(dest);
					status = true;
				} 
		}
		
		return status;
	}

	// 학습자료 삭제
	@Override
	public Boolean deleteLearnMat(int learnMatId) throws Exception {
		
		int result = tutorLearnMaterialsDao.deleteLearnMat(learnMatId);
		
		Boolean status = false;
		
		if(result > 0) {
			status = true;
		} 
		
		return status;
	}
}
