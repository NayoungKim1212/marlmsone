package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.tut.dao.CheckGradesDao;
import kr.happyjob.study.tut.model.CheckGradesModel;

@Service
public class CheckGradeServicImpl implements CheckGradeService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	CheckGradesDao checkGradeDao; 
	
	//목록 조회
	public List<CheckGradesModel> checkgradeList(Map<String, Object> paramMap) {
		return checkGradeDao.checkgradeList(paramMap);
	}

	//목록 카운트
	public int totalGradeCnt(Map<String, Object> paramMap) {
		return checkGradeDao.totalGradeCnt(paramMap);
	}

	//강의명 리스트 
	public List<CheckGradesModel> lecList(Map<String, Object> paramMap) {
		return checkGradeDao.lecList(paramMap);
	}

	//시험명 리스트
	public List<CheckGradesModel> testNameList(Map<String, Object> paramMap) {
		return checkGradeDao.testNameList(paramMap);
	}

	//응시자 리스트 
	public List<CheckGradesModel> checkStdList(Map<String, Object> paramMap) {
		return checkGradeDao.checkStdList(paramMap);
	}

	//응시자 카운트
	public int checkStdCount(Map<String, Object> paramMap) {
		return checkGradeDao.checkStdCount(paramMap) ;
	}

}
