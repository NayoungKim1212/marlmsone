package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.tut.model.CheckGradesModel;

public interface CheckGradeService {

	//목록 조회
	public List<CheckGradesModel> checkgradeList(Map<String, Object> paramMap);
	
	//목록 카운트 조회
	public int totalGradeCnt(Map<String, Object> paramMap);

	//강의명 리스트 
	public List<CheckGradesModel> lecList(Map<String, Object> paramMap);

	//시험명 리스트 
	public List<CheckGradesModel> testNameList(Map<String, Object> paramMap);

	//응시자 리스트 
	public List<CheckGradesModel> checkStdList(Map<String, Object> paramMap);

	public int checkStdCount(Map<String, Object> paramMap);

}
