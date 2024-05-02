package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.StudentProjectDto;
import kr.happyjob.study.tut.model.TutorLearningMaterials;
import kr.happyjob.study.tut.model.TutorProjectDto;

public interface TutorProjectService {

	// 과제정보 리스트 가져오기
	public List<TutorProjectDto> getTutorProjectList(Map<String, Object> paramMap) throws Exception;
	// 과제정보 총 갯수
	public int tutorProjectTotalCount(Map<String, Object> paramMap) throws Exception;
	//과제정보 디테일
	public TutorProjectDto getDetailTutorProject(int param) throws Exception;
	
	//과제 등록
	public int insertTutorProject(Map<String, Object> paramMap) throws Exception;
	
	//과제 수정
	public Boolean updateTutorProject(Map<String, Object> paramMap) throws Exception;
	
	//과제 삭제
	public Boolean deleteTutorProject(int projectId) throws Exception;
	
	public List<StudentProjectDto> getStudentProjectList(int projectId) throws Exception;
	public StudentProjectDto getStudentProject(String submitId) throws Exception;
	
}
