package kr.happyjob.study.surveyMgt.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.surveyMgt.model.SurveyMgtVo;

public interface SrvyMgtService {
	
	/** 목록 조회 */
	public List<SurveyMgtVo> selectSrvyMgtList(Map<String, Object> paramMap) throws Exception;
	public List<SurveyMgtVo> selectSrvyMgtTutorList(Map<String, Object> paramMap) throws Exception;
	/** 카운트 조회 */
	public int srvyMgtCnt(Map<String, Object> paramMap) throws Exception;
	public int srvyMgtTutorCnt(Map<String, Object> paramMap) throws Exception;
	/** 상세 목록 조회 */
	public List<SurveyMgtVo> detailSrvyList(Map<String, Object> paramMap) throws Exception;
	public List<SurveyMgtVo> detailSrvyTutorNmList(Map<String, Object> paramMap) throws Exception;
	/** 상세 목록 카운트 조회 */
	public int detailSrvyCnt(Map<String, Object> paramMap) throws Exception;
	public int detailTutorNameSrvyCnt(Map<String, Object> paramMap) throws Exception;
	/** 설문조사 결과 조회 */
	public List<SurveyMgtVo> srvyResult(Map<String, Object> paramMap) throws Exception;
	public List<SurveyMgtVo> srvyResultLast(Map<String, Object> paramMap) throws Exception;
	


}
