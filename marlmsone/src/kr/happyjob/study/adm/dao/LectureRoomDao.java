package kr.happyjob.study.adm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.LectureRoomVO;

public interface LectureRoomDao {

	/** 강의실 목록 조회 */
	public List<LectureRoomVO> lectureRoomList(Map<String, Object> paramMap)throws Exception;

	/** 강의실 개수 조회 */
	public int lectureRoomCnt(Map<String, Object> paramMap)throws Exception;

	/** 강의실 상세 조회 - 수정용 */
	public LectureRoomVO lectureRoomDtl(Map<String, Object> paramMap)throws Exception;

	/** 강의실 정보 삽입 */
	public int lectureRoomInsert(Map<String, Object> paramMap)throws Exception;
	
	/** 강의실 정보 수정 */
	public int lectureRoomUpdate(Map<String, Object> paramMap)throws Exception;
	
	/** 강의실 정보 삭제 */
	public int lectureRoomDelete(Map<String, Object> paramMap)throws Exception;
	
	/** 강의의 강의실 정보 null 업데이트 */
	public int lectureNullUpdate(Map<String, Object> paramMap)throws Exception;
	
	/** 강의실 이름 중복 체크 */
	public int lectureRoomNameCheck(Map<String, Object> paramMap)throws Exception;
	
	/** 장비 정보 삭제 */
	public int equDelete(Map<String, Object> paramMap)throws Exception;
	
	/** 장비 정보 삭제 */
	public int oneEquDelete(Map<String, Object> paramMap)throws Exception;
	
	/** 장비 목록 조회 */
	public List<LectureRoomVO> equList(Map<String, Object> paramMap)throws Exception;

	/** 장비 개수 조회 */
	public int equCnt(Map<String, Object> paramMap)throws Exception;

	/** 장비 정보 삽입 */
	public int equInsert(Map<String, Object> paramMap)throws Exception;

	/** 장비 정보 수정 */
	public int equUpdate(Map<String, Object> paramMap)throws Exception;

	/** 장비 정보 상세 - 수정용 */
	public LectureRoomVO equDtl(Map<String, Object> paramMap)throws Exception;
	
	/** 장비 관리 초기 - 강의실 정보 */
	public List<LectureRoomVO> lecRoomList(Map<String, Object> paramMap)throws Exception;

	/** 장비 관리 초기 - 강의실 개수 */
	public int roomCnt(Map<String, Object> paramMap)throws Exception;

	/** 장비 관리 리스트 */
	public List<LectureRoomVO> equManagementList(Map<String, Object> paramMap)throws Exception;

	/** 장비 관리 개수 조회 */
	public int equManagementCnt(Map<String, Object> paramMap)throws Exception;


	
}
