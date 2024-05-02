package kr.happyjob.study.register.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.register.model.RegisterListModel;

public interface RegisterListService {

	/* 강의 목록 조회 */
	public List<RegisterListModel> lec_List(Map<String, Object> paramMap) throws Exception;

	/* 강의 목록 카운트 조회 */
	public int lec_Total(Map<String, Object> paramMap) throws Exception;

	/* 학생 목록 조회 */
	public List<RegisterListModel> stdList(Map<String, Object> paramMap) throws Exception;

	/* 학생 목록 카운트 조회 */
	public int std_Total(Map<String, Object> paramMap) throws Exception;

	/* 강의 등록 */
	public int registerListControlSave(Map<String, Object> paramMap) throws Exception;

	/* 강의실 이름 리스트 가져오기 */
	public List<RegisterListModel> lecrmList(Map<String, Object> paramMap) throws Exception;

	/* 강사 이름 리스트 가져오기 */
	public List<RegisterListModel> tutList(Map<String, Object> paramMap) throws Exception;

	/* 강의 분류명 가져오기 */
	public List<RegisterListModel> lecTypeList(Map<String, Object> paramMap)throws Exception;

	public RegisterListModel lec_info(Map<String, Object> paramMap)throws Exception;

	public int registerListControlUpdate(Map<String, Object> paramMap)throws Exception;

	public int delRegister(Map<String, Object> paramMap)throws Exception;
}
