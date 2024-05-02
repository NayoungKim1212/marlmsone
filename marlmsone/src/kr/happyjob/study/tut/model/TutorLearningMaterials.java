package kr.happyjob.study.tut.model;

import java.util.Date;

public class TutorLearningMaterials {
	
	private int learn_data_id;

	private int lectureId;
	
	private String learnTitle;
	
	private String learnContent;
	
	private Date writeDate;
	
	private String materials_fname;
	
	private String materials_orginal_fname;
	
	private String materials_url;
	
	private String materials_fsize;

	public String getMaterials_orginal_fname() {
		return materials_orginal_fname;
	}

	public void setMaterials_orginal_fname(String materials_orginal_fname) {
		this.materials_orginal_fname = materials_orginal_fname;
	}

	public int getLearn_data_id() {
		return learn_data_id;
	}

	public void setLearn_data_id(int learn_data_id) {
		this.learn_data_id = learn_data_id;
	}
	
	public Integer getLectureId() {
		return lectureId;
	}

	public void setLectureId(int lectureId) {
		this.lectureId = lectureId;
	}

	public String getLearnTitle() {
		return learnTitle;
	}

	public void setLearnTitle(String learnTitle) {
		this.learnTitle = learnTitle;
	}

	public String getLearnContent() {
		return learnContent;
	}

	public void setLearnContent(String learnContent) {
		this.learnContent = learnContent;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	public String getMaterials_fname() {
		return materials_fname;
	}

	public void setMaterials_fname(String materials_fname) {
		this.materials_fname = materials_fname;
	}

	public String getMaterials_url() {
		return materials_url;
	}

	public void setMaterials_url(String materials_url) {
		this.materials_url = materials_url;
	}

	public String getMaterials_fsize() {
		return materials_fsize;
	}

	public void setMaterials_fsize(String materials_fsize) {
		this.materials_fsize = materials_fsize;
	}
	
	
	
}
