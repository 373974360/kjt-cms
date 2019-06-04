/**
 * 
 */
package com.cms.view.search;
import java.io.IOException;
import java.io.StringReader;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import org.apache.axiom.om.impl.dom.jaxp.DocumentBuilderFactoryImpl;
import org.apache.xpath.XPathAPI;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.eos.system.annotation.Bizlet;

/**
 * @author chaoweima
 * @date 2019-06-04 11:24:48
 *
 */
@Bizlet("")
public class XmlManager {
	private static DocumentBuilderFactory dbf;

	// Remove by sman on 2003-9-3
	// 为了解决org.xml.sax.SAXException: Parser is already in use问题
	// private static DocumentBuilder db;
	// Remove by sman on 2003-9-3

	static {
		dbf = new DocumentBuilderFactoryImpl();
		dbf.setCoalescing(true);
		dbf.setIgnoringElementContentWhitespace(true);
		dbf.setIgnoringComments(true);

	}
	/**
	 * 在指定节点里用指定XPath查询节点列表getWareInstances(strSiteID).
	 * 
	 * @param node
	 *            要查询的节点
	 * @param strXPath
	 *            查询XPath
	 * @return NodeList 查询结果的列表
	 * @throws TransformerException
	 */
	public static NodeList queryNodeList(Node node, String strXPath)
			throws TransformerException {
		if (node == null) {
			return null;
		}
		NodeList nl = null;
		nl = XPathAPI.selectNodeList(node, strXPath);
		return nl;
	}
	/**
	 * 在指定节点里用指定XPath查询指定节点的值getWareInstances(strSiteID).
	 * 
	 * @param node
	 *            要查询的节点
	 * @param strXPath
	 *            查询XPath
	 * @return String 查询结果节点的值
	 * @throws TransformerException
	 */
	public static String queryNodeValue(Node node, String strXPath)
			throws TransformerException {
		if (node == null) {
			return null;
		}
		Node n = queryNode(node, strXPath);
		String strR = null;
		if (n != null) {
			strR = queryNodeValue(n);
		}
		return strR;
	}
	/**
	 * 在指定节点里用指定XPath查询节点列表. 并返回第一个节点getWareInstances(strSiteID).
	 * 
	 * @param node
	 *            要查询的节点
	 * @param strXPath
	 *            查询XPath
	 * @return Node 查询结果的节点
	 * @throws TransformerException
	 */
	public static Node queryNode(Node node, String strXPath)
			throws TransformerException {
		if (node == null) {
			return null;
		}
		NodeList nl = queryNodeList(node, strXPath);
		Node n = null;
		if (nl != null && nl.getLength() > 0) {
			n = nl.item(0);
		}
		return n;
	}
	/**
	 * 查询节点值.
	 * 
	 * @param node
	 *            要查询的节点
	 * @return 节点值
	 * @throws TransformerException
	 */
	public static String queryNodeValue(Node node) throws TransformerException {
		String strR = null;
		if (node != null) {
			if (node.getFirstChild() != null
					&& node.getNodeType() == Node.ELEMENT_NODE) {
				strR = node.getFirstChild().getNodeValue();
			} else if (node.getNodeType() == Node.ATTRIBUTE_NODE) {
				strR = node.getNodeValue();
			}
		}
		return strR;
	}
	/**
	 * 根据给定xml字符串创建一个NodegetWareInstances(strSiteID).
	 * 
	 * @param String
	 *            xml字符串
	 * @return Node
	 * @throws ParserConfigurationException
	 * @throws SAXException
	 * @throws IOException
	 * @throws TransformerException
	 */
	public static Node createNode(String strXML)
			throws ParserConfigurationException, SAXException, IOException,
			TransformerException {
		try {
			NodeList nodelist = createNodeList(strXML);
			Node node = null;
			if (nodelist != null && nodelist.getLength() > 0) {
				node = nodelist.item(0);
			}
			return node;
		} catch (Exception ex) {
			// Debug.error("将字符串转换为节点时出错：[" + strXML + "]");
			ex.printStackTrace(System.out);
			return null;
		}
	}
	/**
	 * 根据给定的xml字符串创建一个NodeListgetWareInstances(strSiteID).
	 * 
	 * @param String
	 *            xml字符串
	 * @return NodeList
	 * @throws ParserConfigurationException
	 * @throws SAXException
	 * @throws IOException
	 * @throws TransformerException
	 */
	public static NodeList createNodeList(String strXML)
			throws ParserConfigurationException, SAXException, IOException,
			TransformerException {
		strXML = "<xml>\n" + strXML + "\n</xml>";
		Document doc = createDOMByString(strXML);
		NodeList nodelist = null;
		nodelist = XPathAPI.selectNodeList(doc, "/xml/*");
		return nodelist;
	}
	/**
	 * 利用JAXP构造Document对象.
	 * 
	 * @param String
	 *            xml内容
	 * @return Document对象
	 * @throws ParserConfigurationException
	 * @throws SAXException
	 * @throws IOException
	 */
	public static Document createDOMByString(String strDOMContent)
			throws ParserConfigurationException, SAXException, IOException {
		try {			
			return dbf.newDocumentBuilder().parse(
					new InputSource(new StringReader(strDOMContent)));

		} catch (Exception ex) {
			// Debug.error("将字符串转换为DOM时出错：[" + strDOMContent + "]");
			ex.printStackTrace(System.out);
			return null;
		}
	}
}
