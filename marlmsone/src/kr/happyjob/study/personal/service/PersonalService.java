package kr.happyjob.study.personal.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.personal.model.PersonalVO;

public interface PersonalService {

	/** 개인 정보 조회 */
	public PersonalVO getUserInfo(Map<String, Object> paramMap) throws Exception;

	/** 개인 정보 업데이트 - 파일O */
	public int updateUserInfo(Map<String, Object> paramMap, HttpServletRequest request)throws Exception;

	/** 비밀번호 변경 */
	public int updatePwd(Map<String, Object> paramMap) throws Exception;

	/** 개인 탈퇴 */
	public int personalQuit(Map<String, Object> paramMap) throws Exception;

	/** 비밀번호 체크 */
	public int checkPwd(Map<String, Object> paramMap) throws Exception;

}
