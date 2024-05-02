package kr.happyjob.study.adv.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adv.dao.AdviceDao;
import kr.happyjob.study.adv.model.AdviceVo;
import kr.happyjob.study.adv.model.LecInfoVo;
import kr.happyjob.study.adv.model.LecStdInfoVo;

@Service
public class AdviceServiceImpl implements AdviceService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AdviceDao adviceDao;
	
	/** 강의 목록 조회 */
	@Override
	public List<LecInfoVo> lecList(Map<String, Object> paramMap) throws Exception {
		
		logger.info("   - paramMap : " + paramMap);
		return adviceDao.lecList(paramMap);
	}
	
	/** 강의 목록 카운트 조회 */
	@Override
	public int lecListCnt(Map<String, Object> paramMap) throws Exception {
		return adviceDao.lecListCnt(paramMap);
	}
	
	/** 상담 목록 조회 */
	@Override
	public List<AdviceVo> advList(Map<String, Object> paramMap) throws Exception {
		return adviceDao.advList(paramMap);
	}
	
	/** 상담 목록 카운트 조회 */
	@Override
	public int advListCnt(Map<String, Object> paramMap) throws Exception {
		return adviceDao.advListCnt(paramMap);
	}
	
	/** 상담 상세보기 */
	public AdviceVo advDetail(Map<String, Object> paramMap) throws Exception {
		return adviceDao.advDetail(paramMap);		
	}

	/** 강의 수강 학생 목록 조회 */
	@Override
	public List<LecStdInfoVo> lecStdList(Map<String, Object> paramMap) throws Exception {		
		return adviceDao.lecStdList(paramMap);
	}

	/** 강의 수강 학생 목록 카운트 조회 */
	@Override
	public int lecStdListCnt(Map<String, Object> paramMap) throws Exception {
		return adviceDao.lecStdListCnt(paramMap);		
	}
	
	/** 상담 등록 */
	@Override
	public int advRegister(Map<String,Object> paramMap) {
		return adviceDao.advRegister(paramMap);
	}
	
	/** 상담 수정 */
	@Override
	public int advUpdate(Map<String,Object> paramMap) {
		return adviceDao.advUpdate(paramMap);
	}
	
	/** 상담 삭제 */
	@Override
	public int advDelete(Map<String,Object> paramMap) {
		return adviceDao.advDelete(paramMap);
	}
	
	
	/** 목록 조회 *//*
	public List<Noticevo> noticelist(Map<String, Object> paramMap) throws Exception {
		
		List<Noticevo> listdata = noticeDao.noticelist(paramMap);
		
		return listdata;
	}
	
	*//** 카운트 조회 *//*
	public int noticecnt(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = noticeDao.noticecnt(paramMap);
		
		return totalCount;
	}
	
	*//** 파일 x 신규 공지 등록 *//*
	public int noticesave(Map<String, Object> paramMap) throws Exception{
		return noticeDao.noticesave(paramMap);
	};

	*//** 파일 x 공지 수정 *//*
	public int noticeupdate(Map<String, Object> paramMap) throws Exception{
		return noticeDao.noticeupdate(paramMap);
	};
	
	*//** 조회수 수정 *//*
	public int noticehitupdate(Map<String, Object> paramMap) throws Exception{
		return noticeDao.noticehitupdate(paramMap);
	};
	
	*//** 상세 조회 *//*
	public Noticevo noticedtl(Map<String, Object> paramMap) throws Exception{
		return noticeDao.noticedtl(paramMap);
	};
	
	*//** 파일 x 공지 삭제 *//*
	public int noticedelete(Map<String, Object> paramMap) throws Exception{
		return noticeDao.noticedelete(paramMap);
	};*/
	
}
