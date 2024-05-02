package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.employ.model.EmploymentModel;
import kr.happyjob.study.std.model.LectureModel;
import kr.happyjob.study.tut.model.LecturePlanModel;

public interface LectureService {

	public List<LectureModel> lecList(Map<String, Object> paramMap)throws Exception;

	public int lecTotal(Map<String, Object> paramMap)throws Exception;

	public LectureModel lecInfo(Map<String, Object> paramMap)throws Exception;

	public List<LectureModel> week_plan(Map<String, Object> paramMap)throws Exception;

	public int lecReg(Map<String, Object> paramMap)throws Exception;

}
