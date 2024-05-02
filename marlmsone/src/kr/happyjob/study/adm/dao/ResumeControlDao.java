package kr.happyjob.study.adm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.AdmLectureDto;
import kr.happyjob.study.adm.model.StudentResumeDto;

public interface ResumeControlDao {
	
	public List<AdmLectureDto> getAllLectureList(Map<String, Object> paramMap);
	public int lectureListTotalCount();
	
	public List<StudentResumeDto> getStudentResumeList(String lectureId);
	public int studentResumeTotalCount(String lectureId);
	
	public StudentResumeDto getStudentResume(Map<String, Object> param);
}
