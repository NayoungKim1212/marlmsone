package kr.happyjob.study.test.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.test.dao.TestDao;
import kr.happyjob.study.test.model.TestModel;

@Service
public class TestSeriveImpl implements TestService {
	
	@Autowired
	TestDao testDao;
	
	/* 시험등록 저장저장 */
	public int saveActive(Map<String, Object> paramMap){
		return testDao.insertTestData(paramMap);
	}
	
	/* 시험리스트 목록 및 조회 */
	public List<TestModel> getListData(Map<String, Object> paramMap) {
		return testDao.getListData(paramMap);
	}

	public int testListCnt(Map<String, Object> paramMap) {
		return testDao.testListCnt(paramMap);
	}

	
	/* 시험등록 비활성화 */
	public int testDeactivate(Map<String, Integer> resultMap) {
		return testDao.testDeactivate(resultMap);
	}
	
	
	/* 시험등록 수정조회 */
	
	public TestModel testModifyList(Map<String, Object> paramMap) {
		return testDao.testModifyList(paramMap);
	}

	
	
	/* 시험등록 수정하기 */	
	public int testModify(Map<String, Object> paramMap) {
		return testDao.testModify(paramMap);
	}

    /* 시험 분류 목록  */
	public List<TestModel> lectureListData(Map<String, Object> paramMap) {
		return testDao.lectureListData(paramMap);
	}
	
	

	
	


}
