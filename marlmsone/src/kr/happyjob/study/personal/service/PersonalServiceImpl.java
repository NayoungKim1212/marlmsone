package kr.happyjob.study.personal.service;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.personal.dao.PersonalServiceDao;
import kr.happyjob.study.personal.model.PersonalVO;
import kr.happyjob.study.common.comnUtils.FileUtilCho;

@Service
public class PersonalServiceImpl implements PersonalService {
	
	// Path 가져오기
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.resumePath}")
	private String itemPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	PersonalServiceDao personalServiceDao;
	
	/** 개인 정보 조회 */
	public PersonalVO getUserInfo(Map<String, Object> paramMap) throws Exception {
		PersonalVO userInfo = personalServiceDao.getUserInfo(paramMap);
		return userInfo;
	}

	/** 개인 정보 업데이트 */
	public int updateUserInfo(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		logger.info("+ Start " + className + ".updateUserInfo");
		logger.info("   - paramMap : " + paramMap);
		
		int result = 0;

		// 1. 업로드 된 파일 저장
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

		String itemFilePath = itemPath + File.separator;
		FileUtilCho fileup = new FileUtilCho(multipartHttpServletRequest, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileinfo = fileup.uploadFiles();
		paramMap.put("fileinfo", fileinfo);
		
		
		// 2. 업로드 된 파일 정보
		// 파일명, 논리경로, 물리경로, 사이즈, 확장자 -> DB 처리 
		// 기존 파일 존재 여부 비교
		PersonalVO origin = personalServiceDao.getUserInfo(paramMap);

		if(fileinfo.get("file_nm")==null){
			// 2-1) 현재 파일 업로드 X , 원래도 파일 X
			// 2-2) 현재 파일 업로드 X , 원래 파일 O
			// -> 둘 다 파일 이외의 정보만 업데이트 하면 됨
			result = personalServiceDao.updateUserInfoNoResume(paramMap);
		} else {
			// 2-3) 현재 파일 업로드 O, 원래 파일 X
			// 2-4) 현재 파일 업로드 O, 원래 파일 O
			// -> 둘다 덮어쓰면 되는데, 파일 O 경우에는 원래 파일 삭제 처리 필요 
			if(origin.getResume_fname()!=null){
				File orgfile = new File(origin.getResume_url());
				orgfile.delete();
			} 
			// 업데이트
			result = personalServiceDao.updateUserInfo(paramMap);
		}
		logger.info("+ End " + className + ".updateUserInfo");

		return result;
	}

	/** 비밀번호 변경 */
	public int updatePwd(Map<String, Object> paramMap) throws Exception{
		int result = 0;
		String nowPassword = personalServiceDao.nowPwd(paramMap); 
		String newPsd = (String)paramMap.get("newPsd");        
		String originPwd = (String)paramMap.get("originPwd");
		
		if(nowPassword.equals(newPsd)){
			return 3;
		} else if(!originPwd.equals(nowPassword)) {
			return 4;
		} else {
			result = personalServiceDao.updatePwd(paramMap);
		}
		
		return result;
	};

	/** 비밀번호 체크 */
	public int checkPwd(Map<String, Object> paramMap) throws Exception{
		// 가져온 비밀번호와 조회된 비밀번호가 동일한지 비교
		logger.info("+ Start " + className + ".checkPwd");
		int result = 0;
		String nowPassword = personalServiceDao.nowPwd(paramMap); 
		String getPassword = (String)paramMap.get("password");
		
		if(nowPassword.equals(getPassword))
			result = 1;
		
		logger.info("+ End " + className + ".checkPwd");
		return result; 
	};

	/** 개인 탈퇴 */
	public int personalQuit(Map<String, Object> paramMap) throws Exception{
		return personalServiceDao.personalQuit(paramMap);
	};
}
