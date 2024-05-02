package kr.happyjob.study.tut.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.LecturePlanModel;
import kr.happyjob.study.tut.model.LectureRoomModel;

public interface LecturePlanDao {
	
	// 강의 목록 조회
	public List<LecturePlanModel> tutorLecList(Map<String,Object> paramMap);

	// 강의 수 조회
	public int countLecList(Map<String, Object> paramMap);
	
	// 강의 분류명 조회
	public List<LecturePlanModel> lecTypeList(Map<String,Object> paramMap);

	// 강의실 목록 조회
	public List<LectureRoomModel> room_name(Map<String,Object> paramMap);

	// 개별 강의 정보 조회
	public LecturePlanModel plan_one(Map<String,Object> paramMap);
	
	// 주차별 강의 계획 조회
	public List<LecturePlanModel> week_list(Map<String,Object> paramMap);
	
	// 계획서 저장
	public int plan_register(Map<String,Object> paramMap);
	
	// 주간계획서 저장
	public int week_register(Map<String,Object> paramMap);
	
	// 주간계획서 삭제
	public int week_del(Map<String,Object> paramMap);
	
	// 주간계획서 수정
	public int week_up(Map<String,Object> paramMap);
	
	// 주간계획서 갯수 조회
	public int chk_week(Map<String,Object> paramMap);
	
	// 모달창 강의 목록 조회
	public List<LecturePlanModel> mlec_list(Map<String,Object> paramMap);
	
	
}

