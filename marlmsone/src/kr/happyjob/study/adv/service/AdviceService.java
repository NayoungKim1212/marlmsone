package kr.happyjob.study.adv.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adv.model.AdviceVo;
import kr.happyjob.study.adv.model.LecInfoVo;
import kr.happyjob.study.adv.model.LecStdInfoVo;

public interface AdviceService {
	
	/** 강의 목록 조회 */
	public List<LecInfoVo> lecList(Map<String, Object> paramMap) throws Exception;
	
	/** 강의 목록 카운트 조회 */
	public int lecListCnt(Map<String, Object> paramMap) throws Exception;

	/** 상담 목록 조회 */
	public List<AdviceVo> advList(Map<String, Object> paramMap) throws Exception;
	
	/** 상담 목록 카운트 조회 */
	public int advListCnt(Map<String, Object> paramMap) throws Exception;

	/** 상담 상세보기 */
	public AdviceVo advDetail(Map<String, Object> paramMap) throws Exception;
	
	/** 강의 수강 학생 목록 조회 */
	public List<LecStdInfoVo> lecStdList(Map<String, Object> paramMap) throws Exception;
	
	/** 강의 수강 학생 목록 카운트 조회 */
	public int lecStdListCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 상담 등록 */
	public int advRegister(Map<String,Object> paramMap);
	
	/** 상담 수정 */
	public int advUpdate(Map<String,Object> paramMap);
	
	/** 상담 삭제 */
	public int advDelete(Map<String,Object> paramMap);
	
	
	
	/** 목록 조회 *//*
	public List<Noticevo> noticelist(Map<String, Object> paramMap) throws Exception;
	
	*//** 카운트 조회 *//*
	public int noticecnt(Map<String, Object> paramMap) throws Exception;
	
	*//** 파일 x 신규 공지 등록 *//*
	public int noticesave(Map<String, Object> paramMap) throws Exception;

	*//** 파일 x 공지 수정 *//*
	public int noticeupdate(Map<String, Object> paramMap) throws Exception;
	
	*//** 조회수 수정 *//*
	public int noticehitupdate(Map<String, Object> paramMap) throws Exception;
	
	*//** 파일 x 공지 삭제 *//*
	public int noticedelete(Map<String, Object> paramMap) throws Exception;
	
	*//** 상세 조회 *//*
	public Noticevo noticedtl(Map<String, Object> paramMap) throws Exception;
	*/
}
