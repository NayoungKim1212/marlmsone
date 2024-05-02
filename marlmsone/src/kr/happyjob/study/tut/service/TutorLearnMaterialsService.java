package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.TutorLearningMaterials;
import kr.happyjob.study.tut.model.TutorLectureDto;

public interface TutorLearnMaterialsService {

	//과제 리스트 불러오기
	public List<TutorLearningMaterials> getTutorLearnMatList(Map<String, Object> paramMap) throws Exception;
	public int learnMatTotalCount(Map<String, Object> paramMap) throws Exception;
	
	//과제 디테일 데이터 불러오기
	public TutorLearningMaterials getDetailLearnMat(int param) throws Exception;
	
	// 과제 등록
	public int insert_learningMaterials(Map<String, Object> paramMap) throws Exception;
	
	// 강의리스트 불러오기
	public List<TutorLectureDto> getLectureList(String tutorId) throws Exception;
	
	// 과제 수정
	public Boolean updateLearnMat(Map<String, Object> paramMap) throws Exception;
	
	// 과제 삭제
	public Boolean deleteLearnMat(int learnMatId) throws Exception;
		
}
