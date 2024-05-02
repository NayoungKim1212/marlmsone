package kr.happyjob.study.tut.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.TutorLearningMaterials;
import kr.happyjob.study.tut.model.TutorLectureDto;

public interface TutorLearnMaterialsDao {
	
	// 학습자료 리스트 불러오기
	public List<TutorLearningMaterials> getTutorLearnMatList(Map<String, Object> paramMap);
	
	// 학습자료 총 갯수
	public int learnMatTotalCount(Map<String, Object> paramMap);
	
	//학습자료 등록하기
	public int insertLearnMaterials(TutorLearningMaterials learningMaterials);
	
	//학습자료 디테일 데이터 불러오기
	public TutorLearningMaterials getDetailLearnMat(int param);
	
	// 강의리스트 불러오기
	public List<TutorLectureDto> getLectureList(String tutorId);
	
	// 학습자료 수정
	public int updateLearnMat(Map<String, Object> paramMap);

	// 학습자료 삭제
	public int deleteLearnMat(int learnMatId);
}
