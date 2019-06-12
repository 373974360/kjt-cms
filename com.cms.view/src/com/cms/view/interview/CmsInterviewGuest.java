/**
 * 
 */
package com.cms.view.interview;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-12 15:38:01
 *
 */
@Bizlet("")
public class CmsInterviewGuest {

	private int id;
	private int interId;
	private String username;
	private String zw;
	private String work;
	private String remark;
	private String photo;
	private int sort;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getInterId() {
		return interId;
	}
	public void setInterId(int interId) {
		this.interId = interId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getZw() {
		return zw;
	}
	public void setZw(String zw) {
		this.zw = zw;
	}
	public String getWork() {
		return work;
	}
	public void setWork(String work) {
		this.work = work;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	
	
}
