package kr.happyjob.study.register.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.happyjob.study.register.dao.RegisterListDao;
import kr.happyjob.study.register.model.RegisterListModel;

@Service
public class RegisterServiceImpl implements RegisterListService {
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	RegisterListDao registerListDao;

	@Override
	public List<RegisterListModel> lec_List(Map<String, Object> paramMap) throws Exception {

		logger.info("=======lec List Service Test Start");

		List<RegisterListModel> listdata = registerListDao.lec_List(paramMap);

		logger.info("=======lec List Service Test END");

		return listdata;
	}

	@Override
	public int lec_Total(Map<String, Object> paramMap) throws Exception {

		int totalCount = registerListDao.lec_Total(paramMap);

		return totalCount;

	}

	@Override
	public List<RegisterListModel> stdList(Map<String, Object> paramMap) throws Exception {

		logger.info("=======std List Service Test Start");

		List<RegisterListModel> list = registerListDao.stdList(paramMap);

		logger.info("=======std List Service Test END");

		return list;
	}

	@Override
	public int std_Total(Map<String, Object> paramMap) throws Exception {

		int totalCount = registerListDao.std_Total(paramMap);

		return totalCount;
	}

	@Override
	public int registerListControlSave(Map<String, Object> paramMap) throws Exception {

		logger.info("Inserting into tb_userinfo with paramMap: " + paramMap);

		return registerListDao.insertregisterList(paramMap);
	}

	@Override
	public List<RegisterListModel> lecrmList(Map<String, Object> paramMap) throws Exception {

		List<RegisterListModel> lecrmList = registerListDao.lecrmList(paramMap);

		logger.info("=======lecrm List Service Test END");

		return lecrmList;
	}

	@Override
	public List<RegisterListModel> tutList(Map<String, Object> paramMap) throws Exception {

		List<RegisterListModel> tutList = registerListDao.tutList(paramMap);

		logger.info("=======tut List Service Test END");

		return tutList;
	}

	@Override
	public List<RegisterListModel> lecTypeList(Map<String, Object> paramMap) throws Exception {

		List<RegisterListModel> typeList = registerListDao.lecTypeList(paramMap);

		return typeList;
	}

	@Override
	public RegisterListModel lec_info(Map<String, Object> paramMap) throws Exception {

		return registerListDao.lec_info(paramMap);
	}

	@Override
	public int registerListControlUpdate(Map<String, Object> paramMap) throws Exception {

		return registerListDao.updatelec(paramMap);
	}

	@Override
	public int delRegister(Map<String, Object> paramMap) throws Exception {

		return registerListDao.deletelec(paramMap);

	}
}
