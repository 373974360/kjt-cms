/**
 * 
 */
package com.cms.view.velocity;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-05-23 11:25:51
 * 
 */
@Bizlet("分页")
public class TurnPageBean {
	private int cur_page = 1;
	private int count = 0;
	private int page_count = 1;
	private int prev_num = 1;
	private int next_num = 1;
	private int page_size = 10;
	private int curr_start_num = 3;

	public int getCurr_start_num() {
		return this.curr_start_num;
	}

	public void setCurr_start_num(int currStartNum) {
		this.curr_start_num = currStartNum;
	}

	public int getCur_page() {
		return this.cur_page;
	}

	public void setCur_page(int curPage) {
		this.cur_page = curPage;
	}

	public int getCount() {
		return this.count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getPage_count() {
		return this.page_count;
	}

	public void setPage_count(int pageCount) {
		this.page_count = pageCount;
	}

	public int getPrev_num() {
		return this.prev_num;
	}

	public void setPrev_num(int prevNum) {
		this.prev_num = prevNum;
	}

	public int getNext_num() {
		return this.next_num;
	}

	public void setNext_num(int nextNum) {
		this.next_num = nextNum;
	}

	public int getPage_size() {
		return this.page_size;
	}

	public void setPage_size(int pageSize) {
		this.page_size = pageSize;
	}
}
