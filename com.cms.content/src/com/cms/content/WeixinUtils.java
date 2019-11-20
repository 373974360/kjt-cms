/**
 * 
 */
package com.cms.content;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import net.sf.json.JSONObject;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.util.EntityUtils;
import org.apache.http.HttpEntity;

import com.cms.siteconfig.TempletUtils;
import com.cms.view.velocity.DateUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author chaoweima
 * @date 2019-07-12 09:20:20
 *
 */
@Bizlet("微信推送")
public class WeixinUtils {
	
	public static String appid = "";
    private static String secret = "";
    private static String accessTockenUrl = "";
    private static String perUploadUrl = "";
    private static String uploadUrl = "";
    private static String sendAllUrl = "";
    private static String domain = "";
    private static String defautImag = "";
    private static String tocken = "";
    private static String rootpath = "";
    private static String previewUrl = "";
    private static String testwxname = "";// 接收预览信息的微信号
    private static String sendtype = "";// 0:代表正式群发  1:代表测试群发预览
    private static String jsapiTicketUrl = "";
    private static String show_cover_pic = "";//是否显示封面，1为显示，0为不显示
    private static String uploadConImg = "";
    private static String savePath = "";
    private static Map<String, String> tokenMap = new HashMap<String,String>();
    private static Map<String, String> ticketMap = new HashMap<String,String>();
    
    public static String AccessTockenOk() {
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet(accessTockenUrl);
        JSONObject jsonObject;
        String tokenStr = "";
        try {
            CloseableHttpResponse response = httpClient.execute(httpGet);
            HttpEntity entity = response.getEntity();
            if (entity != null) {
                String result = EntityUtils.toString(entity, "UTF-8");
                System.out.println(result);
                jsonObject = JSONObject.fromObject(result);
                boolean isExit = jsonObject.containsKey("access_token");
                tokenStr = isExit ? jsonObject.getString("access_token") : "";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tokenStr;
    }
    
    public static String getToken() {
        String lifeStr = tokenMap.get("tokenLife") == null ? null : tokenMap.get("tokenLife").toString();
        Long life = 0L;
        if (lifeStr != null && !"".equals(lifeStr)) {
            life = Long.parseLong(lifeStr);
        }

        String tokenValue = tokenMap.get("tokenValue") == null ? null : tokenMap.get("tokenValue").toString();
        if (!"".equals(tokenValue) && tokenValue != null && (new Date()).getTime() <= life + 7200000L) {
            return tokenValue;
        } else {
            String token = AccessTockenOk();
            saveToken(token, String.valueOf((new Date()).getTime()));
            return token;
        }
    }
    public static void saveToken(String value, String life) {
        tokenMap.put("tokenLife", life);
        tokenMap.put("tokenValue", value);
    }
    
    public static String getJSApiTicket() {
        CloseableHttpClient httpClient = HttpClients.createDefault();
        String url = jsapiTicketUrl.replace("##tocken##", tocken);
        HttpGet httpGet = new HttpGet(url);
        JSONObject jsonObject;
        String ticket = "";
        try {
            CloseableHttpResponse response = httpClient.execute(httpGet);
            HttpEntity entity = response.getEntity();
            if (entity != null) {
                String result = EntityUtils.toString(entity, "UTF-8");
                jsonObject = JSONObject.fromObject(result);
                boolean isExit = jsonObject.containsKey("ticket");
                ticket = isExit ? jsonObject.getString("ticket") : "";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ticket;
    }
    
    public static String getTicket() {
        String lifeStr = ticketMap.get("ticketLife") == null ? null : ticketMap.get("ticketLife").toString();
        Long life = 0L;
        if (lifeStr != null && !"".equals(lifeStr)) {
            life = Long.parseLong(lifeStr);
        }

        String ticketValue = ticketMap.get("ticketValue") == null ? null : ticketMap.get("ticketValue").toString();
        if (!"".equals(ticketValue) && ticketValue != null && (new Date()).getTime() <= life + 7200000L) {
            return ticketValue;
        } else {
            String ticket = getJSApiTicket();
            saveTicket(ticket, String.valueOf((new Date()).getTime()));
            return ticket;
        }
    }
    public static void saveTicket(String value, String life) {
        ticketMap.put("ticketLife", life);
        ticketMap.put("ticketValue", value);
    }
    public static String create_nonce_str() {
        return UUID.randomUUID().toString();
    }
    public static String create_timestamp() {
        return Long.toString(System.currentTimeMillis() / 1000);
    }
    
    public static String uploadImage(String url, String filePath) throws IOException {
        String result = null;
        System.out.println(filePath);
        File file = new File(filePath);
        if (file.exists() && file.isFile()) {
            URL urlObj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) urlObj.openConnection();
            con.setRequestMethod("POST");
            con.setDoInput(true);
            con.setDoOutput(true);
            con.setUseCaches(false);
            con.setRequestProperty("Connection", "Keep-Alive");
            con.setRequestProperty("Charset", "UTF-8");
            String BOUNDARY = "---------------------------" + System.currentTimeMillis();
            con.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);
            StringBuilder sb = new StringBuilder();
            sb.append("--");
            sb.append(BOUNDARY);
            sb.append("\r\n");
            sb.append("Content-Disposition: form-data;name=\"media\";filename=\"" + file.getName() + "\"\r\n");
            sb.append("Content-Type:application/octet-stream\r\n\r\n");
            byte[] head = sb.toString().getBytes("utf-8");
            OutputStream out = new DataOutputStream(con.getOutputStream());
            out.write(head);
            DataInputStream in = new DataInputStream(new FileInputStream(file));
            byte[] bufferOut = new byte[1024];

            int bytes;
            while ((bytes = in.read(bufferOut)) != -1) {
                out.write(bufferOut, 0, bytes);
            }

            in.close();
            byte[] foot = ("\r\n--" + BOUNDARY + "--\r\n").getBytes("utf-8");
            out.write(foot);
            out.flush();
            out.close();
            StringBuffer buffer = new StringBuffer();
            BufferedReader reader = null;
            try {
                reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String line = null;

                while ((line = reader.readLine()) != null) {
                    buffer.append(line);
                }

                if (result == null) {
                    result = buffer.toString();
                }
            } catch (IOException e) {
                System.out.println("发送POST请求出现异常！" + e);
                e.printStackTrace();
                throw new IOException("数据读取异常");
            } finally {
                if (reader != null) {
                    reader.close();
                }

            }
            JSONObject object = JSONObject.fromObject(result);
            System.out.println(object.toString());
            return object.getString("media_id");
        } else {
            throw new IOException("文件不存在");
        }
    }
    
    public static String uploadConImage(String url, String filePath) throws IOException {
        String result = null;
        System.out.println(filePath);
        File file = new File(filePath);
        if (file.exists() && file.isFile()) {
            URL urlObj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) urlObj.openConnection();
            con.setRequestMethod("POST");
            con.setDoInput(true);
            con.setDoOutput(true);
            con.setUseCaches(false);
            con.setRequestProperty("Connection", "Keep-Alive");
            con.setRequestProperty("Charset", "UTF-8");
            String BOUNDARY = "---------------------------" + System.currentTimeMillis();
            con.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);
            StringBuilder sb = new StringBuilder();
            sb.append("--");
            sb.append(BOUNDARY);
            sb.append("\r\n");
            sb.append("Content-Disposition: form-data;name=\"media\";filename=\"" + file.getName() + "\"\r\n");
            sb.append("Content-Type:application/octet-stream\r\n\r\n");
            byte[] head = sb.toString().getBytes("utf-8");
            OutputStream out = new DataOutputStream(con.getOutputStream());
            out.write(head);
            DataInputStream in = new DataInputStream(new FileInputStream(file));
            byte[] bufferOut = new byte[1024];

            int bytes;
            while ((bytes = in.read(bufferOut)) != -1) {
                out.write(bufferOut, 0, bytes);
            }

            in.close();
            byte[] foot = ("\r\n--" + BOUNDARY + "--\r\n").getBytes("utf-8");
            out.write(foot);
            out.flush();
            out.close();
            StringBuffer buffer = new StringBuffer();
            BufferedReader reader = null;

            try {
                reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String line = null;

                while ((line = reader.readLine()) != null) {
                    buffer.append(line);
                }

                if (result == null) {
                    result = buffer.toString();
                }
            } catch (IOException e) {
                System.out.println("发送POST请求出现异常！" + e);
                e.printStackTrace();
                throw new IOException("数据读取异常");
            } finally {
                if (reader != null) {
                    reader.close();
                }

            }
            JSONObject object = JSONObject.fromObject(result);
            System.out.println(object.toString());
            return object.getString("url");
        } else {
            throw new IOException("文件不存在");
        }
    }
    
    public static String upload(String url, DataObject[] articleList) throws Exception {
        String data = "{\"articles\": [";
        String articleStr = "";
        String imgpath = "";
        String tempUrl = perUploadUrl.replace("##tocken##", tocken);
        String uploadConImgUrl = uploadConImg.replace("##tocken##", tocken);
        for (int i = 0; i < articleList.length; ++i) {
            imgpath = defautImag;
            DataObject ab = articleList[i];
            String content = ab.getString("infoContent").replace("\"", "'");
            String description = ab.getString("description");
            if(StringUtils.isNotEmpty(description)&&description.length()>50){
                description = description.substring(0,50);
            }
            List<String> imgList = getImgSrc(content);
            if(!imgList.isEmpty()){
                for(String str:imgList){
                    String img_path = str.replace("'","");
                    if(img_path.substring(img_path.length()-1,img_path.length()).equals("/")){
                        img_path = img_path.substring(0,img_path.length()-1);
                    }
                    if(img_path.substring(0,4).equals("http")){
                        if(img_path.indexOf(domain)!=-1){
                            img_path = img_path.replace("https://"+domain,"");
                            img_path = img_path.replace("http://"+domain,"");
                        }else{
                            img_path = downloadPicture(img_path);
                        }
                    }
                    if(StringUtils.isNotEmpty(img_path)){
                        img_path = rootpath+img_path;
                        String u_url = uploadConImage(uploadConImgUrl,img_path);
                        content = content.replace(str,u_url);
                    }
                }
            }
            if (StringUtils.isNotEmpty(ab.getString("thumbUrl")) && !ab.getString("thumbUrl").substring(0, 4).equals("http")) {
                imgpath = rootpath + ab.getString("thumbUrl");
            }
            String temp_media_id = uploadImage(tempUrl, imgpath);
            if(description=="null"||description==null){
            	description="";
            }else{
            	description = description.replaceAll("&nbsp;","");
            }
            String author = ab.getString("author");
            if(author==null||author==""||author=="null"){
            	author = ab.getString("editor");
            }
            articleStr = articleStr + ",{\"thumb_media_id\":\"" + temp_media_id + "\",\"author\":\"" + author + "\",\"title\":\"" + ab.getString("infoTitle") + "\",\"content\":\"" + content + "\",\"digest\":\"" + description + "\",\"show_cover_pic\":\"" + show_cover_pic + "\"}";
        }
        data = data + articleStr.substring(1) + "]}";
        JSONObject jsonObject = CommUtil.httpRequest(url, "POST", data);
        System.out.println(jsonObject.toString());
        return jsonObject.getString("media_id");
    }
    
    //正式群发 -- 已关注的所有用户
    public static boolean sendGroupMessage(String mediaId) {
        String sendUrl = sendAllUrl.replace("##tocken##", tocken);
        String gdata = "{\"filter\":{\"is_to_all\":true},\"mpnews\":{\"media_id\":\"" + mediaId + "\"},\"msgtype\":\"mpnews\", \"send_ignore_reprint\":0}";
        JSONObject json = CommUtil.httpRequest(sendUrl, "POST", gdata);
        if (json.get("errcode").toString().equals("0")) {
            return true;
        }
        return false;
    }
    
    //群发预览  -- testwxname  指定的接收微信号
    public static boolean previewMessage(String mediaId) {
        String sendUrl = previewUrl.replace("##tocken##", tocken);
        String gdata = "{\"towxname\":\"" + testwxname + "\",\"mpnews\":{\"media_id\":\"" + mediaId + "\"},\"msgtype\":\"mpnews\"}";
        JSONObject json = CommUtil.httpRequest(sendUrl, "POST", gdata);
        if (json.get("errcode").toString().equals("0")) {
            return true;
        }
        return false;
    }
    
    @Bizlet("微信推送")
    public static boolean doPush(DataObject[] articleList) throws Exception {
        initParams();
        String upUrl = uploadUrl.replace("##tocken##", tocken);
        String temp_id = upload(upUrl, articleList);
        boolean flag = false;
        //if (sendtype.equals("0")) {
        //    flag = sendGroupMessage(temp_id);//正式群发
        //} else {
        //    flag = previewMessage(temp_id);//测试预览
        //}
        return flag;
    }
    
    public static void initParams() {
    	appid = "wx22edd61c7e4a696f";
        secret = "936c1fb5b5a7e92fca87004f546a6f9b";
        accessTockenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=";
        perUploadUrl = "https://api.weixin.qq.com/cgi-bin/material/add_material?access_token=##tocken##&type=image";
        uploadUrl = "https://api.weixin.qq.com/cgi-bin/material/add_news?access_token=##tocken##";
        sendAllUrl = "https://api.weixin.qq.com/cgi-bin/message/mass/sendall?access_token=##tocken##";
        domain = "";
        defautImag = getRootPath() + "default/images/default.png";
        tocken = "";
        rootpath = getRootPath();
        previewUrl = "https://api.weixin.qq.com/cgi-bin/message/mass/preview?access_token=##tocken##";
        testwxname = "mcw1314wm";// 接收预览信息的微信号
        sendtype = "1";// 0:代表正式群发  1:代表测试群发预览
        jsapiTicketUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=##tocken##&type=jsapi";
        show_cover_pic = "0";//是否显示封面，1为显示，0为不显示
        uploadConImg = "https://api.weixin.qq.com/cgi-bin/media/uploadimg?access_token=##tocken##";
        savePath = getRootPath();

        accessTockenUrl = accessTockenUrl + appid + "&secret=" + secret;
        tocken = getToken();
    }
    public static String getRootPath(){
    	String path = TempletUtils.class.getClassLoader().getResource("/").getPath();
    	return path.substring(0,path.indexOf("default"));
    }

    public static List<String> getImgSrc(String htmlStr) {
        if (htmlStr == null) {
            return null;
        }
        String img = "";
        Pattern p_image;
        Matcher m_image;
        List<String> pics = new ArrayList<String>();
        String regEx_img = "<img.*src\\s*=\\s*(.*?)[^>]*?>";
        p_image = Pattern.compile(regEx_img, Pattern.CASE_INSENSITIVE);
        m_image = p_image.matcher(htmlStr);
        while (m_image.find()) {
            img = img + "," + m_image.group();
            // Matcher m =
            // Pattern.compile("src=\"?(.*?)(\"|>|\\s+)").matcher(img); //匹配src
            Matcher m = Pattern.compile("src\\s*=\\s*\"?(.*?)(\"|>|\\s+)").matcher(img);
            while (m.find()) {
                pics.add(m.group(1));
            }
        }
        return pics;
    }
    
    //链接url下载图片
    private static String downloadPicture(String http_url) {
        URL url;
        String result = "";
        try {
            url = new URL(http_url);
            DataInputStream dataInputStream = new DataInputStream(url.openStream());
            String name = DateUtil.getCurrentDateTime("yyyyMMddhhmmsss");
            String extName = http_url.substring(name.lastIndexOf(".")).toLowerCase();
            String imageName =  savePath+name+extName;
            FileOutputStream fileOutputStream = new FileOutputStream(new File(imageName));
            ByteArrayOutputStream output = new ByteArrayOutputStream();

            byte[] buffer = new byte[1024];
            int length;

            while ((length = dataInputStream.read(buffer)) > 0) {
                output.write(buffer, 0, length);
            }
            fileOutputStream.write(output.toByteArray());
            dataInputStream.close();
            fileOutputStream.close();

            result = imageName;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
        return result;
    }

}
