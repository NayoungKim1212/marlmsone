package kr.happyjob.study.notice.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.notice.model.Noticevo;

public interface NoticeDao {

	/** 목록 조회 */
	public List<Noticevo> noticelist(Map<String, Object> paramMap) throws Exception;
	
	/** 카운트 조회 */
	public int noticecnt(Map<String, Object> paramMap) throws Exception;
	
	/** 파일 신규 공지 등록*/
	public int noticeSave(Map<String, Object> paramMap) throws Exception;
	
	/**삭제*/
	public int noticeDelete(Map<String, Object> paramMap) throws Exception;

	/** 파일  공지 수정 */
	public int noticeupdate(Map<String, Object> paramMap) throws Exception;
	
	/** 조회수 수정 */
	public void noticehitupdate(Map<String, Object> paramMap) throws Exception;
	
	
	/** 상세 조회 */
	public Noticevo noticeView(Map<String, Object> paramMap) throws Exception;
	
	/**수정*/
	public int noticeModify(Map<String, Object> paramMap) throws Exception;
}
