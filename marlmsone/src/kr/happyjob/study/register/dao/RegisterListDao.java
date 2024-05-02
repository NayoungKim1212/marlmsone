package kr.happyjob.study.register.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.register.model.RegisterListModel;

public interface RegisterListDao {

	public List<RegisterListModel> lec_List(Map<String, Object> paramMap) throws Exception;

	/** 카운트 조회 */
	public int lec_Total(Map<String, Object> paramMap) throws Exception;

	/* 학생 목록 조회 */
	public List<RegisterListModel> stdList(Map<String, Object> paramMap) throws Exception;

	/* 학생 목록 카운트 조회 */
	public int std_Total(Map<String, Object> paramMap) throws Exception;

	public int insertregisterList(Map<String, Object> paramMap) throws Exception;

	public List<RegisterListModel> lecrmList(Map<String, Object> paramMap) throws Exception;

	public List<RegisterListModel> tutList(Map<String, Object> paramMap) throws Exception;
	
	public List<RegisterListModel> lecTypeList(Map<String, Object> paramMap) throws Exception;

	public RegisterListModel lec_info(Map<String, Object> paramMap)throws Exception;

	public int updatelec(Map<String, Object> paramMap)throws Exception;
	
	public int deletelec(Map<String, Object> paramMap)throws Exception;

	public int deleteLecStdInfo(Map<String, Object> paramMap)throws Exception;
}
