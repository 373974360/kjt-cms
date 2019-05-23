/**
 * 
 */
package com.cms.content;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-05-23 16:46:50
 *
 */
@Bizlet("")
public class GkIndexVo {

	private String year;
	private String index;
	private String num;
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getIndex() {
		return index;
	}
	public void setIndex(String index) {
		this.index = index;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	
}
