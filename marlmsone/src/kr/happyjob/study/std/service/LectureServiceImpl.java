package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.employ.model.EmploymentModel;
import kr.happyjob.study.std.dao.LectureDao;
import kr.happyjob.study.std.model.LectureModel;
import kr.happyjob.study.tut.model.LecturePlanModel;

@Service
public class LectureServiceImpl implements LectureService{
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	LectureDao lectureDao;

	@Override
	public List<LectureModel> lecList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return lectureDao.lecList(paramMap);
	}

	@Override
	public int lecTotal(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return lectureDao.lecTotal(paramMap);
	}

	@Override
	public LectureModel lecInfo(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return lectureDao.lecInfo(paramMap);
	}

	@Override
	public List<LectureModel> week_plan(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return lectureDao.week_plan(paramMap);
	}

	@Override
	public int lecReg(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return lectureDao.lecReg(paramMap);
	}
}
