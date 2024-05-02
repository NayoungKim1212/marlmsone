package kr.happyjob.study.tut.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.CheckGradesModel;

public interface CheckGradesDao {

	
	public List<CheckGradesModel> checkgradeList(Map<String, Object> paramMap);

	public int totalGradeCnt(Map<String, Object> paramMap);

	public List<CheckGradesModel> lecList(Map<String, Object> paramMap);

	public List<CheckGradesModel> testNameList(Map<String, Object> paramMap);

	public List<CheckGradesModel> checkStdList(Map<String, Object> paramMap);

	public int checkStdCount(Map<String, Object> paramMap);

}
