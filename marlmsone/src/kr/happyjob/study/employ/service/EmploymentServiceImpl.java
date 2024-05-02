package kr.happyjob.study.employ.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.employ.dao.EmploymentDao;
import kr.happyjob.study.employ.model.EmploymentModel;
import kr.happyjob.study.register.model.RegisterListModel;

@Service
public class EmploymentServiceImpl implements EmploymentService {
	
	@Autowired
	EmploymentDao employmentDao;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Override
	public List<EmploymentModel> empInfo(Map<String, Object> paramMap) throws Exception {
		
		return employmentDao.empInfo(paramMap);
	}

	@Override
	public int emp_Total(Map<String, Object> paramMap) throws Exception {
		
		return employmentDao.emp_Total(paramMap);
	}

	@Override
	public List<EmploymentModel> stdList(Map<String, Object> paramMap) throws Exception {
		
		return employmentDao.stdList(paramMap);
	}

	@Override
	public int std_Total(Map<String, Object> paramMap) throws Exception {
		
		return employmentDao.std_Total(paramMap);
	}

	@Override
	public List<EmploymentModel> std_info(Map<String, Object> paramMap) throws Exception {
		
		return employmentDao.std_info(paramMap);
	}

	@Override
	public int lec_count(Map<String, Object> paramMap) throws Exception {
		
		return employmentDao.lec_count(paramMap);
	}

	@Override
	public List<EmploymentModel> std_detail(Map<String, Object> paramMap)throws Exception {
		// TODO Auto-generated method stub
		return employmentDao.std_detail(paramMap);
	}

	@Override
	public  int stdemploy(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return employmentDao.stdemploy(paramMap);
	}

	@Override
	public List<EmploymentModel> compinfo(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return employmentDao.compinfo(paramMap);
	}

	@Override
	public EmploymentModel stdinfo(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return employmentDao.stdinfo(paramMap);
	}

	@Override
	public int update_emp(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return employmentDao.update_emp(paramMap);
	}

	@Override
	public int delEmploy(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return employmentDao.delEmploy(paramMap);
	}
}
