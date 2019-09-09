/**
 * 
 */
package com.cms.view.search;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-04 11:04:09
 *
 */
@Bizlet("")
public class ResultBean {
	private String url;
	private String title;
	private String content;
	private String time;
	private String type;
	private String id;
	private String site_id;
	private String category_id;
	private String category_name;
	private String model_id;
	private String retype = "news";//资源的类型参数    默认是新闻
	private String thumb_url;
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = SearchUtil.deleteCodeByContent(content);;
	}
	public String getTime() {
		return time; 
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSite_id() {
		return site_id;
	}
	public void setSite_id(String siteId) {
		site_id = siteId;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String categoryId) {
		category_id = categoryId;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String categoryName) {
		category_name = categoryName;
	}
	public String getModel_id() {
		return model_id;
	}
	public void setModel_id(String modelId) {
		model_id = modelId;
	}
	public String getRetype() {
		return retype;
	}
	public void setRetype(String retype) {
		this.retype = retype;
	}
	public String getThumb_url() {
		return thumb_url;
	}
	public void setThumb_url(String thumb_url) {
		this.thumb_url = thumb_url;
	}
	
}
