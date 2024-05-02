package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.CourseSizeDao;
import kr.happyjob.study.adm.model.CourseSizeModel;

@Service
public class CourseSizeServiceImpl implements CourseSizeService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	CourseSizeDao courseSizeDao;
	
	@Override
	public List<CourseSizeModel> lecList(Map<String, Object> paramMap) {
		return courseSizeDao.lecList(paramMap);
	}

	@Override
	public int lecListCount(Map<String, Object> paramMap) {
		return courseSizeDao.lecListCount(paramMap);
	}

	@Override
	public List<CourseSizeModel> selectSizeInfo(Map<String, Object> paramMap) {
		return courseSizeDao.selectSizeInfo(paramMap);
	}

}
