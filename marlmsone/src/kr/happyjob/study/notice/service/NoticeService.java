package kr.happyjob.study.notice.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.notice.model.Noticevo;

public interface NoticeService {

	/** 목록 조회 */
	public List<Noticevo> noticelist(Map<String, Object> paramMap) throws Exception;
	
	/** 카운트 조회 */
	public int noticecnt(Map<String, Object> paramMap) throws Exception;
	
	/** 파일 o 신규 공지 등록 
	 * 	파일정보를 받기 위한 request */
	public int noticeSave(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	/**삭제*/
	public int noticeDelete(Map<String, Object> paramMap) throws Exception;

	
	/** 조회수 수정 */
	public void noticehitupdate(Map<String, Object> paramMap) throws Exception;
	
	
	/** 상세 조회 */
	public Noticevo noticeView(Map<String, Object> paramMap) throws Exception;
	
	
	/** 수정*/
	/** 파일 o 신규 공지 등록 
	 * 	파일정보를 받기 위한 request */
	public int noticeModify(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
}
