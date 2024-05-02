package kr.happyjob.study.adm.controller;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.adm.model.LectureRoomVO;
import kr.happyjob.study.adm.service.LectureRoomService;
import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.notice.service.NoticeService;

@Controller
@RequestMapping("/adm/")
public class LectureRoomController {
	
	@Autowired
	LectureRoomService lectureRoomService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	/**
	 * 강의실 관리 초기화면
	 */
	@RequestMapping("lectureRoom.do")
	public String lectureRoom(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureRoom");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".lectureRoom");

		return "adm/lectureRoom";
	}
	
	/**
	 * 강의실 리스트
	 */
	@RequestMapping("lectureRoomList.do")
	public String lectureRoomList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureRoomList");
		logger.info("   - paramMap : " + paramMap);

		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int cpage = Integer.valueOf((String) paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
		
		int startpos = (cpage-1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<LectureRoomVO> listdata = lectureRoomService.lectureRoomList(paramMap);
		int listcnt = lectureRoomService.lectureRoomCnt(paramMap);
		
		model.addAttribute("listdata", listdata);
		model.addAttribute("listcnt", listcnt);
		
		logger.info("+ End " + className + ".lectureRoomList");

		return "adm/lectureRoomList";
	}

	/**
	 * 강의실 리스트
	 */
	@RequestMapping("lectureRoomListjson.do")
	@ResponseBody
	public Map<String,Object> lectureRoomListjson(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureRoomListjson");
		logger.info("   - paramMap : " + paramMap);

		Map<String,Object> returnmap = new HashMap<String,Object>();
		
		
		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int cpage = Integer.valueOf((String) paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
		
		int startpos = (cpage-1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<LectureRoomVO> listdata = lectureRoomService.lectureRoomList(paramMap);
		int listcnt = lectureRoomService.lectureRoomCnt(paramMap);
		
		returnmap.put("listdata", listdata);
		returnmap.put("listcnt", listcnt);
		
		logger.info("+ End " + className + ".lectureRoomListjson");

		return returnmap;
	}

	/**
	 * 강의실 정보 등록/수정/삭제
	 */
	@RequestMapping("lectureRoomSave.do")
	@ResponseBody	// body 에만 담아서 데이터 리턴을 위함
	public Map<String, Object> lectureRoomSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureRoomSave");
		logger.info("   - paramMap : " + paramMap);
		
		// 반환할 데이터를 담을 Map 객체
		Map<String, Object> returnmap = new HashMap<>();
		
		// JSON 형태로 넘겨준 param 값 가져오기 Object 타입 -> 캐스팅 필요
		String action = (String)paramMap.get("action");
		
		System.out.println("lecrm_id : " + (String)paramMap.get("lecrm_id"));
		
		// session 에서 id 가져오기 -> Map 으로 넣기
		String loginID = (String)session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		int sreturn = 0;
		String result = "";
		String resultmsg = "";
		// 신규 등록이면
		if("I".equals(action)){
			sreturn = lectureRoomService.lectureRoomInsert(paramMap);
		} else if("U".equals(action)){
			sreturn = lectureRoomService.lectureRoomUpdate(paramMap);
		} else if("D".equals(action)){
			// 참조하는 강의의 강의실 정보 null 로 update
			lectureRoomService.lectureNullUpdate(paramMap);
			// 장비가 존재하면
			int equCnt = lectureRoomService.equCnt(paramMap);
			if(equCnt>0)
				lectureRoomService.equDelete(paramMap);
			sreturn = lectureRoomService.lectureRoomDelete(paramMap);
		}
		
		if(sreturn>0){
			result = "S";
			
			if("D".equals(action))
				resultmsg = "삭제되었습니다.";
			else
				resultmsg = "저장되었습니다.";
			
		} else {
			result = "F";
			
			if("D".equals(action))
				resultmsg = "삭제 실패하였습니다.";
			else
				resultmsg = "저장 실패하였습니다.";
		}
		
		returnmap.put("result", result);
		returnmap.put("resultmsg", resultmsg);
		
		logger.info("+ End " + className + ".lectureRoomSave");
		
		return returnmap;
	}
	
	
	/**
	 * 강의실 상세 조회 - 수정용
	 */
	@RequestMapping("lectureRoomDtl.do")
	@ResponseBody	// body 에만 담아서 데이터 리턴을 위함
	public Map<String, Object> lectureRoomDtl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureRoomDtl");
		logger.info("   - paramMap : " + paramMap);

		
		// 반환할 데이터를 담을 Map 객체
		Map<String, Object> returnmap = new HashMap<>();
		LectureRoomVO selinfo = lectureRoomService.lectureRoomDtl(paramMap);	

		returnmap.put("selinfo", selinfo);
		
		logger.info("+ End " + className + ".lectureRoomDtl");
		
		return returnmap;
	}
	
	
	/**
	 * 장비 리스트
	 */
	@RequestMapping("equList.do")
	public String equList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".equList");
		logger.info("   - paramMap : " + paramMap);
		
		
		System.out.println("lecrm_id : " + (String)paramMap.get("lecrm_id"));
		
		
		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int cpage = Integer.valueOf((String) paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
		
		int startpos = (cpage-1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<LectureRoomVO> listdata = lectureRoomService.equList(paramMap);
		int listcnt = lectureRoomService.equCnt(paramMap);
		
		model.addAttribute("listdata", listdata);
		model.addAttribute("listcnt", listcnt);
		
		logger.info("+ End " + className + ".equList");
		
		return "adm/equList";
	}

	/**
	 * 장비 리스트
	 */
	@RequestMapping("equListjson.do")
	@ResponseBody
	public Map<String, Object> equListjson(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".equListjson");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		System.out.println("lecrm_id : " + (String)paramMap.get("lecrm_id"));
		
		
		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int cpage = Integer.valueOf((String) paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
		
		int startpos = (cpage-1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<LectureRoomVO> listdata = lectureRoomService.equList(paramMap);
		int listcnt = lectureRoomService.equCnt(paramMap);
		
		returnmap.put("listdata", listdata);
		returnmap.put("listcnt", listcnt);
		
		logger.info("+ End " + className + ".equListjson");
		
		return returnmap;
	}
	
	/**
	 * 장비 정보 등록/수정/삭제
	 */
	@RequestMapping("equSave.do")
	@ResponseBody	// body 에만 담아서 데이터 리턴을 위함
	public Map<String, Object> equSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".equSave");
		logger.info("   - paramMap : " + paramMap);
		
		// 반환할 데이터를 담을 Map 객체
		Map<String, Object> returnmap = new HashMap<>();
		
		// JSON 형태로 넘겨준 param 값 가져오기 Object 타입 -> 캐스팅 필요
		String action = (String)paramMap.get("action");
		//System.out.println("lecrm_id : " + (String)paramMap.get("lecrm_id"));
		
		int sreturn = 0;
		String result = "";
		String resultmsg = "";

		// I : 등록 , U : 수정, D : 삭제
		if("I".equals(action)){
			//System.out.println("등록");
			sreturn = lectureRoomService.equInsert(paramMap);
		} else if("U".equals(action)){
			//System.out.println("수정");
			sreturn = lectureRoomService.equUpdate(paramMap);
		} else if("D".equals(action)){
			//System.out.println("삭제");
			sreturn = lectureRoomService.oneEquDelete(paramMap);
		}
		
		if(sreturn>0){
			result = "S";
			
			if("D".equals(action))
				resultmsg = "삭제되었습니다.";
			else
				resultmsg = "저장되었습니다.";
			
		} else {
			result = "F";
			
			if("D".equals(action))
				resultmsg = "삭제 실패하였습니다.";
			else
				resultmsg = "저장 실패하였습니다.";
		}
		
		returnmap.put("result", result);
		returnmap.put("resultmsg", resultmsg);
		
		logger.info("+ End " + className + ".equSave");
		
		return returnmap;
	}
	
	
	/**
	 * 장비 상세 조회 - 수정용
	 */
	@RequestMapping("equDtl.do")
	@ResponseBody	// body 에만 담아서 데이터 리턴을 위함
	public Map<String, Object> equDtl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".equDtl");
		logger.info("   - paramMap : " + paramMap);
		
		// 반환할 데이터를 담을 Map 객체
		Map<String, Object> returnmap = new HashMap<>();
		LectureRoomVO selinfo = lectureRoomService.equDtl(paramMap);	

		returnmap.put("selinfo", selinfo);
		
		logger.info("+ End " + className + ".equDtl");
		
		return returnmap;
	}
	
	
	
	/**
	 * 장비 관리 초기화면
	 */
	@RequestMapping("equManagement.do")
	public String equManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureRoom");
		logger.info("   - paramMap : " + paramMap);
		
		// modal 의 list select box
		List<LectureRoomVO> roomlist = lectureRoomService.lecRoomList(paramMap);
		int roomCnt = lectureRoomService.roomCnt(paramMap);
		
		System.out.println("roomCnt조회 : " + roomCnt);
		
		model.addAttribute("roomlist", roomlist);
		model.addAttribute("roomCnt", roomCnt);
		
		logger.info("+ End " + className + ".lectureRoom");

		return "adm/equManagement";
	}
	

	/**
	 * 장비 관리 리스트
	 */
	@RequestMapping("equManagementList.do")
	public String equManagementList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".equManagementList");
		logger.info("   - paramMap : " + paramMap);
		
		System.out.println("searchOption : " + (String)paramMap.get("searchOption"));
		System.out.println("searchName : " + (String)paramMap.get("searchName"));
		
		// object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
		int cpage = Integer.valueOf((String) paramMap.get("cpage"));
		int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
		
		int startpos = (cpage-1) * pagesize;
		
		paramMap.put("startpos", startpos);
		paramMap.put("pagesize", pagesize);
		
		List<LectureRoomVO> listdata = lectureRoomService.equManagementList(paramMap);
		int listcnt = lectureRoomService.equManagementCnt(paramMap);
		
		model.addAttribute("listdata", listdata);
		model.addAttribute("listcnt", listcnt);
		
		logger.info("+ End " + className + ".equManagementList");
		
		return "adm/equManagementList";
	}
	
	
	/**
	 * 장비 관리 상세 조회 - 수정용
	 */
	@RequestMapping("equManagementDtl.do")
	@ResponseBody	// body 에만 담아서 데이터 리턴을 위함
	public Map<String, Object> equManagementDtl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".equManagementDtl");
		logger.info("   - paramMap : " + paramMap);
		
		// 반환할 데이터를 담을 Map 객체
		Map<String, Object> returnmap = new HashMap<>();
		LectureRoomVO selinfo = lectureRoomService.equDtl(paramMap);	
		
		returnmap.put("selinfo", selinfo);
		
		logger.info("+ End " + className + ".equManagementDtl");
		
		return returnmap;
	}
	


	
}

