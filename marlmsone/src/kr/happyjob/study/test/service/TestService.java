package kr.happyjob.study.test.service;

import java.util.List;
import java.util.Map;
import kr.happyjob.study.test.model.TestModel;


public interface TestService {

	/* 시험리스트 목록 및 조회 */
	public List<TestModel> getListData(Map<String, Object> paramMap);
	
	public int testListCnt(Map<String, Object> paramMap);
	
	
	/* 시험등록 저장저장 */
	public int saveActive(Map<String, Object> paramMap);

	
	/* 시험등록문제 비활성화 */
	public int testDeactivate(Map<String, Integer> resultMap);

	
	/* 시험등록 수정조회 */
	public TestModel testModifyList(Map<String, Object> paramMap);

	/* 시험등록 수정하기 */
	public int testModify(Map<String, Object> paramMap);

	//시험분류별 조회 
	public List<TestModel> lectureListData(Map<String, Object> paramMap);
	
	
	
}
