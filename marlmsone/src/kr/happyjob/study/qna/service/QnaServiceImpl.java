package kr.happyjob.study.qna.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.notice.dao.NoticeDao;
import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.qna.dao.QnaDao;
import kr.happyjob.study.qna.model.QnaVo;

@Service
public class QnaServiceImpl implements QnaService {
	
	@Autowired 
	QnaDao qnadao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	//글 전체조회
	public List<QnaVo> qnaList(Map<String, Object> paramMap)throws Exception{
		return qnadao.qnaList(paramMap);
	}
	
	//게시물 수 조회
	public int listcnt(Map<String, Object> paramMap) throws Exception{
		return qnadao.listcnt(paramMap);
	}
	
	/**등록*/
	public int qnaSave(Map<String, Object> paramMap) throws Exception{
		return qnadao.qnaSave(paramMap);
	}
	
	/**상세조회*/
	public QnaVo qnaView(Map<String, Object> paramMap)throws Exception{
		return qnadao.qnaView(paramMap);
	}
	
	/**조회수증가*/
	public void hit(Map<String, Object> paramMap)throws Exception{
		qnadao.hit(paramMap);
	}
	
	/**작성자와 로그인한 사람이 동일한지*/
	public int check(Map<String, Object> paramMap)throws Exception{
		return qnadao.check(paramMap);
	}
	
	/**수정*/
	public int qnaModify(Map<String, Object> paramMap)throws Exception{
		return qnadao.qnaModify(paramMap);
	}
	
	/**수정 시 기존 내용 가져오기*/
	public QnaVo qnaOldView(Map<String, Object> paramMap)throws Exception{
		return qnadao.qnaView(paramMap);
	}
	
	/**삭제*/
	public int qnaDelete(Map<String, Object> paramMap)throws Exception{
		return qnadao.qnaDelete(paramMap);
	}
}
