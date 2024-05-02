package kr.happyjob.study.std.dao;

import java.util.List;
import java.util.Map;


import kr.happyjob.study.std.model.LectureModel;

public interface LectureDao {

	public List<LectureModel> lecList(Map<String, Object> paramMap)throws Exception;

	public int lecTotal(Map<String, Object> paramMap)throws Exception;

	public LectureModel lecInfo(Map<String, Object> paramMap)throws Exception;
	
	public List<LectureModel> week_plan(Map<String, Object> paramMap) throws Exception;

	public int lecReg(Map<String, Object> paramMap)throws Exception;

	public int delLecReg(Map<String, Object> paramMap)throws Exception;
}
