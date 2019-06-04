/**
 * 
 */
package com.cms.view.search;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.queryParser.MultiFieldQueryParser;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.QueryWrapperFilter;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.SortField;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.highlight.Highlighter;
import org.apache.lucene.search.highlight.QueryScorer;
import org.apache.lucene.search.highlight.SimpleFragmenter;
import org.apache.lucene.search.highlight.SimpleHTMLFormatter;
import org.apache.lucene.util.Version;
import org.wltea.analyzer.lucene.IKAnalyzer;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-04 11:32:57
 *
 */
@Bizlet("")
public class SearchInfoManager {
	/**
	 *得到关键词的query
	 *@param String scope 搜索范围：标题 title,正文 content
	 *@param String q 关键词
	 */
	public static Query getQuery(String scope,String q){
		Query query = null;
		try{
			List fieldsList = new ArrayList();
			List keysList = new ArrayList();
			List occurList = new ArrayList();
			//System.out.println("scope===" + scope);
			if(scope.equals("")){
				fieldsList.add("infoTitle");
				fieldsList.add("infoContent");
				fieldsList.add("gkNo");
				keysList.add(q);
				keysList.add(q);
				keysList.add(q);
				occurList.add(BooleanClause.Occur.SHOULD);
				occurList.add(BooleanClause.Occur.SHOULD);;
				occurList.add(BooleanClause.Occur.SHOULD);
			} else if(scope.equals("title")){
				fieldsList.add("infoTitle");
				keysList.add(q);
				occurList.add(BooleanClause.Occur.SHOULD);
			} else if(scope.equals("content")){
				fieldsList.add("infoContent");
				keysList.add(q);
				occurList.add(BooleanClause.Occur.SHOULD);
			} else if(scope.equals("gkNo")){
				fieldsList.add("gkNo");
				keysList.add(q);
				occurList.add(BooleanClause.Occur.SHOULD);
			}
			String[] fields = (String[])fieldsList.toArray(new String[fieldsList.size()]);//搜索的字段
			String[] keys = (String[])keysList.toArray(new String[keysList.size()]);//关键字数组
			BooleanClause.Occur[] flags = (BooleanClause.Occur[])occurList.toArray(new BooleanClause.Occur[occurList.size()]);
			
			QueryParser parser = new MultiFieldQueryParser(Version.LUCENE_30, fields, new StandardAnalyzer(Version.LUCENE_30));
			query = parser.parse(q);
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			return query;
		}
	}
	//根据参数过滤条件
	public static String getTypeQuery(String key,String str){
		StringBuffer sb = new StringBuffer();
		if(str.indexOf(",")>0){
		    sb.append("(");
			String temp[] = str.split(",");
			for(int i=0;i<temp.length;i++){
				if(i==temp.length-1){
					sb.append("("+key+":"+temp[i]+")");
				}else{
					sb.append("("+key+":"+temp[i]+") || ");
				}
			}
			sb.append(")");
			return sb.toString();
		}else if(!str.toString().equals("")){
			sb.append("("+key+":"+str+")");
			return sb.toString();
		}else{
			return "";
		}
	}
	public static String getRetypeQuery(String key,String value){
		StringBuffer sb = new StringBuffer();
		if(!key.equals("") && !value.equals("")){
			sb.append("(retype:"+value+")");
			return sb.toString();
		}else{ 
			return "";
		}
	}
	//根据参数过滤条件 --- 按信息栏目条件来过滤
	public static String getCategoryIdQuery(String key,String str){
		StringBuffer sb = new StringBuffer();
		if(str.indexOf(",")>0){
		    sb.append("(");
			String temp[] = str.split(",");
			for(int i=0;i<temp.length;i++){
				if(i==temp.length-1){
					sb.append("("+key+":"+temp[i]+")");
				}else{
					sb.append("("+key+":"+temp[i]+") || ");
				}
			}
			sb.append(")");
			return sb.toString();
		}else if(!str.toString().equals("")){
			sb.append("("+key+":"+str+")");
			return sb.toString();
		}else{
			return "";
		}
	}
	//根据参数过滤条件     map 里面是 参数-值
	public static String getAllQuery(Map map){
		StringBuffer sb = new StringBuffer("");
	    Iterator it = map.keySet().iterator();
	    int i = 0;
	    while(it.hasNext()){
	    	i++;
		    String key = (String)it.next();
		    String object = (String)map.get(key);
		    if(key.equals("type")){
		    	if(!sb.toString().trim().equals("") && sb.toString().trim().endsWith(")")){
		    		sb.append(" && ");
		    	}
		    	sb.append(getTypeQuery(key,object));
		    } else if(key.equals("retype")){
		    	if(!object.equals("all")){
		    		if(!sb.toString().trim().equals("") && sb.toString().trim().endsWith(")")){
			    		sb.append(" && ");
			    	} 
			    	sb.append(getRetypeQuery(key,object));
		    	}
		    }  else if(key.equals("categoryId")){
		    	if(!sb.toString().trim().equals("") && sb.toString().trim().endsWith(")")){
		    		sb.append(" && ");
		    	} 
		    	sb.append(getCategoryIdQuery(key,object));
		    }else if(key.equals("site_id")){
		    	String typef = (String)map.get("type");
		    	if(typef==null){ 
		    		typef = "";
		    	}
		    }else{
		    	if(!sb.toString().trim().equals("")){
		    		sb.append(" && ");
		    	}
			    if(i==map.size()){
			    	sb.append("("+key+":"+object+")");
			    }else{
			    	sb.append("("+key+":"+object+")");
			    }
		    }
	    } 
	    //System.out.println("sb.toString()====" + sb.toString());
	    return sb.toString();
	}
	/**
	 *简单搜索
	 *@param Map map
	 *
	  map.remove("type");//搜索标示  没有该值说明全部信息 （ggfw：服务，info：信息，xxgk：信息公开）
	  map.remove("q");//关键字        *必须
	  map.remove("q2");//关键字2
	  map.remove("p");//当前页数     
	  map.remove("pz");//页面显示条数
	  map.remove("length");//结果页面简介个数
	  map.remove("color");//高亮字颜色
	  map.remove("site_id");//站点id  前台表单传过来的参数为""时 默认本站点  为"all"时 是所有站点
	  map.remove("categoryId");//所属栏目  
	  map.remove("scope");//搜索范围：标题 title,正文 content , 全部为""
	 *@return Map   
	 * */
	public static SearchResult search(Map map){ 
		SearchResult searchResult = new SearchResult();
		long timeS = System.currentTimeMillis();
	    List listResult = new ArrayList();//存放搜索结果
	    IndexSearcher indexSearcher = null;
		try{
			String q = (String)map.get("q");
			if(q==null){
				return searchResult; 
			}
			String scope = (String)map.get("scope")==null?"":(String)map.get("scope");//搜索范围：标题 title,正文 content
			Query query = getQuery(scope, q);
			indexSearcher = SearchLuceneManager.getIndexSearcher();
			if(indexSearcher==null){
				return searchResult;   
			}
			//要排序的字段     false是正序，true是倒叙   (多个字段进行排序)  -- 先按时间倒叙再按id倒叙
			Sort sort = new Sort(new SortField[]{new SortField("publishTime", SortField.STRING,true),new SortField("id", SortField.INT,true)});

			BooleanQuery booleanQuery = new BooleanQuery();
			booleanQuery.add(query, BooleanClause.Occur.MUST);
			
			//过滤条件
			QueryParser parser = new MultiFieldQueryParser(Version.LUCENE_30, new String[]{""}, new IKAnalyzer());
			
			//去除不要过滤的字段
			int p = (String)map.get("p")==null?1:Integer.valueOf((String)map.get("p"));//当前是第几页
			int pz = (String)map.get("pz")==null?0:Integer.valueOf((String)map.get("pz"));//页面显示条数
			int length = (String)map.get("length")==null?100:Integer.valueOf((String)map.get("length"));//结果页面简介个数
			String color = "red";//高亮字颜色
			map.remove("q");
			map.remove("p");
			map.remove("pz");
			map.remove("length");
			map.remove("color"); 
			map.remove("scope");
			
			String tempQuery = getAllQuery(map);
			QueryWrapperFilter filter = tempQuery.equals("")?null:new QueryWrapperFilter(parser.parse(tempQuery.toString()));
					
			//分页信息
			SearchPageControl pageControl = new SearchPageControl();
			pageControl.setRowsPerPage(pz);//每页有多少行  默认10行
			pageControl.setCurPage(p);//当前页数
			pageControl.countStart();//根据当前页数和每页条数计算开始数
			int sn = pageControl.getStart();
			pz = pageControl.getRowsPerPage();
			
			TopDocs hits = indexSearcher.search(booleanQuery , filter, (Integer.valueOf(sn)+Integer.valueOf(pz)), sort);
			
			//分页信息
			pageControl.setMaxRowCount(Long.valueOf(hits.totalHits));//一共有多少行 
			pageControl.countMaxPage(); //根据总行数计算总页数 
			
			//高亮显示设置 
		    Highlighter highlighter = null; 
		    SimpleHTMLFormatter simpleHTMLFormatter = new SimpleHTMLFormatter("<font color='"+color+"'>", "</font>"); 
		    highlighter = new Highlighter(simpleHTMLFormatter, new QueryScorer(booleanQuery)); 
		    // 这个100是指定关键字字符串的context的长度，你可以自己设定，因为不可能返回整篇正文内容 
		    highlighter.setTextFragmenter(new SimpleFragmenter(length));
		    
		    // 循环hits.scoreDocs数据，并使用indexSearch.doc方法把Document还原，再拿出对应的字段的值
			for (int j = sn; j < hits.scoreDocs.length; j++) {
				ScoreDoc sdoc = hits.scoreDocs[j];
				Document doc = indexSearcher.doc(sdoc.doc);
				// 高亮显示摘要 
				String content = doc.get("infoContent");
				String contentTemp = content;
		        TokenStream tokenStream = new StandardAnalyzer(Version.LUCENE_30).tokenStream("token",new StringReader(content));
		        content = highlighter.getBestFragment(tokenStream, content); 
		        //如果没有高亮 就截取内容一段
				if(content==null || content.equals("")){
					int countWords = Integer.valueOf(length);
					if(countWords>=contentTemp.length()){
						content = contentTemp;
					}else{
						content = contentTemp.substring(0,countWords);
					}
				}
				String url = doc.get("contentUrl");
				String title = doc.get("infoTitle");
				String type = doc.get("infoType");
				String time = doc.get("publishTime");
				String id = doc.get("id");
				String categoryId = doc.get("catId");
				String site_id = doc.get("siteId");
				String model_id = doc.get("modelId");
				ResultBean resultBean = new ResultBean();
				resultBean.setUrl(url);
				resultBean.setTitle(title);
				resultBean.setType(type);
				resultBean.setTime(time);
				resultBean.setId(id);
				resultBean.setCategory_id(categoryId);
				resultBean.setCategory_name("");
				resultBean.setSite_id(site_id);
				resultBean.setContent(content);
				resultBean.setModel_id(model_id);
				listResult.add(resultBean);
				
			}
			//得到搜索所用时间
			timeS = System.currentTimeMillis() - timeS;
			Double timeQ = Arith.div(Double.valueOf(timeS), Double.valueOf(2000), 2);
			searchResult.setItems(listResult);
			searchResult.setPageControl(pageControl);
			searchResult.setTime(String.valueOf(timeQ));
			searchResult.setKey(q);
			searchResult.setCount(pageControl.getMaxRowCount());
			indexSearcher.close();
			return searchResult;
		}catch (Exception e) {
			e.printStackTrace();
			if(indexSearcher!=null){
				try {
					indexSearcher.close();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
			return searchResult;
		}
	}
}
