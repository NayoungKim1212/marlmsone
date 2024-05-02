package kr.happyjob.study.adv.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adv.model.AdviceVo;
import kr.happyjob.study.adv.model.LecInfoVo;
/*import kr.happyjob.study.notice.model.Noticevo;*/
import kr.happyjob.study.adv.model.LecStdInfoVo;

public interface AdviceDao {

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
}
