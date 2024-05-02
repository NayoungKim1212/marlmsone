package kr.happyjob.study.std.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.notice.dao.NoticeDao;
import kr.happyjob.study.notice.model.Noticevo;
import kr.happyjob.study.std.dao.SubmittedWorkDao;
import kr.happyjob.study.std.model.SubmittedWorkVo;


@Service
public class SubmittedWorkServiceImpl implements SubmittedWorkService {

	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();
	
	@Autowired
	SubmittedWorkDao submittedWorkdao;
	
	@Value("${fileUpload.rootPath}") //happyjob.properties에서 기본적으로 설정된거 있는데 그 정보를 불러온다는거.
	private String rootPath;
	
	@Value("${fileUpload.submitPath}")
	private String itemPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;	
	
	
	/** 리스트출력*/
	@Override
	public List<SubmittedWorkVo> submitList(Map<String, Object> paramMap) throws Exception {
		
		List<SubmittedWorkVo> listdata = submittedWorkdao.submitList(paramMap);
		
		//새로운 데이터를 담을 변수 선언
		List<SubmittedWorkVo> datainfoList = new ArrayList<>();
		
		for(int i=0; i<listdata.size();i++){
			//가져온 데이터에서 과제번호 가져오기
			int hwk_id = listdata.get(i).getHwk_id();
			String loginID = listdata.get(i).getLoginID();
			
			paramMap.put("hwk_id", hwk_id);
			paramMap.put("loginID", loginID);

			//과제 제출 여부 확인하기
			int cnt = submittedWorkdao.cnt(paramMap);
			if(cnt>0){//해당 데이터가 있다는 건 제출을 의미
				logger.info("과제 제출함일 때 if문 돕니다");
				SubmittedWorkVo datainfo = new SubmittedWorkVo(
												listdata.get(i).getSubmit_id(), 
												listdata.get(i).getStd_id(), 
												listdata.get(i).getHwk_id(), 
												listdata.get(i).getSubmit_con(), 
												listdata.get(i).getSubmit_fname(), 
												listdata.get(i).getSubmit_url(), 
												listdata.get(i).getSubmit_fsize(), 
												listdata.get(i).getSubmit_date(), 
												listdata.get(i).getLec_id(), 
												listdata.get(i).getLec_name(), 
												listdata.get(i).getHwk_name(), 
												listdata.get(i).getStart(), 
												listdata.get(i).getDead(), 
												listdata.get(i).getHwk_url(), 
												"y");
				datainfoList.add(datainfo);
			}else {
				logger.info("과제 제출 안했을 때 if문 돕니다");
				SubmittedWorkVo datainfo = new SubmittedWorkVo(
												listdata.get(i).getSubmit_id(), 
												listdata.get(i).getStd_id(), 
												listdata.get(i).getHwk_id(), 
												listdata.get(i).getSubmit_con(), 
												listdata.get(i).getSubmit_fname(), 
												listdata.get(i).getSubmit_url(), 
												listdata.get(i).getSubmit_fsize(), 
												listdata.get(i).getSubmit_date(), 
												listdata.get(i).getLec_id(), 
												listdata.get(i).getLec_name(), 
												listdata.get(i).getHwk_name(), 
												listdata.get(i).getStart(), 
												listdata.get(i).getDead(), 
												listdata.get(i).getHwk_url(), 
												"n");
				datainfoList.add(datainfo);
			}
		}
		return datainfoList;
	}

	/** 카운트 조회 */
	public int submitcnt(Map<String, Object> paramMap) throws Exception {
		int totalCount = submittedWorkdao.submitcnt(paramMap);
		return totalCount;
	}

	/** 과제등록*/
	public int submitSave(Map<String, Object> paramMap,HttpServletRequest request) throws Exception{
		//1. 업로드된 파일 정보
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
											//.separator : OS에서 사용하는 이름 구분자
		String itemFilePath = itemPath +File.separator;

		FileUtilCho fileup = new FileUtilCho(multipartHttpServletRequest,rootPath,virtualRootPath,itemFilePath);
		
		Map<String, Object> fileinfo = fileup.uploadFiles();
		
		paramMap.put("fileinfo", fileinfo);
		
		logger.info("paramMap: "+paramMap);
		return submittedWorkdao.submitSave(paramMap);
	};
	
	/** 개별조회 (업로드 파일 가져오기)*/	
	public SubmittedWorkVo getFile(Map<String, Object> paramMap) throws Exception{
		logger.info("개별조회 로직 처리 이후 map > "+submittedWorkdao.getFile(paramMap));
		
		return submittedWorkdao.getFile(paramMap);
	};

	/** 과제수정*/
	public int submitModify(Map<String, Object> paramMap,HttpServletRequest request) throws Exception{
		//1. 업로드된 파일 정보
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
											//.separator : OS에서 사용하는 이름 구분자
		String itemFilePath = itemPath +File.separator;

		FileUtilCho fileup = new FileUtilCho(multipartHttpServletRequest,rootPath,virtualRootPath,itemFilePath);
		
		Map<String, Object> fileinfo = fileup.uploadFiles();
		
		paramMap.put("fileinfo", fileinfo);
		
		logger.info("로직 처리 이후 완성 된 paramMap: "+paramMap);
		return submittedWorkdao.submitModify(paramMap);
	};	
}
