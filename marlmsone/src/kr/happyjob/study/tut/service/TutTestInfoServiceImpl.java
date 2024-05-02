package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.std.dao.MyTestInfoDao;
import kr.happyjob.study.tut.dao.TutTestInfoDao;

import kr.happyjob.study.std.model.MyTestInfoVo;
import kr.happyjob.study.std.model.TestDetailVo;
import kr.happyjob.study.std.model.TestUserVo;
import kr.happyjob.study.tut.model.TutTestInfoVo;
import kr.happyjob.study.std.model.TestResultVo;

@Service
public class TutTestInfoServiceImpl implements TutTestInfoService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	MyTestInfoDao myTestInfoDao;
	
	@Autowired
	TutTestInfoDao tutTestInfoDao;
	
	
	/** 강사의 시험출제 목록 조회 */
	@Override
	public List<TutTestInfoVo> tutTestList(Map<String, Object> paramMap) throws Exception {
		return tutTestInfoDao.tutTestList(paramMap);
	}

	/** 강사의 시험출제 목록 카운트 조회 */
	@Override
	public int tutTestListCnt(Map<String, Object> paramMap) throws Exception {
		return tutTestInfoDao.tutTestListCnt(paramMap);
	}
	
	/** 시험지 생성 (문제은행 추출) */
	@Override
	public List<TestDetailVo> generateTest(Map<String, Object> paramMap) throws Exception {
		return tutTestInfoDao.generateTest(paramMap);
	}

	/** 시험지 등록 */
	@Override
	public int registerTest(Map<String, Object> paramMap) throws Exception {
		
		int listCnt = (int) paramMap.get("listCnt");
		int test_id, test_num = 1;
		int result = 0;
		
		paramMap.put("lec_type_id", Integer.valueOf((String)paramMap.get("lec_type_id")));
		
		logger.info(paramMap.get("lec_id"));
		logger.info(paramMap.get("lec_type_id"));
		logger.info(paramMap.get("test_name"));
		logger.info(paramMap.get("generate_cnt"));

		logger.info(paramMap.get("lec_id").getClass());
		logger.info(paramMap.get("lec_type_id").getClass());
		logger.info(paramMap.get("test_name").getClass());
		logger.info(paramMap.get("generate_cnt").getClass());
		logger.info(paramMap.get("test_start").getClass());

		// 시험지 마스터정보 등록
		result = tutTestInfoDao.registerTestMaster(paramMap);
		logger.info(paramMap.get("test_id"));
		
		if ( result > 0 ) {
			
			test_id = (int)paramMap.get("test_id");
			
			List<TestDetailVo> testData = (List<TestDetailVo>)paramMap.get("listData");
			for (TestDetailVo data : testData) {
				
				paramMap.put("test_id", test_id);
				paramMap.put("que_id", data.getQue_id());
				paramMap.put("test_num", test_num++);
				
				// 시험지 상세정보 등록
				tutTestInfoDao.registerTestDetail(paramMap);
			}
			// 강의정보 테이블의 시험정보 컬럼 업데이트
			tutTestInfoDao.updateLecTestInfo(paramMap);
		}
		
		return result;
	}
	
	/** 시험지 상세보기 */
	@Override
	public List<TestDetailVo> tutTestDetail(Map<String, Object> paramMap) throws Exception {
		return tutTestInfoDao.tutTestDetail(paramMap);
	}
	
	
	
	
	
	
	/** 나의 시험응시 목록 조회 */
	@Override
	public List<MyTestInfoVo> myTestList(Map<String, Object> paramMap) throws Exception {	
		return myTestInfoDao.myTestList(paramMap);
	}
	
	/** 나의 시험응시 목록 카운트 조회 */
	@Override
	public int myTestListCnt(Map<String, Object> paramMap) throws Exception {
		return myTestInfoDao.myTestListCnt(paramMap);
	}
	
	/** 나의 시험문제 항목 조회 */
	@Override
	public List<TestDetailVo> testItemList(Map<String, Object> paramMap) throws Exception {
		return myTestInfoDao.testItemList(paramMap);		
	}
	
	/** 나의 시험문제 항목 카운트 조회 */
	@Override
	public int testItemListCnt(Map<String, Object> paramMap) throws Exception {
		return myTestInfoDao.testItemListCnt(paramMap);
	}
	
	/** 시험응시(제출) */	
	@Override
	public int submitTest(Map<String, Object> paramMap) throws Exception {

		int listCnt = Integer.valueOf((String)paramMap.get("listCnt"));
		double sumScore = 0; 						// 총 점수
		double popScore = (100/(double)listCnt); 	// 개당 점수
		String pass = "";							// pass 여부 (P:합격/F:불합격)

		for(int i=0; i<listCnt; i++) {			
			logger.info("학생답 : " + paramMap.get("submit_answer"+(i+1)) + ", 정답 : " + paramMap.get("answer"+(i+1)));
			
			if(paramMap.get("submit_answer"+(i+1)).equals(paramMap.get("answer"+(i+1)))) {
				logger.info(" - 정답입니다");
				
				sumScore += popScore;				
			} else {
				logger.info(" - 오답입니다");				
			}				
		}
		
		// 총점수에 따라 pass여부 넣어줌
		if (sumScore >= 60) {
			pass = "P";			
		} else {
			pass = "F";
		}
		
		paramMap.put("test_score", sumScore);
		paramMap.put("pass", pass);
		
		int result = myTestInfoDao.registerTestUser(paramMap);		
		
		for(int i = 0; i < listCnt; i++) {			
			paramMap.put("test_num", paramMap.get("test_num"+(i+1)));
			paramMap.put("answer", paramMap.get("answer"+(i+1)));
			paramMap.put("submit_answer", paramMap.get("submit_answer"+(i+1)));
			
			
			if(paramMap.get("submit_answer"+(i+1)).equals(paramMap.get("answer"+(i+1)))) {			
				paramMap.put("chk_answer", "C");
			} else {				
				paramMap.put("chk_answer", "W");
			}
			
			myTestInfoDao.registerTestResult(paramMap);
		}
		if ( result > 0 ) {
			myTestInfoDao.updateLecStdInfoTestYn(paramMap);
		}
		
		return result;		
	}	
	
	/** 시험응시 결과 조회  */
	@Override
	public TestUserVo searchTestUser(Map<String, Object> paramMap) throws Exception {
		return myTestInfoDao.searchTestUser(paramMap);
		
	}
	
	/** 시험응시 상세결과 조회 */
	@Override
	public List<TestResultVo> searchTestResult(Map<String, Object> paramMap) throws Exception {		
		return myTestInfoDao.searchTestResult(paramMap);		
	}
	
	/** 시험응시 상세결과 카운트 조회 */
	public int searchTestResultCnt(Map<String, Object> paramMap) throws Exception {
		return myTestInfoDao.searchTestResultCnt(paramMap);
	}	
}
