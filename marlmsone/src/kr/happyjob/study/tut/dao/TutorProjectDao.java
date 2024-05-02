package kr.happyjob.study.tut.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.StudentProjectDto;
import kr.happyjob.study.tut.model.TutorLearningMaterials;
import kr.happyjob.study.tut.model.TutorProjectDto;

public interface TutorProjectDao {

	// 과제정보 리스트 가져오기
	public List<TutorProjectDto> getTutorProjectList(Map<String, Object> paramMap);
	
	// 과제정보 총 갯수
	public int tutorProjectTotalCount(Map<String, Object> paramMap);
	
	//과제정보 디테일
	public TutorProjectDto getDetailTutorProject(int param);
	
	//과제등록
	public int insertTutorProejct(TutorProjectDto tutorProjectDto);
	
	//과제 수정
	public int updateTutorProject(Map<String, Object> paramMap);
	
	//과제 삭제
	public int deleteTutorProject(int projectId);
	
	public List<StudentProjectDto> getStudentProjectList(int projectId);
	public StudentProjectDto getStudentProject(String submitId);
	
}
