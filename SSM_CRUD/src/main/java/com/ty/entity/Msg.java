package com.ty.entity;

import java.util.HashMap;
import java.util.Map;
/**
 * 
* @Description: Msg：json返回数据成功还是失败，并且可以带上json的数据一起返回
* @ClassName: Msg.java
* @version: v1.0.0
* @author: 
* @date: 2018年1月3日 上午11:29:40
 */
public class Msg {
	//自定义返回100就是成功，返回200就是失败
	private int code;
	//返回消息，知道是成功还是失败
	private String msg;
	//用于存储json格式的对象
	private  Map<String, Object> map = new HashMap<>();
	
	public static Msg success(){
		Msg msg = new Msg();
		msg.setCode(100);
		msg.setMsg("返回json数据成功");
		return msg;
	}
	
	public static Msg failture(){
		Msg msg = new Msg();
		msg.setCode(200);
		msg.setMsg("返回json数据失败");
		return msg;
	}
	
	public  Msg returnJson(String key,Object value){
		this.map.put(key, value);
		return this;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Map<String, Object> getMap() {
		return map;
	}
	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
}
