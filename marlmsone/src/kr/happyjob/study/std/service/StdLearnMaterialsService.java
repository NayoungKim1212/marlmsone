package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.std.model.StdLearningMaterialsModel;

public interface StdLearnMaterialsService {

	public List<StdLearningMaterialsModel> stdLearnMatList(Map<String, Object> paramMap)throws Exception;

	public int learnMatTotalCount(Map<String, Object> paramMap)throws Exception;

	public StdLearningMaterialsModel std_detail(Map<String, Object> paramMap)throws Exception;

}
