package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.std.model.SubmittedWorkVo;

public interface SubmittedWorkService {

	
	/** 과제 리스트 조회 */
	public List<SubmittedWorkVo> submitList(Map<String, Object> paramMap) throws Exception;

	/** 카운트 조회 */
	public int submitcnt(Map<String, Object> paramMap) throws Exception;
	
	
	/** 과제 등록*/
	public int submitSave(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	/** 개별조회 (업로드 파일 가져오기) */
	public SubmittedWorkVo getFile(Map<String, Object> paramMap) throws Exception;

	/** 과제수정*/
	public int submitModify(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
}
