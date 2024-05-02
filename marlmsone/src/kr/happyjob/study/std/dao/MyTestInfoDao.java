package kr.happyjob.study.std.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.std.model.MyTestInfoVo;
import kr.happyjob.study.std.model.TestDetailVo;
import kr.happyjob.study.std.model.TestUserVo;
import kr.happyjob.study.std.model.TestResultVo;


public interface MyTestInfoDao {

	/** 나의 시험응시 목록 조회 */
	public List<MyTestInfoVo> myTestList(Map<String, Object> paramMap) throws Exception;
	
	/** 나의 시험응시 목록 카운트 조회 */
	public int myTestListCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 나의 시험문제 항목 조회 */
	public List<TestDetailVo> testItemList(Map<String, Object> paramMap) throws Exception;
	
	/** 나의 시험문제 항목 카운트 조회 */
	public int testItemListCnt(Map<String, Object> paramMap) throws Exception;

	/** 시험응시 결과 등록  */	
	public int registerTestUser(Map<String, Object> paramMap) throws Exception;
	
	/** 시험응시 상세결과 등록 */	
	public int registerTestResult(Map<String, Object> paramMap) throws Exception;
	
	/** 시험 응시여부 컬럼 업데이트 */	
	public int updateLecStdInfoTestYn(Map<String, Object> paramMap) throws Exception;
	
	/** 시험응시 결과 조회  */	
	public TestUserVo searchTestUser(Map<String, Object> paramMap) throws Exception;
	
	/** 시험응시 상세결과 조회 */	
	public List<TestResultVo> searchTestResult(Map<String, Object> paramMap) throws Exception;
	
	/** 시험응시 상세결과 카운트 조회 */	
	public int searchTestResultCnt(Map<String, Object> paramMap) throws Exception;
}