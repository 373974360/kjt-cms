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
public class CmsSqLxmd {

	private String mdName;//来信目的名称
	private int count;//来信总数
	private int repliedCount;//已回复树
	private int noReCount;//未回复数
	
	public String getMdName() {
		return mdName;
	}
	public void setMdName(String mdName) {
		this.mdName = mdName;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getRepliedCount() {
		return repliedCount;
	}
	public void setRepliedCount(int repliedCount) {
		this.repliedCount = repliedCount;
	}
	public int getNoReCount() {
		return noReCount;
	}
	public void setNoReCount(int noReCount) {
		this.noReCount = noReCount;
	}
	

}
