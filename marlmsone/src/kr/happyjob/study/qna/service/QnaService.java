package kr.happyjob.study.qna.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.qna.model.QnaVo;

public interface QnaService {


	
	/*전체조회*/
	public List<QnaVo> qnaList(Map<String, Object> paramMap) throws Exception;

	/*게시물 수*/
	public int listcnt(Map<String, Object> paramMap)throws Exception;
	
	/*글등록*/
	public int qnaSave(Map<String, Object> paramMap)throws Exception;

	/**상세조회*/
	public QnaVo qnaView(Map<String, Object> paramMap)throws Exception;

	/**조회수증가*/
	public void hit(Map<String, Object> paramMap)throws Exception;
	
	/**작성자와 로그인한 사람이 동일한지*/
	public int check(Map<String, Object> paramMap)throws Exception;
	
	/**수정*/
	public int qnaModify(Map<String, Object> paramMap)throws Exception;
	
	/**수정 시 기존 내용 가져오기*/
	public QnaVo qnaOldView(Map<String, Object> paramMap)throws Exception;
	
	/**삭제*/
	public int qnaDelete(Map<String, Object> paramMap)throws Exception;
	

}
