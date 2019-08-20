/**
 * 
 */
package com.cms.siteconfig.collection;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.commons.io.FileUtils;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-08-20 09:57:59
 *
 */
@Bizlet("")
public class DownHtmlUtil {
	public static String[] UserAgent = {
        "Mozilla/5.0 (Linux; U; Android 2.2; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.2",
        "Mozilla/5.0 (iPad; U; CPU OS 3_2_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B500 Safari/531.21.11",
        "Mozilla/5.0 (SymbianOS/9.4; Series60/5.0 NokiaN97-1/20.0.019; Profile/MIDP-2.1 Configuration/CLDC-1.1) AppleWebKit/525 (KHTML, like Gecko) BrowserNG/7.1.18121",
        "Nokia5700AP23.01/SymbianOS/9.1 Series60/3.0",
        "UCWEB7.0.2.37/28/998", "NOKIA5700/UCWEB7.0.2.37/28/977",
        "Openwave/UCWEB7.0.2.37/28/978",
        "Mozilla/4.0 (compatible; MSIE 6.0; ) Opera/UCWEB7.0.2.37/28/989"};
	
	public static String downLoadHtml(String StrUrl, String Encode) {
        String htmlStr = "";
        String str = "";
        HttpURLConnection con = null;
        String cookie = "";
        label160:
        try {
            if (StrUrl.length() > 0) {
                URL url = new URL(StrUrl);
                int temp = Integer.parseInt(Math.round(Math.random() * 7) + "");
                con = (HttpURLConnection) url.openConnection();
                con.setDoOutput(true);
                con.setRequestProperty("Pragma", "no-cache");
                con.setRequestProperty("Cache-Control", "no-cache");
                con.setRequestProperty("User-Agent", UserAgent[temp]); // 模拟手机系统
                con.setRequestProperty("Accept",
                        "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");// 只接受text/html类型，当然也可以接受图片,pdf,*/*任意，就是tomcat/conf/web里面定义那些
                con.setConnectTimeout(50000);

                if (cookie.length() != 0)
                    con.setRequestProperty("Cookie", cookie);
                con.setInstanceFollowRedirects(false);
                int httpCode = con.getResponseCode();
                if (httpCode == HttpURLConnection.HTTP_MOVED_TEMP) {
                    cookie += con.getHeaderField("Set-Cookie") + ";";
                }
                if (httpCode != 200)
                    break label160;
                InputStream in = con.getInputStream();
                BufferedReader rd = new BufferedReader(new InputStreamReader(
                        in, Encode));
                while ((str = rd.readLine()) != null) {
                    htmlStr = htmlStr + str;
                }
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            con.disconnect();
        }
        return htmlStr;
    }
	
	
	
	/**
     * @param urlStr  下载图片的完整URL
     * @param picName 图片名称（带路径）
     * @return
     */
    public static boolean writePicToLocal(String urlStr, String picName) {
        boolean flag = false;
        HttpURLConnection con = null;
        String picMkdir = picName.substring(0, picName.lastIndexOf("/"));
        String pic_name = picName.substring(picName.lastIndexOf("/") + 1, picName.length());
        String path = DownHtmlUtil.class.getClassLoader().getResource("").getPath().substring(1);
        String picPath = path.substring(0,path.indexOf("WEB-INF")-1)+"/collArtPic/"+picMkdir;
        try {
            File file = new File(picPath);
            if (!file.exists()) {
                file.mkdirs();
            }
            URL url = new URL(urlStr);
            con = (HttpURLConnection) url.openConnection();
            con.setConnectTimeout(5000);
            con.setReadTimeout(60000);
            String savePath = picPath + File.separator + pic_name;
            int code = con.getResponseCode();
            if (code == 200) {
                FileUtils.copyInputStreamToFile(con.getInputStream(), new File(savePath));
                flag = true;
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            con.disconnect();
        }
        return flag;
    }

    public static String getDomainUrl(String url) {
        String domain = "";
        if (url.length() > 0) {
            if(url.startsWith("http://")){
                String reg = ".*\\/\\/([^\\/\\:]*).*";
                domain = "http://" + url.replaceAll(reg, "$1");
            }else{
                String reg = ".*\\/\\/([^\\/\\:]*).*";
                domain = "https://" + url.replaceAll(reg, "$1");
            }
        }
        return domain;
    }
    public static String formatLink(String parentUrl, String aLink, String domain) {
        if (aLink.startsWith("http://")) {
            return aLink;
        } else {

            String link = "";
            if (aLink.startsWith("/")) {
                link = domain + aLink;
            } else {
                link = parentUrl.substring(0, parentUrl.lastIndexOf("/")) + "/" + aLink;

            }
            return link;
        }
    }

}
