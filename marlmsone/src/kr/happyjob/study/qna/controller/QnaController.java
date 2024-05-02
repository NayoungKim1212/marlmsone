package kr.happyjob.study.qna.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.notice.service.NoticeService;
import kr.happyjob.study.qna.model.CommentVo;
import kr.happyjob.study.qna.model.QnaVo;
import kr.happyjob.study.qna.service.CommentService;
import kr.happyjob.study.qna.service.QnaService;

@Controller
public class QnaController {
	
	@Autowired
	QnaService qnaService;

	@Autowired
	CommentService commentService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	
	/**Q&A 초기화면*/
	@RequestMapping(value="/qna.do")	// url 이름이랑 메소드 이름 동일하게 setting
	public String qna(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//글쓰기 버튼 권한에 따라 보이게 하기 위해
		String loginID = (String) session.getAttribute("loginId");
		String user_type = (String) session.getAttribute("userType");
		model.addAttribute("loginId",loginID);
		model.addAttribute("user_type",user_type);
		
		
		logger.info("+ Start " + className + ".qna");
		logger.info("   - paramMap : " + paramMap);

		
		return "qna/qna";
	}
	
	/** Q&A 초기화면*/
	@RequestMapping(value="/qnaList.do")	// url 이름이랑 메소드 이름 동일하게 setting
	public String qnaList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
			
		logger.info("+ Start " + className + ".qna");
		logger.info("   - paramMap : " + paramMap);
		
		int cpage = Integer.valueOf((String) paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
		//네비게이션바 시작번호. 글이 많
		int startpos = (cpage-1) * pagesize;
		
		//검색
		String searchtitle =(String) paramMap.get("searchtitle");
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<QnaVo> listData = qnaService.qnaList(paramMap);
		int listcnt = qnaService.listcnt(paramMap);
		
		model.addAttribute("listData", listData);
		model.addAttribute("listcnt", listcnt);	

		return "qna/qnaList";
	}	
	
	/**등록*/
	@RequestMapping("/qnaSave.do")
	@ResponseBody
	public Map<String,Object> qnaSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticesave");
		logger.info("   - paramMap : " + paramMap);

		
		// ajax 후 전달 데이터를 json으로 설정 했었음. 
		Map<String,Object> returnMap = new HashMap<String,Object>();
		
		String loginID = (String) session.getAttribute("loginId");
		//학생만 등록 할 수 있도록 하기 위해
		String user_type = (String) session.getAttribute("userType");

		paramMap.put("loginID", loginID);
		paramMap.put("user_type", user_type);

		int result= qnaService.qnaSave(paramMap);
		
		if(result < 0) { // 등록에 실패하면 음수 값
			returnMap.put("result", "F");
			returnMap.put("msg", "저장 실패했습니다.");
		} else { // 등록 성공 시 1 출력
			returnMap.put("result", "S");
			returnMap.put("msg", "저장 되었습니다.");
			
		}
		
		return  returnMap;
	}
	
	/**상세조회*/
	@RequestMapping("/qnaView.do")
	@Transactional
	public String qnaView(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//보낼 값들 > 작성자와 조회자가 동일한가 확인을 위해
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		//조회수 증가 
		qnaService.hit(paramMap);
		Map<String,Object > returnMap = new HashMap<>();
		
		//받을 값 > 게시글 내용
		QnaVo vo = qnaService.qnaView(paramMap);
		//vo.setQna_con((vo.getQna_con()).replaceAll("<br>",  "\r\n"));
		
		//받을 값 >  작성자와 로그인한 사람이 동일한지 (버튼유무)	
		int check = qnaService.check(paramMap);
		
		if(check==0){//동일한 경우 게시글 정보와 일치여부 확인 결과를 전달
			QnaVo data = new QnaVo(vo.getQna_id(), vo.getLoginID(),vo.getQna_title(), vo.getQna_con(), vo.getRegdate(), vo.getHit(), true);
			model.addAttribute("data",data);
		}else{
			QnaVo data = new QnaVo(vo.getQna_id(), vo.getLoginID(),vo.getQna_title(), vo.getQna_con(), vo.getRegdate(), vo.getHit(), false);	
			model.addAttribute("data",data);
		}

		List<CommentVo> commentData = commentService.commentList(paramMap);
		
		
		model.addAttribute("commentData", commentData);
		
		logger.info(" : " + returnMap);
		
		return "qna/commentList";
	}		
	
	/**수정*/
	@RequestMapping("/qnaModify.do")
	@ResponseBody
	public Map<String,Object> qnaModify(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnaModify");
		logger.info("   - paramMap : " + paramMap);
		Map<String,Object> returnMap = new HashMap<String,Object>();
		//성공 여부 담는 변수
		int tf = qnaService.qnaModify(paramMap);
		if(tf>0){
			returnMap.put("success",true);
			returnMap.put("msg", "수정에 성공했습니다");
		}else{
			returnMap.put("success",false);
			returnMap.put("msg","수정에 실패했습니다");
		}


		logger.info("  변경 데이터 값  : " + returnMap);
		return  returnMap;
	}	

	/**수정 시 기존 내용 가져오기*/
	@RequestMapping("/qnaOldView.do")
	@ResponseBody
	public Map<String,Object> qnaOldView(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//보낼 값들 > 작성자와 조회자가 동일한가 확인을 위해
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		
		//받을 값 > 게시글 내용
		QnaVo vo = qnaService.qnaView(paramMap);
		vo.setQna_con((vo.getQna_con()).replaceAll("<br>",  "\r\n"));
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("vo", vo);

		logger.info(" : " + vo);
		
		return  returnMap;
	}		
		
	//**삭제*//
	@RequestMapping("/qnaDelete.do")
	@ResponseBody
	public Map<String,Object> qnaDelete(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnaDelete");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String,Object> returnMap = new HashMap<String,Object>();
		//성공 여부 담는 변수
		int tf = qnaService.qnaDelete(paramMap);
		if(tf>0){
			returnMap.put("success",true);
			returnMap.put("msg", "삭제되었습니다");
		}else{
			returnMap.put("success",false);
			returnMap.put("msg","삭제에 실패했습니다");
		}

		return  returnMap;
	}	

}
