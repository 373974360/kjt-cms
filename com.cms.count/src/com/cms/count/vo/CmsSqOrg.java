/**
 * 
 */
package com.cms.count.vo;

import com.eos.system.annotation.Bizlet;

/**
 * @author maxiaoqiang
 * @version 1.00.00
 * 
 */
@Bizlet("")
public class CmsSqOrg {

	private String orgName;
	private int count;//总件数
	private int inHand;//处理中
	private int replied;//已办结
	private String proportion;//办结率
	
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getInHand() {
		return inHand;
	}
	public void setInHand(int inHand) {
		this.inHand = inHand;
	}
	public int getReplied() {
		return replied;
	}
	public void setReplied(int replied) {
		this.replied = replied;
	}
	public String getProportion() {
		return proportion;
	}
	public void setProportion(String proportion) {
		this.proportion = proportion;
	}
	
	
}
