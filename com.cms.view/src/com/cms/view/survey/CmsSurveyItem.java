/**
 * 
 */
package com.cms.view.survey;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-11 15:03:25
 *
 */
@Bizlet("")
public class CmsSurveyItem {
	private int id;
	private int surveyId;
	private int subId;
	private String itemName;
	private int sort;
	private int num;//票数
	private String proportion;//百分比
	
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
	public int getSubId() {
		return subId;
	}
	public void setSubId(int subId) {
		this.subId = subId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getProportion() {
		return proportion;
	}
	public void setProportion(String proportion) {
		this.proportion = proportion;
	}
	
}
