package kr.happyjob.study.adm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.ResumeControlDao;
import kr.happyjob.study.adm.model.AdmLectureDto;
import kr.happyjob.study.adm.model.StudentResumeDto;

@Service
public class ResumeControlServiceImpl implements ResumeControlService{

	@Autowired
	ResumeControlDao resumeControlDao;
	
	@Override
	public List<AdmLectureDto> getAllLectureList(Map<String, Object> paramMap) throws Exception {
		
		return resumeControlDao.getAllLectureList(paramMap);
	}

	@Override
	public int lectureListTotalCount() throws Exception {
		
		return resumeControlDao.lectureListTotalCount();
	}

	@Override
	public List<StudentResumeDto> getStudentResumeList(String lectureId) throws Exception {
		
		return resumeControlDao.getStudentResumeList(lectureId);
	}

	@Override
	public int studentResumeTotalCount(String lectureId) throws Exception {
		
		return resumeControlDao.studentResumeTotalCount(lectureId);
	}

	@Override
	public StudentResumeDto getStudentResume(String lectureId, String studentId) throws Exception {
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("lectureId", lectureId);
		param.put("studentId", studentId);
		
		return resumeControlDao.getStudentResume(param);
	}

}
