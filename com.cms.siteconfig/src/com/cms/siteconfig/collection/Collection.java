/**
 * 
 */
package com.cms.siteconfig.collection;

import java.util.LinkedHashSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-08-20 09:52:15
 *
 */
@Bizlet("")
public class Collection {

	@Bizlet("")
	public static void CollectionData(DataObject obj) {
		String collUrl = obj.getString("collUrl");
		LinkedHashSet urlSet = initPageUrl(collUrl);
		String domain = DownHtmlUtil.getDomainUrl(collUrl);
		while (urlSet.size() > 0) {
			String url = (String) urlSet.iterator().next();
			System.out.println("开始采集链接地址为: " + url + " 的列表");
			String listPagehStr = DownHtmlUtil.downLoadHtml(url, obj.getString("pageCharset"));
			urlSet.remove(url);
			if (StringUtils.isNotBlank(listPagehStr)){
				LinkedHashSet waitgetArtInfoSet = ResolveHtml.ResolveHtmlForLink(listPagehStr, domain,obj.getString("listTagsStart"), obj.getString("listTagsEnd"),url);
				ResolveHtml.getArticleInfoHtml(obj, waitgetArtInfoSet);
			}
        }
	}
	
	
	
	
	public static LinkedHashSet<String> initPageUrl(String url) {
        LinkedHashSet startCollURLSet = new LinkedHashSet();
        if (url.contains("$")) {
            String[] arrayurl = url.split("\\u0024");
            for (int i = 0; i < arrayurl.length; i++) {
                if (!geturlIsHaveMark(arrayurl[i])) {
                    startCollURLSet.add(arrayurl[i]);
                } else {
                    String urlInfo = geturmMarkInfo(arrayurl[i]);
                    String[] array = urlInfo.split(",");
                    String type = array[0].toString();
                    int a1 = Integer.parseInt(array[1].toString());
                    int n = Integer.parseInt(array[2].toString());
                    int dorq = Integer.parseInt(array[3].toString());
                    if (type.equals("0"))
                        for (int k = 1; k <= n; k++) {
                            String tempurl = arrayurl[i];
                            int an = a1 + (k - 1) * dorq;
                            tempurl = tempurl.replaceAll("[<](.*?)[>]+", an + "");
                            startCollURLSet.add(tempurl);
                        }
                    else {
                        for (int j = 1; j <= n; j++) {
                            String tempurl = arrayurl[i];
                            int an = (int) (a1 * Math.pow(dorq, j - 1));
                            tempurl = tempurl.replaceAll("[<](.*?)[>]+", an + "");
                            startCollURLSet.add(tempurl);
                        }
                    }
                }
            }
        } else if (!geturlIsHaveMark(url)) {
            startCollURLSet.add(url);
        } else {
            String urlInfo = geturmMarkInfo(url);
            String[] array = urlInfo.split(",");
            String type = array[0].toString();
            int a1 = Integer.parseInt(array[1].toString());
            int n = Integer.parseInt(array[2].toString());
            int dorq = Integer.parseInt(array[3].toString());
            if (type.equals("0"))
                for (int k = 1; k <= n; k++) {
                    String tempurl = url;
                    int an = a1 + (k - 1) * dorq;
                    tempurl = tempurl.replaceAll("[<](.*?)[>]+", an + "");
                    startCollURLSet.add(tempurl);
                }
            else {
                for (int j = 1; j <= n; j++) {
                    String tempurl = url;
                    int an = (int) (a1 * Math.pow(dorq, j - 1));
                    tempurl = tempurl.replaceAll("[<](.*?)[>]+", an + "");
                    startCollURLSet.add(tempurl);
                }
            }

        }

        return startCollURLSet;
    }
	
	
	public static boolean geturlIsHaveMark(String url) {
        String reg = "(.*?)[<](.*?)[>](.*?)+";
        Pattern p = Pattern.compile(reg);
        Matcher m = p.matcher(url);
        boolean b = m.matches();
        return b;
    }
	public static String geturmMarkInfo(String urlMark) {
        String info = "";
        String reg = "[<](.*?)[>]+";
        Pattern p = Pattern.compile(reg);
        Matcher m = p.matcher(urlMark);
        while (m.find()) {
            info = m.group();
        }
        info = info.replaceAll("[<](.*?)[>]+", "$1");
        return info;
    }
}
