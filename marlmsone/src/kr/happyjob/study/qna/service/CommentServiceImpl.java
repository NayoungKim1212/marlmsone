package kr.happyjob.study.qna.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.notice.dao.NoticeDao;
import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.qna.dao.CommentDao;
import kr.happyjob.study.qna.dao.QnaDao;
import kr.happyjob.study.qna.model.CommentVo;
import kr.happyjob.study.qna.model.QnaVo;

@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired 
	CommentDao commentDao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/*글 전체조회*/
	public List<CommentVo> commentList(Map<String, Object> paramMap)throws Exception{
		return commentDao.commentList(paramMap);
	}
	
	/*게시물 수 조회*/
	public int commentcnt(Map<String, Object> paramMap) throws Exception{
		return commentDao.commentcnt(paramMap);
	}
	
	/*댓글등록*/
	public int commentSave(Map<String, Object> paramMap) throws Exception{
		return commentDao.commentSave(paramMap);
	}
	
	/*상세조회*/
	public CommentVo commentView(Map<String, Object> paramMap)throws Exception{
		return commentDao.commentView(paramMap);
	}
	
	/*작성자와 로그인한 사람이 동일한지*/
	public int check(Map<String, Object> paramMap)throws Exception{
		return commentDao.check(paramMap);
	}
	
	/*수정*/
	public int commentModify(Map<String, Object> paramMap)throws Exception{
		return commentDao.commentModify(paramMap);
	}
	
	/*수정 시 기존 내용 가져오기*/
	public CommentVo commentOldView(Map<String, Object> paramMap)throws Exception{
		return commentDao.commenOldView(paramMap);
	}
	
	/*삭제*/
	public int commentDelete(Map<String, Object> paramMap)throws Exception{
		return commentDao.commentDelete(paramMap);
	}
}
