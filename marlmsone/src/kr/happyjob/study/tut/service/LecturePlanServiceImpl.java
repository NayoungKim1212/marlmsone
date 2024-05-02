package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.tut.dao.LecturePlanDao;
import kr.happyjob.study.tut.model.LecturePlanModel;
import kr.happyjob.study.tut.model.LectureRoomModel;

@Service
public class LecturePlanServiceImpl implements LecturePlanService{
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	LecturePlanDao lecturePlanDao;

	// 강의 목록 조회
	@Override
	public List<LecturePlanModel> tutorLecList(Map<String, Object> paramMap) {
		return lecturePlanDao.tutorLecList(paramMap);
	}

	// 강의 수 조회
	@Override
	public int countLecList(Map<String, Object> paramMap) {
		return lecturePlanDao.countLecList(paramMap);
	}
	
	// 강의 분류명 조회
	@Override
	public List<LecturePlanModel> lecTypeList(Map<String, Object> paramMap) {
		return lecturePlanDao.lecTypeList(paramMap);
	}	
	
	// 강의실 목록 조회
	@Override
	public List<LectureRoomModel> room_name(Map<String, Object> paramMap) {
		return lecturePlanDao.room_name(paramMap);
	}
	
	// 개별 강의 정보 조회
	@Override
	public LecturePlanModel plan_one(Map<String, Object> paramMap) {
		return lecturePlanDao.plan_one(paramMap);
	}

	// 주차별 강의 계획 조회
	@Override
	public List<LecturePlanModel> week_list(Map<String, Object> paramMap) {
		return lecturePlanDao.week_list(paramMap);
	}

	// 강의계획서 저장
	@Override
	public int plan_register(Map<String, Object> paramMap) {
		return lecturePlanDao.plan_register(paramMap);
	}

	// 주간계획서 저장
	@Override
	public int week_register(Map<String, Object> paramMap) {
		return lecturePlanDao.week_register(paramMap);
	}

	// 주간계획서 삭제
	@Override
	public int week_del(Map<String, Object> paramMap) {
		return lecturePlanDao.week_del(paramMap);
	}
	
	// 주간계획서 수정
	@Override
	public int week_up(Map<String, Object> paramMap) {
		return lecturePlanDao.week_up(paramMap);
	}

	// 주간계획서 갯수 조회
	@Override
	public int chk_week(Map<String, Object> paramMap) {
		return lecturePlanDao.chk_week(paramMap);
	}

	// 모달창 강의 목록 조회
	@Override
	public List<LecturePlanModel> mlec_list(Map<String, Object> paramMap) {
		return lecturePlanDao.mlec_list(paramMap);
	}
	
	

	


}

