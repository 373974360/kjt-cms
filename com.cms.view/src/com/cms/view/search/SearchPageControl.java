/**
 * 
 */
package com.cms.view.search;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-04 11:03:07
 *
 */
@Bizlet("")
public class SearchPageControl {
	private int curPage ; //当前是第几页 
	private int maxPage ; //一共有多少页 
	private Long maxRowCount ; //一共有多少行 
	private int rowsPerPage = 10 ; //每页有多少行  默认10行
	private int start = 0; //开始的页面条数
	 
	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public Long getMaxRowCount() {
		return maxRowCount;
	}

	public void setMaxRowCount(Long amaxRowCountxRowCount) {
		this.maxRowCount = amaxRowCountxRowCount;
	}

	public int getRowsPerPage() {
		return rowsPerPage;
	}

	public void setRowsPerPage(int rowsPerPage) {
		this.rowsPerPage = rowsPerPage==0?this.rowsPerPage:rowsPerPage;
		//System.out.println("this.rowsPerPage===" + this.rowsPerPage);
	}
	
	public void countMaxPage() {   //根据总行数计算总页数  
	    if (this.maxRowCount % this.rowsPerPage ==0){
	       this.maxPage = (int) (this.maxRowCount/this.rowsPerPage);
	    }else{
	       this.maxPage = (int) (this.maxRowCount/this.rowsPerPage + 1);        
	    }
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
			this.start = start;
	}
	
	public void countStart() {//根据当前页数和每页条数计算开始数 
		this.start = (this.curPage-1)*this.rowsPerPage;
    }
}
