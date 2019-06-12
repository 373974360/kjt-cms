/**
 * 
 */
package com.cms.view.survey;

import java.util.List;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-11 15:03:04
 *
 */
@Bizlet("")
public class CmsSurvey {

	private int id;
	private String title;
	private String startTime;
	private String endTime;
	private int submitNum;
	private int submitDay;
	private String content;
	private int isPublish;
	private String createTime;
	private int isEnd;
	private int num;
	private int pepoleNum;
	
	private List<CmsSurveySub> subList;
	
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
	public int getSubmitNum() {
		return submitNum;
	}
	public void setSubmitNum(int submitNum) {
		this.submitNum = submitNum;
	}
	public int getSubmitDay() {
		return submitDay;
	}
	public void setSubmitDay(int submitDay) {
		this.submitDay = submitDay;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getIsPublish() {
		return isPublish;
	}
	public void setIsPublish(int isPublish) {
		this.isPublish = isPublish;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public int getIsEnd() {
		return isEnd;
	}
	public void setIsEnd(int isEnd) {
		this.isEnd = isEnd;
	}
	public List<CmsSurveySub> getSubList() {
		return subList;
	}
	public void setSubList(List<CmsSurveySub> subList) {
		this.subList = subList;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getPepoleNum() {
		return pepoleNum;
	}
	public void setPepoleNum(int pepoleNum) {
		this.pepoleNum = pepoleNum;
	}
	
}
