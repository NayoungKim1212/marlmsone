package kr.happyjob.study.test.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.test.model.TestModel;

public interface TestDao {

	public Integer insertTestData(Map<String, Object> paramMap);

	public List<TestModel> getListData(Map<String, Object> paramMap);

	public int testListCnt(Map<String, Object> paramMap);

	public int testDeactivate(Map<String, Integer> resultMap);

	public TestModel testModifyList(Map<String, Object> paramMap);

	public int testModify(Map<String, Object> paramMap);

	public List<TestModel> lectureListData(Map<String, Object> paramMap);

	

}
