/**
 * 
 */
package com.cms.view.interview;

import java.util.List;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-12 15:37:44
 *
 */
@Bizlet("")
public class CmsInterview {

	private int id;
	private String title;
	private String description;
	private String startTime;
	private String endTime;
	private int status;
	private String imgUrl;
	private String videoUrl;
	private String content;
	private String inputDtime;
	private String inputUser;
	private int hits;
	private List<CmsInterviewGuest> guestList;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public String getVideoUrl() {
		return videoUrl;
	}
	public void setVideoUrl(String videoUrl) {
		this.videoUrl = videoUrl;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getInputDtime() {
		return inputDtime;
	}
	public void setInputDtime(String inputDtime) {
		this.inputDtime = inputDtime;
	}
	public String getInputUser() {
		return inputUser;
	}
	public void setInputUser(String inputUser) {
		this.inputUser = inputUser;
	}
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
	}
	public List<CmsInterviewGuest> getGuestList() {
		return guestList;
	}
	public void setGuestList(List<CmsInterviewGuest> guestList) {
		this.guestList = guestList;
	}
	
	
	
	
}
