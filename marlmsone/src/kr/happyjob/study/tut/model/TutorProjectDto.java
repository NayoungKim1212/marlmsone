package kr.happyjob.study.tut.model;

import java.util.Date;

public class TutorProjectDto {
	private int projectId;
	private int lectureId;
	private String projectTitle;
	private String	 projectContent;
	private String startDate;
	private String deadLineDate;
	private String hwk_fname;
	private String project_orginal_fname;
	private String hwk_url;
	private String hwk_fsize;
	
	
	public String getProject_orginal_fname() {
		return project_orginal_fname;
	}
	public void setProject_orginal_fname(String project_orginal_fname) {
		this.project_orginal_fname = project_orginal_fname;
	}
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public String getProjectTitle() {
		return projectTitle;
	}
	public void setProjectTitle(String projectTitle) {
		this.projectTitle = projectTitle;
	}
	public int getLectureId() {
		return lectureId;
	}
	public void setLectureId(int lectureId) {
		this.lectureId = lectureId;
	}
	public String getProjectContent() {
		return projectContent;
	}
	public void setProjectContent(String projectContent) {
		this.projectContent = projectContent;
	}
	public String getHwk_fname() {
		return hwk_fname;
	}
	public void setHwk_fname(String hwk_fname) {
		this.hwk_fname = hwk_fname;
	}
	public String getHwk_url() {
		return hwk_url;
	}
	public void setHwk_url(String hwk_url) {
		this.hwk_url = hwk_url;
	}
	public String getHwk_fsize() {
		return hwk_fsize;
	}
	public void setHwk_fsize(String hwk_fsize) {
		this.hwk_fsize = hwk_fsize;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getDeadLineDate() {
		return deadLineDate;
	}
	public void setDeadLineDate(String deadLineDate) {
		this.deadLineDate = deadLineDate;
	}
	
	
}
