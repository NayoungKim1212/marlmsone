package kr.happyjob.study.tut.model;

import org.springframework.web.multipart.MultipartFile;

public class UpdateLearnMatDto {
	private String learnMatId;
	private String updateLearnTitle;
	private String updateLearnContent;
	private MultipartFile updateFile;
		
	public String getLearnMatId() {
		return learnMatId;
	}
	public void setLearnMatId(String learnMatId) {
		this.learnMatId = learnMatId;
	}
	public String getUpdateLearnTitle() {
		return updateLearnTitle;
	}
	public void setUpdateLearnTitle(String updateLearnTitle) {
		this.updateLearnTitle = updateLearnTitle;
	}
	public String getUpdateLearnContent() {
		return updateLearnContent;
	}
	public void setUpdateLearnContent(String updateLearnContent) {
		this.updateLearnContent = updateLearnContent;
	}
	public MultipartFile getUpdateFile() {
		return updateFile;
	}
	public void setUpdateFile(MultipartFile updateFile) {
		this.updateFile = updateFile;
	}
	
	
}
