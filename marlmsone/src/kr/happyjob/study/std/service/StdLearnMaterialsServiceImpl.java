package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.std.dao.StdLearnMaterialsDao;
import kr.happyjob.study.std.model.StdLearningMaterialsModel;

@Service
public class StdLearnMaterialsServiceImpl implements StdLearnMaterialsService {

	@Autowired
	StdLearnMaterialsDao stdLearnMaterialsDao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.noticePath}")
	private String itemPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;	

	@Override
	public List<StdLearningMaterialsModel> stdLearnMatList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return stdLearnMaterialsDao.stdLearnMatList(paramMap);
	}

	@Override
	public int learnMatTotalCount(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return stdLearnMaterialsDao.learnMatTotalCount(paramMap);
	}

	@Override
	public StdLearningMaterialsModel std_detail(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return stdLearnMaterialsDao.std_detail(paramMap);
	}
}
