package kr.happyjob.study.personal.dao;

import java.util.Map;
import kr.happyjob.study.personal.model.PersonalVO;

public interface PersonalServiceDao {

	/** 개인 정보 조회 */
	public PersonalVO getUserInfo(Map<String, Object> paramMap) throws Exception;

	/** 개인 정보 업데이트 */
	public int updateUserInfo(Map<String, Object> paramMap) throws Exception;

	/** 개인 정보 업데이트 - 이력서X */
	public int updateUserInfoNoResume(Map<String, Object> paramMap);

	/** 비밀번호 변경 */
	public int updatePwd(Map<String, Object> paramMap) throws Exception;
	
	/** 비밀번호 체크 */
	public int checkPwd(Map<String, Object> paramMap) throws Exception;
	
	/** 개인 탈퇴 */
	public int personalQuit(Map<String, Object> paramMap) throws Exception;

	/** 현재 비밀번호 조회 */
	public String nowPwd(Map<String, Object> paramMap);
}
