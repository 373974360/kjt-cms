/**
 * 
 */
package com.cms.view.velocity;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-08-20 16:25:13
 * 
 */
@Bizlet("")
public class HtmlRegexpUtil {
	private final static String regxpForHtml = "<[^>]+>"; // 过滤所有以<开头以>结尾的标签

	public final static String REGXPFORIMGTAG = "<\\s*img\\s+([^>]*)\\s*>"; // 找出IMG标签

	public final static String REGXPFORIMATAGSRCATTRIB = "src=\"([^\"]+)\""; // 找出IMG标签的SRC属性

	private static final String regEx_script = "<script[^>]*?>[\\s\\S]*?<\\/script>"; // 定义script的正则表达式
	private static final String regEx_style = "<style[^>]*?>[\\s\\S]*?<\\/style>"; // 定义style的正则表达式
	private static final String regEx_space = "\\s*|\t|\r|\n";// 定义空格回车换行符

	/**
	 * 
	 * 基本功能：替换标记以正常显示
	 * <p>
	 * 
	 * @param String
	 *            　要替换的字符串
	 * @return String
	 */
	public static String encodeHtml(String input) {
		if (!hasSpecialChars(input)) {
			return input;
		}
		StringBuffer filtered = new StringBuffer(input.length());
		char c;
		for (int i = 0; i <= input.length() - 1; i++) {
			c = input.charAt(i);
			switch (c) {
			case '<':
				filtered.append("&lt;");
				break;
			case '>':
				filtered.append("&gt;");
				break;
			case '"':
				filtered.append("&quot;");
				break;
			case '&':
				filtered.append("&amp;");
				break;
			default:
				filtered.append(c);
			}

		}
		return (filtered.toString());
	}

	/**
	 * 
	 * 基本功能：判断标记是否存在
	 * <p>
	 * 
	 * @param String
	 *            　判断特殊字符是否存在
	 * @return boolean true or false
	 */
	public static boolean hasSpecialChars(String input) {
		boolean flag = false;
		if ((input != null) && (input.length() > 0)) {
			char c;
			for (int i = 0; i <= input.length() - 1; i++) {
				c = input.charAt(i);
				switch (c) {
				case '>':
					flag = true;
					break;
				case '<':
					flag = true;
					break;
				case '"':
					flag = true;
					break;
				case '&':
					flag = true;
					break;
				}
			}
		}
		return flag;
	}

	/**
	 * 
	 * 基本功能：过滤所有以"<"开头以">"结尾的标签
	 * <p>
	 * 
	 * @param String
	 * @return String
	 */
	public static String filterHtml(String str) {
		if (str == null || (str = str.trim()).length() == 0) {
			return "";
		}
		Pattern pattern = Pattern.compile(regxpForHtml);
		Matcher matcher = pattern.matcher(str);
		StringBuffer sb = new StringBuffer();
		boolean result1 = matcher.find();
		while (result1) {
			matcher.appendReplacement(sb, "");
			result1 = matcher.find();
		}
		matcher.appendTail(sb);
		return sb.toString();
	}

	/**
	 * 
	 * 基本功能：过滤所有以空格换行符
	 * <p>
	 * 
	 * @param String
	 * @return String
	 */
	public static String filterSpace(String str) {
		if (str == null || (str = str.trim()).length() == 0) {
			return "";
		}
		Pattern pattern = Pattern.compile(regEx_space);
		Matcher matcher = pattern.matcher(str);
		StringBuffer sb = new StringBuffer();
		boolean result1 = matcher.find();
		while (result1) {
			matcher.appendReplacement(sb, "");
			result1 = matcher.find();
		}
		matcher.appendTail(sb);
		return sb.toString();
	}

	/**
	 * 
	 * 基本功能：过滤指定标签
	 * <p>
	 * 
	 * @param str
	 *            字符串
	 * @param tag
	 *            指定标签
	 * @return String
	 */
	public static String fiterHtmlTag(String str, String tag) {
		if (str == null || (str = str.trim()).length() == 0) {
			return "";
		}
		if (tag == null || (tag = tag.trim()).length() == 0) {
			return filterHtml(str);
		}

		String regxp = "<\\s*" + tag + "\\s+([^>]*)\\s*>";
		Pattern pattern = Pattern.compile(regxp);
		Matcher matcher = pattern.matcher(str);
		StringBuffer sb = new StringBuffer();
		boolean result1 = matcher.find();
		while (result1) {
			matcher.appendReplacement(sb, "");
			result1 = matcher.find();
		}
		matcher.appendTail(sb);
		return sb.toString();
	}

	/**
	 * 
	 * 基本功能：替换指定的标签
	 * <p>
	 * 
	 * @param str
	 * @param beforeTag
	 *            要替换的标签
	 * @param tagAttrib
	 *            要替换的标签属性值
	 * @param startTag
	 *            新标签开始标记
	 * @param endTag
	 *            新标签结束标记
	 * @return String
	 * @如：替换img标签的src属性值为[img]属性值[/img]
	 */
	public static String replaceHtmlTag(String str, String beforeTag,
			String tagAttrib, String startTag, String endTag) {
		String regxpForTag = "<\\s*" + beforeTag + "\\s+([^>]*)\\s*>";
		String regxpForTagAttrib = tagAttrib + "=\"([^\"]+)\"";
		Pattern patternForTag = Pattern.compile(regxpForTag);
		Pattern patternForAttrib = Pattern.compile(regxpForTagAttrib);
		Matcher matcherForTag = patternForTag.matcher(str);
		StringBuffer sb = new StringBuffer();
		boolean result = matcherForTag.find();
		while (result) {
			StringBuffer sbreplace = new StringBuffer();
			Matcher matcherForAttrib = patternForAttrib.matcher(matcherForTag
					.group(1));
			if (matcherForAttrib.find()) {
				matcherForAttrib.appendReplacement(sbreplace, startTag
						+ matcherForAttrib.group(1) + endTag);
			}
			matcherForTag.appendReplacement(sb, sbreplace.toString());
			result = matcherForTag.find();
		}
		matcherForTag.appendTail(sb);
		return sb.toString();
	}

	// 判断所给出字符串是否包含在html标签中，如果是，返回true
	public static boolean tagsContainLabel(String s, String content) {
		if (s.contains("<") || s.contains(">")) {
			return true;
		} else {
			Pattern p = Pattern.compile("<[a-zA-z0-9]{0,10}[^>]*" + s + ".*?>");
			Matcher m = p.matcher(content);
			return m.find();
		}
	}

	public static void main(String[] args) {

		// String
		// s="<info><infid>198</infid><inftitle>陕鼓超额完成30亿产值目标</inftitle><inftime>2007-01-08</inftime><infcounts>165</infcounts><hot>yes</hot><new>no</new></info>";
		Pattern p = Pattern.compile("<.*?123.*?>");
		Matcher m = p.matcher("<a>1234</a>");
		System.out.println(22222 + "--" + m.find());
	}
}
