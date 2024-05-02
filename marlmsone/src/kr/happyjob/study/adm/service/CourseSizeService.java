package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.CourseSizeModel;

public interface CourseSizeService {
	// 강의 목록 조회
	public List<CourseSizeModel> lecList(Map<String, Object> paramMap);
	
	// 강의 목록 카운트 조회
	public int lecListCount(Map<String, Object> paramMap);
	
	// 강의 인원 단건 조회
	public List<CourseSizeModel> selectSizeInfo(Map<String, Object> paramMap);
}
