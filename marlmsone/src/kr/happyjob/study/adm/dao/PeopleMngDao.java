package kr.happyjob.study.adm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.PeopleMngModel;

public interface PeopleMngDao {
	/* 공통 */
	
	// 회원 탈퇴
	public int ban_user(Map<String,Object> paramMap);

	// 회원 정보 조회
	public PeopleMngModel user_info(Map<String,Object> paramMap);
	
	/* 학생 */
	
	// 강의 리스트 조회
	public List<PeopleMngModel> lec_list(Map<String, Object> paramMap);
	
	// 강의 수 조회
	public int countList_lec(Map<String,Object> paramMap);
	
	// 학생 목록 조회
	public List<PeopleMngModel> std_list(Map<String,Object> paramMap);
	
	// 학생 수 조회
	public int countList_std(Map<String,Object> paramMap);
	
	// 학생 수강 목록 조회
	public List<PeopleMngModel> std_lec_info(Map<String,Object> paramMap);
	
	// 학생 수강 강의 수 조회
	public int std_lec_count(Map<String,Object> paramMap);
	
	// 학생 수강 신청
	public int std_lec_reg(Map<String,Object> paramMap);
	
	// 학생 수강 취소
	public int std_lec_del(Map<String,Object> paramMap);
	
	// 수강 인원 증가
	public void plusPrePnum(Map<String,Object> paramMap);
	
	// 수강 인원 감소
	public void minusPrePnum(Map<String,Object> paramMap);

	
	/* 강사 */
	
	// 강사 목록 조회
	public List<PeopleMngModel> tut_list(Map<String,Object> paramMap);
	
	// 강사 수 조회
	public int countList_tut(Map<String,Object> paramMap);

	// 강사 승인
	public int apv_tut(Map<String,Object> paramMap);
	
	// 강사 강의 목록 조회
	public List<PeopleMngModel> tlec_list(Map<String,Object> paramMap);
	
	// 강사 강의 수 조회
	public int tut_lec_count(Map<String,Object> paramMap);
	
	

}
