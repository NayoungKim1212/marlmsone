package kr.happyjob.study.surveyMgt.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.surveyMgt.dao.SurveyMgtDao;
import kr.happyjob.study.surveyMgt.model.SurveyMgtVo;

@Service
public class SrvyMgtServiceImpl implements SrvyMgtService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	SurveyMgtDao surveyMgtDao;
	
	/** 목록 조회 */
	public List<SurveyMgtVo> selectSrvyMgtList(Map<String , Object> paramMap) throws Exception {
		
		logger.info("=====START selectSrvyMgtList");
		
		List<SurveyMgtVo> srvyList = surveyMgtDao.selectSrvyMgtList(paramMap);

		logger.info("=====END selectSrvyMgtList");
		
		return srvyList;
	}

	public List<SurveyMgtVo> selectSrvyMgtTutorList(Map<String, Object> paramMap) throws Exception {
		List<SurveyMgtVo> srvyTutorList = surveyMgtDao.selectSrvyMgtTutorList(paramMap);
		return srvyTutorList;
	}

	

	/** 카운트 조회 */
	public int srvyMgtCnt(Map<String, Object> paramMap) throws Exception {
		int totalCnt = surveyMgtDao.srvyMgtCnt(paramMap);
		return totalCnt;
	}

	public List<SurveyMgtVo> detailSrvyTutorNmList(Map<String, Object> paramMap) throws Exception {
		List<SurveyMgtVo> srvyNameList = surveyMgtDao.detailSrvyTutorNmList(paramMap);
		return srvyNameList;
	}
	
	public List<SurveyMgtVo> detailSrvyList(Map<String, Object> paramMap) throws Exception {
		List<SurveyMgtVo> srvyList = surveyMgtDao.detailSrvyList(paramMap);
		return srvyList;
	}

	public int detailSrvyCnt(Map<String, Object> paramMap) throws Exception {
		int detailTotalCnt = surveyMgtDao.detailSrvyCnt(paramMap);
		return detailTotalCnt;
	}

	public int detailTutorNameSrvyCnt(Map<String, Object> paramMap) throws Exception {
		int detailTutorNameSrvyCnt = surveyMgtDao.detailTutorNameSrvyCnt(paramMap);
		return detailTutorNameSrvyCnt;
	}
	
	public List<SurveyMgtVo> srvyResult(Map<String, Object> paramMap) throws Exception {
		List<SurveyMgtVo> srvyResult = surveyMgtDao.srvyResult(paramMap);
		return srvyResult;
	}

	public List<SurveyMgtVo> srvyResultLast(Map<String, Object> paramMap) throws Exception {
		List<SurveyMgtVo> srvyResultLast = surveyMgtDao.srvyResultLast(paramMap);
		return srvyResultLast;
	}

	public int srvyMgtTutorCnt(Map<String, Object> paramMap) throws Exception {
		int TutorSrvyCnt = surveyMgtDao.srvyMgtTutorCnt(paramMap);
		return TutorSrvyCnt;
	}

}
