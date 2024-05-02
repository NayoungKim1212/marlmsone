package kr.happyjob.study.std.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.std.model.SubmittedWorkVo;

public interface SubmittedWorkDao {

	
	/** 과제 리스트 조회 */
	public List<SubmittedWorkVo> submitList(Map<String, Object> paramMap) throws Exception;
	
	/** 과제리스트 카운트 조회 */
	public int submitcnt(Map<String, Object> paramMap) throws Exception;
	
	/** 과제 제출 여부 확인*/
	public int cnt(Map<String, Object> paramMap) throws Exception;
	
	/** 과제 등록*/
	public int submitSave(Map<String, Object> paramMap) throws Exception;
	
	/** 개별조회 (업로드 파일 가져오기)*/
	public SubmittedWorkVo getFile(Map<String, Object> paramMap) throws Exception;
	
	/** 과제 수정*/
	public int submitModify(Map<String, Object> paramMap) throws Exception;
	
}
