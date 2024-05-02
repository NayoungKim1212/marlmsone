package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.std.dao.MyLecInfoDao;
import kr.happyjob.study.std.model.MyLecInfoVo;
import kr.happyjob.study.std.model.SurveyInfoVo;

@Service
public class MyLecInfoServiceImpl implements MyLecInfoService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	MyLecInfoDao myLecInfoDao;

	
	/** 나의 수강목록 조회 */
	@Override
	public List<MyLecInfoVo> myLecList(Map<String, Object> paramMap) throws Exception {
		
		logger.info("   - paramMap : " + paramMap);

		return myLecInfoDao.myLecList(paramMap);
	}
	
	/** 나의 수강목록 카운트 조회 */
	@Override
	public int myLecListCnt(Map<String, Object> paramMap) throws Exception {
		return myLecInfoDao.myLecListCnt(paramMap);
	}
	
	/** 나의 수강목록 상세보기 */
	@Override
	public List<MyLecInfoVo> myLecDetail(Map<String, Object> paramMap) throws Exception {
		return myLecInfoDao.myLecDetail(paramMap);		
	}
	
	/** 나의 수강목록 상세보기 카운트 조회 */
	public int myLecDetailCnt(Map<String, Object> paramMap) throws Exception {
		return myLecInfoDao.myLecDetailCnt(paramMap);
	}
	
	/** 설문조사 문항 조회 */
	public List<SurveyInfoVo> surveyItemList(Map<String, Object> paramMap) throws Exception {
		return myLecInfoDao.surveyItemList(paramMap);
	}
	
	/** 설문조사 문항 카운트 조회 */
	public int surveyItemListCnt(Map<String, Object> paramMap) throws Exception {
		return myLecInfoDao.surveyItemListCnt(paramMap);
	}
	
	/** 설문조사 제출 */	
	@Override
	public int submitSurvey(Map<String, Object> paramMap) throws Exception {

		int listCnt = Integer.valueOf((String)paramMap.get("listCnt"));
		int lec_id, que_num, review_num;
		int result = 0;

		lec_id = Integer.valueOf((String)paramMap.get("lec_id"));
		paramMap.put("lec_id", lec_id);
				
		for(int i = 0; i < listCnt; i++) {
			
			que_num = Integer.valueOf((String)paramMap.get("que_num"+(i)));
			paramMap.put("que_num", que_num);
			
			if(paramMap.get("survey_answer"+(i)) != null) {
				
				review_num = Integer.valueOf((String)paramMap.get("survey_answer"+(i)));
				paramMap.put("review_num", review_num);
				result = myLecInfoDao.registerSurveyResponse(paramMap);				

			} else if(paramMap.get("survey_review") != null) {
				
				paramMap.put("review", paramMap.get("survey_review"));
				result = myLecInfoDao.registerSurveyResponse(paramMap);
			}
		}
		
		myLecInfoDao.updateLecStdInfoSrvyYn(paramMap);
		
		return result;
	}
}
