/**
 * 
 */
package com.cms.count.vo;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-14 14:16:26
 *
 */
@Bizlet("")
public class CmsInfoCategory {

	private int id;
	private int pid;
	private String text;
	private int count;//信息总数
	private int publisCount;//已发布总数
	private String proportion;//发稿率
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
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
