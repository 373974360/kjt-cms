/**
 * 
 */
package com.cms.count.vo;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-14 16:03:14
 *
 */
@Bizlet("")
public class CmsInfoOrg {

	private String orgName;
	private int count;//信息总数
	private int publisCount;//已发布总数
	private String proportion;//发稿率
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
