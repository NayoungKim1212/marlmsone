package kr.happyjob.study.tut.model;

import org.springframework.web.multipart.MultipartFile;

public class UpdateTutorProjectDto {
	private String projectId;
	private String updateProjectTitle;
	private String updateProjectContent;
	private String updateProjectSubmitDate;
	private String updateProjectDeadLineDate;
	private MultipartFile updateFile;
	
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public String getUpdateProjectTitle() {
		return updateProjectTitle;
	}
	public void setUpdateProjectTitle(String updateProjectTitle) {
		this.updateProjectTitle = updateProjectTitle;
	}
	public String getUpdateProjectContent() {
		return updateProjectContent;
	}
	public void setUpdateProjectContent(String updateProjectContent) {
		this.updateProjectContent = updateProjectContent;
	}
	public String getUpdateProjectSubmitDate() {
		return updateProjectSubmitDate;
	}
	public void setUpdateProjectSubmitDate(String updateProjectSubmitDate) {
		this.updateProjectSubmitDate = updateProjectSubmitDate;
	}
	public String getUpdateProjectDeadLineDate() {
		return updateProjectDeadLineDate;
	}
	public void setUpdateProjectDeadLineDate(String updateProjectDeadLineDate) {
		this.updateProjectDeadLineDate = updateProjectDeadLineDate;
	}
	public MultipartFile getUpdateFile() {
		return updateFile;
	}
	public void setUpdateFile(MultipartFile updateFile) {
		this.updateFile = updateFile;
	}
		
	
	
	
}
