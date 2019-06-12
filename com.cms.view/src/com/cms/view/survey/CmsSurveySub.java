/**
 * 
 */
package com.cms.view.survey;

import java.util.List;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-11 15:03:16
 *
 */
@Bizlet("")
public class CmsSurveySub {

	private int id;
	private int surveyId;
	private String subTitle;
	private int subType;
	private int isRequired;
	private int num;//票数
	private int sort;
	private List<CmsSurveyItem> itemList;
	private List<CmsSurveyItemText> itemTextlist;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSurveyId() {
		return surveyId;
	}
	public void setSurveyId(int surveyId) {
		this.surveyId = surveyId;
	}
	public String getSubTitle() {
		return subTitle;
	}
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}
	public int getSubType() {
		return subType;
	}
	public void setSubType(int subType) {
		this.subType = subType;
	}
	public int getIsRequired() {
		return isRequired;
	}
	public void setIsRequired(int isRequired) {
		this.isRequired = isRequired;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public List<CmsSurveyItem> getItemList() {
		return itemList;
	}
	public void setItemList(List<CmsSurveyItem> itemList) {
		this.itemList = itemList;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public List<CmsSurveyItemText> getItemTextlist() {
		return itemTextlist;
	}
	public void setItemTextlist(List<CmsSurveyItemText> itemTextlist) {
		this.itemTextlist = itemTextlist;
	}
	
}
