/**
 * 
 */
package com.cms.view.vo;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-07-05 09:15:52
 *
 */
@Bizlet("")
public class CmsInfo {

	private int id;
	private String infoTitle;
	private String userName;
	private String orgName;
	private String source;
	private String editor;
	private String releasedDtime;
	private int infoStatus;
	private String date;
	private String catName;
	private String replayUser;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getInfoTitle() {
		return infoTitle;
	}
	public void setInfoTitle(String infoTitle) {
		this.infoTitle = infoTitle;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getEditor() {
		return editor;
	}
	public void setEditor(String editor) {
		this.editor = editor;
	}
	public String getReleasedDtime() {
		return releasedDtime;
	}
	public void setReleasedDtime(String releasedDtime) {
		this.releasedDtime = releasedDtime;
	}
	public int getInfoStatus() {
		return infoStatus;
	}
	public void setInfoStatus(int infoStatus) {
		this.infoStatus = infoStatus;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
	}
	public String getReplayUser() {
		return replayUser;
	}
	public void setReplayUser(String replayUser) {
		this.replayUser = replayUser;
	}
	
	
}
