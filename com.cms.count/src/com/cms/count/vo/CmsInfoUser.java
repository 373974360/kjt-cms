/**
 * 
 */
package com.cms.count.vo;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-14 16:02:21
 *
 */
@Bizlet("")
public class CmsInfoUser {

	private int empId;
	private String userName;
	private int count;//信息总数
	private int publisCount;//已发布总数
	private String proportion;//发稿率
	
	
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getPublisCount() {
		return publisCount;
	}
	public void setPublisCount(int publisCount) {
		this.publisCount = publisCount;
	}
	public String getProportion() {
		return proportion;
	}
	public void setProportion(String proportion) {
		this.proportion = proportion;
	}
	
	
}
