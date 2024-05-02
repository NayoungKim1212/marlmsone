package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.tut.dao.LectureStudentInfoDao;
import kr.happyjob.study.tut.model.LectureStudentDto;
import kr.happyjob.study.tut.model.TutorLectureDto;


@Service
public class LectureStudentServiceImpl implements LectureStudentService{
	
	@Autowired
	LectureStudentInfoDao lectureStudentInfoDao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// 강사 강의 리스트
	@Override
	public List<TutorLectureDto> getLectureList(Map<String, Object> paramMap) throws Exception {
		
		return lectureStudentInfoDao.getLectureList(paramMap);
	}
	
	// 강의 상세 정보
	@Override
	public TutorLectureDto getDetailTutorLecture(Map<String, Object> paramMap) throws Exception {
		
		return lectureStudentInfoDao.getDetailTutorLecture(paramMap);
	}
	
	// 해당 강사의 강의 수
	@Override
	public int tutorLectureTotalCount(Map<String, Object> paramMap) throws Exception {
		
		return lectureStudentInfoDao.lectureTotalCount(paramMap);
	}

	// 수강생 리스트
	@Override
	public List<LectureStudentDto> getLectureStudentList(Map<String, Object> paramMap) throws Exception {
		
		return lectureStudentInfoDao.getLectureStudentList(paramMap);
	}

	// 수강생 수
	@Override
	public int lectureStudentTotalCount(Map<String, Object> paramMap) throws Exception {
		
		return lectureStudentInfoDao.lectureStudentTotalCount(paramMap);
	}

	//수강생 상세정보
	@Override
	public List<LectureStudentDto> getDetailLectureStudent(Map<String, Object> paramMap) throws Exception {
		
		return lectureStudentInfoDao.getDetailLectureStudent(paramMap);
	}

	@Override
	public Boolean approveLectureStudent(Map<String, Object> paramMap) throws Exception {
		
		Boolean status = false;
		int result = 0;
		
		result = lectureStudentInfoDao.approveLectureStudent(paramMap);
		
		if(result > 0) {
			status = true;
		}
		
		return status;
	}

	@Override
	public Boolean cancleLectureStudent(Map<String, Object> paramMap) throws Exception {
		Boolean status = false;
		int result = 0;
		
		result = lectureStudentInfoDao.cancleLectureStudent(paramMap);
		
		if(result > 0) {
			status = true;
		}
		
		return status;
	}





}
