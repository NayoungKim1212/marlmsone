package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.LectureRoomDao;
import kr.happyjob.study.adm.model.LectureRoomVO;

@Service
public class LectureRoomServiceImpl implements LectureRoomService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	LectureRoomDao lectureRoomDao;
	
	/** 강의실 목록 조회 */
	public List<LectureRoomVO> lectureRoomList(Map<String, Object> paramMap)throws Exception{
		List<LectureRoomVO> list = lectureRoomDao.lectureRoomList(paramMap);
		return list;
	};

	/** 강의실 개수 조회 */
	public int lectureRoomCnt(Map<String, Object> paramMap)throws Exception{
		int cnt = lectureRoomDao.lectureRoomCnt(paramMap);
		return cnt;
	};
	

	/** 강의실 상세 조회 - 수정용 */
	public LectureRoomVO lectureRoomDtl(Map<String, Object> paramMap)throws Exception{
		LectureRoomVO lectureRoomVO = lectureRoomDao.lectureRoomDtl(paramMap);
		return lectureRoomVO;
	};
	

	/** 강의실 정보 삽입 */
	public int lectureRoomInsert(Map<String, Object> paramMap)throws Exception{
		return lectureRoomDao.lectureRoomInsert(paramMap);
	};
	
	
	/** 강의실 정보 수정 */
	public int lectureRoomUpdate(Map<String, Object> paramMap)throws Exception{
		return lectureRoomDao.lectureRoomUpdate(paramMap);
	};
	
	
	/** 강의실 정보 삭제 */
	public int lectureRoomDelete(Map<String, Object> paramMap)throws Exception{
		return lectureRoomDao.lectureRoomDelete(paramMap);
	};
	
	
	/** 강의의 강의실 정보 null 업데이트 */
	public int lectureNullUpdate(Map<String, Object> paramMap)throws Exception{
		return lectureRoomDao.lectureNullUpdate(paramMap);
	};
	
	/** 강의실 이름 중복 체크 */
	public int lectureRoomNameCheck(Map<String, Object> paramMap)throws Exception{
		return lectureRoomDao.lectureRoomNameCheck(paramMap);
	};
	
	/** 장비 정보 삭제 */
	public int equDelete(Map<String, Object> paramMap)throws Exception{
		return lectureRoomDao.equDelete(paramMap);
	};
	
	/** 장비 정보 삭제 */
	public int oneEquDelete(Map<String, Object> paramMap)throws Exception{
		return lectureRoomDao.oneEquDelete(paramMap);
	};
	
	/** 장비 목록 조회 */
	public List<LectureRoomVO> equList(Map<String, Object> paramMap)throws Exception{
		List<LectureRoomVO> list = lectureRoomDao.equList(paramMap);
		return list;
	};

	/** 장비 개수 조회 */
	public int equCnt(Map<String, Object> paramMap)throws Exception{
		int cnt = lectureRoomDao.equCnt(paramMap);
		return cnt;
	};
	
	/** 장비 정보 삽입 */
	public int equInsert(Map<String, Object> paramMap)throws Exception{
		return lectureRoomDao.equInsert(paramMap);
	};

	/** 장비 정보 수정 */
	public int equUpdate(Map<String, Object> paramMap)throws Exception{
		return lectureRoomDao.equUpdate(paramMap);
	};
	
	/** 장비 정보 상세 - 수정용 */
	public LectureRoomVO equDtl(Map<String, Object> paramMap)throws Exception{
		LectureRoomVO lectureRoomVO = lectureRoomDao.equDtl(paramMap);
		return lectureRoomVO;
	};
	
	/** 장비 관리 초기 - 강의실 정보 */
	public List<LectureRoomVO> lecRoomList(Map<String, Object> paramMap)throws Exception{
		List<LectureRoomVO> list = lectureRoomDao.lecRoomList(paramMap);
		return list;
	};
	
	/** 장비 관리 초기 - 강의실 개수 */
	public int roomCnt(Map<String, Object> paramMap)throws Exception{
		return lectureRoomDao.roomCnt(paramMap);
	};

	/** 장비 관리 리스트 */
	public List<LectureRoomVO> equManagementList(Map<String, Object> paramMap)throws Exception{
		List<LectureRoomVO> list = lectureRoomDao.equManagementList(paramMap);
		return list;
	};

	
	/** 장비 개수 조회 */
	public int equManagementCnt(Map<String, Object> paramMap)throws Exception{
		int cnt = lectureRoomDao.equManagementCnt(paramMap);
		return cnt;
	};
	
	
}

