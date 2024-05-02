package kr.happyjob.study.notice.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.xmlbeans.xml.stream.BufferedXMLInputStream;
import org.aspectj.apache.bcel.classfile.Field;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.notice.service.NoticeService;

@Controller
@RequestMapping("/notice/")
public class NoticeController {
   
   @Autowired
   NoticeService noticeService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();

   
   /**
    * 공지사항 초기화면
    */
   @RequestMapping("notice.do")   // url 이름이랑 메소드 이름 동일하게 setting
   public String notice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".notice");
      logger.info("   - paramMap : " + paramMap);
      
      
      logger.info("+ End " + className + ".notice");

      return "notice/notice";
   }
   
   /**
    * 공지사항 리스트
    */
   @RequestMapping("noticelist.do")
   public String noticelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".noticelist");
      logger.info("   - paramMap : " + paramMap);
      
      String loginID = (String)session.getAttribute("loginId");
      paramMap.put("loginID", loginID);
      
      // object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
      int cpage = Integer.valueOf((String) paramMap.get("cpage"));
      int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
      
      int startpos = (cpage-1) * pagesize;
      
      paramMap.put("startpos", startpos);
      paramMap.put("pagesize", pagesize);
      
      logger.info("서비스로직으로 들어갈 값들: >> "+paramMap);
      
      List<Noticevo> listdata = noticeService.noticelist(paramMap);
      int listcnt = noticeService.noticecnt(paramMap);
      
      model.addAttribute("listdata", listdata);
      model.addAttribute("listcnt", listcnt);
      
      logger.info("+ End " + className + ".noticelist");
      
   
      
      return "notice/noticelist";
   }
   
   @RequestMapping("noticelistjson.do")
   @ResponseBody
   public Map<String,Object> noticelistjson(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".noticelistjson");
      logger.info("   - paramMap : " + paramMap);
      
      Map<String,Object> returnmap = new HashMap<String,Object>();
      
      // object 타입으로 넘겨 받음 -> String 형변환 -> int 타입으로 변환
      int cpage = Integer.valueOf((String) paramMap.get("cpage"));
      int pagesize = Integer.valueOf((String) paramMap.get("pagesize"));
      
      int startpos = (cpage-1) * pagesize;
      
      paramMap.put("startpos", startpos);
      paramMap.put("pagesize", pagesize);      
      
      List<Noticevo> listdata = noticeService.noticelist(paramMap);
      int listcnt = noticeService.noticecnt(paramMap);
      
      returnmap.put("listdata", listdata);
      returnmap.put("listcnt", listcnt);
      
      logger.info("+ End " + className + ".noticelistjson");

      return returnmap;
   }   
   
   /**
    * 파일 신규 공지 등록
    */
   @RequestMapping(value= "/noticeSave.do")
   @ResponseBody   // body 에만 담아서 데이터 리턴을 위함
   public Map<String, Object> noticeSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".noticesave");
      logger.info("   - paramMap : " + paramMap);
      
      String loginID = (String)session.getAttribute("loginId");
      paramMap.put("loginID", loginID);
      
         //값이 들어오지 않는 이유(null): 바이너리 주소로 들어가고 파일이 너무큼. 이 값은 HttpServletRequest request에서 가져올 수 있음.
      //System.out.println(paramMap.get("physicalpath"));
      
         //org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest@76dea1b2
      //System.out.println("여기"+request); 
      
      int returnData = noticeService.noticeSave(paramMap, request);
      //alert창을 위해
      String result ="";
      String msg ="";
      
      Map<String, Object> returnMap = new HashMap<>();
      if(returnData>0){
         result="sucess";
         msg="등록에 성공했습니다";
         returnMap.put("result", result);
         returnMap.put("msg", msg);
      }else{
         result="fail";
         msg="등록에 실패했습니다";
         returnMap.put("result", result);
         returnMap.put("msg", msg);
      }
      
      return returnMap;
   }
   
   
   /**
    * 공지사항 상세 조회
    */
   @RequestMapping("noticeView.do")
   @ResponseBody   // body 에만 담아서 데이터 리턴을 위함
   @Transactional
   public Map<String, Object> noticeView(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".noticeView");
      logger.info("   - paramMap : " + paramMap);
      
      // 반환할 데이터를 담을 Map 객체
      Map<String, Object> returnmap = new HashMap<>();

      Noticevo selinfo = noticeService.noticeView(paramMap);   
      
      returnmap.put("selinfo", selinfo);
      
      logger.info("+ End " + className + ".noticeView");
      
      //조회수 증가
      noticeService.noticehitupdate(paramMap);
      
      return returnmap;
   }
   
   @RequestMapping("noticeDownload.do")
   @ResponseBody   // body 에만 담아서 데이터 리턴을 위함
   public void noticeDownload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".noticeDownload");
      logger.info("   - paramMap : " + paramMap);

      Noticevo getInfo = noticeService.noticeView(paramMap);
      
      //실제 저장된 주소 
      String file = getInfo.getPhysicalpath();
      
      byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
        
      response.setContentType("application/octet-stream");
      response.setContentLength(fileByte.length);
      response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(getInfo.getFilename(),"UTF-8")+"\";");
      response.setHeader("Content-Transfer-Encoding", "binary");
      response.getOutputStream().write(fileByte); 
      response.getOutputStream().flush();
       response.getOutputStream().close();
   }

   @RequestMapping("noticeDownload2.do")
   @ResponseBody   // body 에만 담아서 데이터 리턴을 위함
   public void noticeDownload2(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".noticeDownload2");
      logger.info("   - paramMap : " + paramMap);

      Noticevo getInfo = noticeService.noticeView(paramMap);
      
      //실제 저장된 주소 
      String file = getInfo.getPhysicalpath();
      
      byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
        
      response.setContentType("image/png");
      response.setContentLength(fileByte.length);
      response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(getInfo.getFilename(),"UTF-8")+"\";");
      response.setHeader("Content-Transfer-Encoding", "binary");
      response.getOutputStream().write(fileByte); 
      response.getOutputStream().flush();
       response.getOutputStream().close();
   }
   
   /**수정*/
   // 파일 폼이 비어 있으면 파일 관련 소스 업데이트 안함. 없으면 같이 업데이트
   @RequestMapping(value= "/noticeModify.do")
   @ResponseBody   // body 에만 담아서 데이터 리턴을 위함
   public Map<String, Object> noticeModify(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".noticeModify");
      logger.info("   - paramMap : " + paramMap);
      

      
      String loginID = (String)session.getAttribute("loginId");
      paramMap.put("loginID", loginID);
   
      
      int returnData = noticeService.noticeModify(paramMap, request);
      logger.info("   - 리턴 데이터 존재 ??? : " + returnData);      
      
      //alert창을 위해
      String result ="";
      String msg ="";
      
      Map<String, Object> returnMap = new HashMap<>();
      if(returnData>0){
         result="sucess";
         msg="수정에 성공했습니다";
         returnMap.put("result", result);
         returnMap.put("msg", msg);
      }else{
         result="fail";
         msg="수정에 실패했습니다";
         returnMap.put("result", result);
         returnMap.put("msg", msg);
      }
      
      return returnMap;
   }
      
   
   //**삭제*//
   @RequestMapping("/noticeDelete.do")
   @ResponseBody
   public Map<String,Object> noticeDelete(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".noticeDelete");
      logger.info("   - paramMap : " + paramMap);
      
      int tf = noticeService.noticeDelete(paramMap);
      Map<String,Object> returnMap = new HashMap<String,Object>();

      if(tf>0){
         returnMap.put("success",true);
         returnMap.put("msg", "삭제되었습니다");
      }else{
         returnMap.put("success",false);
         returnMap.put("msg","삭제에 실패했습니다");
      }


      logger.info("  변경 데이터 값  : " + returnMap);
      return  returnMap;
   }
}