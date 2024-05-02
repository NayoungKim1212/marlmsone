package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.AdmLectureDto;
import kr.happyjob.study.adm.model.StudentResumeDto;

public interface ResumeControlService {
	
	public List<AdmLectureDto> getAllLectureList(Map<String, Object> paramMap) throws Exception;
	public int lectureListTotalCount() throws Exception;

	public List<StudentResumeDto> getStudentResumeList(String lectureId) throws Exception;
	public int studentResumeTotalCount(String lectureId) throws Exception;
	
	public StudentResumeDto getStudentResume(String lectureId, String studentId) throws Exception;
}
