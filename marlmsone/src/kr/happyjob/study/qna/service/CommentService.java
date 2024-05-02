package kr.happyjob.study.qna.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.qna.model.CommentVo;
import kr.happyjob.study.qna.model.QnaVo;

public interface CommentService {


	
	/*전체조회*/
	public List<CommentVo> commentList(Map<String, Object> paramMap) throws Exception;

	/*게시물 수*/
	public int commentcnt(Map<String, Object> paramMap)throws Exception;
	
	/*댓글등록*/
	public int commentSave(Map<String, Object> paramMap)throws Exception;

	/*상세조회*/
	public CommentVo commentView(Map<String, Object> paramMap)throws Exception;

	/*작성자와 로그인한 사람이 동일한지*/
	public int check(Map<String, Object> paramMap)throws Exception;
	
	/*수정*/
	public int commentModify(Map<String, Object> paramMap)throws Exception;
	
	/*수정 시 기존 내용 가져오기*/
	public CommentVo commentOldView(Map<String, Object> paramMap)throws Exception;
	
	/*삭제*/
	public int commentDelete(Map<String, Object> paramMap)throws Exception;
	

}
