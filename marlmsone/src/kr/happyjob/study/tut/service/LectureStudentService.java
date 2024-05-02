package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.LectureStudentDto;
import kr.happyjob.study.tut.model.TutorLectureDto;

public interface LectureStudentService {
	
	// 강사 강의 리스트
	public List<TutorLectureDto> getLectureList(Map<String, Object> paramMap) throws Exception;
	// 강의 수
	public int tutorLectureTotalCount(Map<String, Object> paramMap) throws Exception;
	// 강의 상세 정보
	public TutorLectureDto getDetailTutorLecture(Map<String, Object> paramMap) throws Exception;
	
	// 수강생 리스트
	public List<LectureStudentDto> getLectureStudentList(Map<String, Object> paramMap) throws Exception;
	// 수강생 수
	public int lectureStudentTotalCount(Map<String, Object> paramMap) throws Exception;
	// 수강생 상세정보
	public List<LectureStudentDto> getDetailLectureStudent(Map<String, Object> paramMap) throws Exception;
	
	public Boolean approveLectureStudent(Map<String, Object> paramMap) throws Exception;
	public Boolean cancleLectureStudent(Map<String, Object> paramMap) throws Exception;
}
