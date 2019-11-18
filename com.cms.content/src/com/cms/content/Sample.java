package com.cms.content;

import org.json.JSONObject;

import com.baidu.aip.nlp.AipNlp;

public class Sample {
	//设置APPID/AK/SK
    public static final String APP_ID = "17793243";
    public static final String API_KEY = "TGbDhb8hee1n2Bu6oDc8swCh";
    public static final String SECRET_KEY = "CB1kakG1x6nXThsgdB0EgR7hWLZZNKIm";
    
    public static String getTitleTags(String text){
        // 初始化一个AipNlp
        AipNlp client = new AipNlp(APP_ID, API_KEY, SECRET_KEY);
        JSONObject res = client.lexer(text, null);
        return res.toString(2);
    }
}
