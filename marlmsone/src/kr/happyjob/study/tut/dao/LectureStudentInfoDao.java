package kr.happyjob.study.tut.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.LectureStudentDto;
import kr.happyjob.study.tut.model.TutorLectureDto;

public interface LectureStudentInfoDao {
	
	//강사 강의 리스트
	public List<TutorLectureDto> getLectureList(Map<String, Object> paramMap);
	// 강사 강의 총 갯수
	public int lectureTotalCount(Map<String, Object> paramMap);
	public TutorLectureDto getDetailTutorLecture(Map<String, Object> paramMap);
	
	//수강생 리스트
	public List<LectureStudentDto> getLectureStudentList(Map<String, Object> paramMap);
	//수강생 수
	public int lectureStudentTotalCount(Map<String, Object> paramMap);
	public List<LectureStudentDto> getDetailLectureStudent(Map<String, Object> paramMap);
	
	public int approveLectureStudent(Map<String, Object> paramMap);
	public int cancleLectureStudent(Map<String, Object> paramMap);
}
