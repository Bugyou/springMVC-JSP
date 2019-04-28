/**
 * 
 */
package com.tgb.tools;

/**
 * @author Administrator
 *
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.tgb.model.User;

public class ResultUtils {
	public static void toJson(HttpServletResponse response,
			Map<String, Object> data) throws IOException {
		if ((null == response)) {
			return;
		}
		if(null == data){
			data = new HashMap<String, Object>();
		}
		Gson gson = new Gson();
		String result = gson.toJson(data);
		response.setContentType("text/json; charset=utf-8");
		response.setHeader("Cache-Control", "no-cache"); // 取消浏览器缓存
		PrintWriter out = response.getWriter();
		System.out.println(result);
		out.print(result);
		out.flush();
		out.close();
	}
	public static void toJson(HttpServletResponse response, List<User> users) throws IOException {
		if ((null == response)) {
			return;
		}
		if(null == users){
			users = new ArrayList<User>();
		}
		Gson gson = new Gson();
		String result = gson.toJson(users);
		response.setContentType("text/json; charset=utf-8");
		response.setHeader("Cache-Control", "no-cache"); // 取消浏览器缓存
		PrintWriter out = response.getWriter();
		System.out.println(result);
		out.print(result);
		out.flush();
		out.close();
	}

	
	
	public static void toJson(HttpServletResponse response,
			List<String> list , String itemName) throws IOException {
		String jsonString = "";
		if (null==itemName) {
			return;
		}
		if(null == list){
			list = new ArrayList<String>();
		}
		
		jsonString = jsonString + "[";

		for (int i=0;i<list.size();i++) {
			
			jsonString += "{";
			

			jsonString = jsonString + "\"id\":"; // "属性名":
			jsonString = jsonString + "\"" + i + "\","; // "属性值",
			
			jsonString = jsonString + "\"" + itemName + "\":"; // "属性名":
			jsonString = jsonString + "\"" + list.get(i) + "\""; // "属性值",
			jsonString += "},";
		}
		jsonString = jsonString.substring(0, jsonString.length() - 1);
		jsonString = jsonString + "]";

		response.setContentType("text/json; charset=utf-8");
		response.setHeader("Cache-Control", "no-cache"); // 取消浏览器缓存
		PrintWriter out = response.getWriter();
		System.out.println(jsonString);
		out.print(jsonString);
		out.flush();
		out.close();
	}
	
	
	public static void toJson(HttpServletResponse response,
			String msgName, String msgContent) throws IOException {
		String jsonString = "";
		if ((null == msgName) || (null==msgContent)) {
			return;
		}
		jsonString = jsonString + "{\"";
		jsonString = jsonString + msgName+ "\":\"";
		jsonString = jsonString + msgContent + "\"}";
		response.setContentType("text/json; charset=utf-8");
		response.setHeader("Cache-Control", "no-cache"); // 取消浏览器缓存
		PrintWriter out = response.getWriter();
		System.out.println(jsonString);
		out.print(jsonString);
		out.flush();
		out.close();
	}
}