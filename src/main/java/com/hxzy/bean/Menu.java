package com.hxzy.bean;

import java.io.Serializable;
import java.util.List;

public class Menu implements Serializable {
	
	private static final long serialVersionUID = -3120025799756053359L;
	
	private String id;
	private String name;
	private String pid;
	private String url;
	private String target;
	private String icon;
	private String iconOpen;
	private String iconClose;
	private List<Menu> children;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getIconOpen() {
		return iconOpen;
	}
	public void setIconOpen(String iconOpen) {
		this.iconOpen = iconOpen;
	}
	public String getIconClose() {
		return iconClose;
	}
	public void setIconClose(String iconClose) {
		this.iconClose = iconClose;
	}
	public List<Menu> getChildren() {
		return children;
	}
	public void setChildren(List<Menu> children) {
		this.children = children;
	}
	@Override
	public String toString() {
		return "MenuTree [id=" + id + ", name=" + name + ", pid=" + pid + ", url=" + url + ", target=" + target + ", icon="
				+ icon + ", iconOpen=" + iconOpen + ", iconClose=" + iconClose + ", children=" + children + "]";
	}
	
	
	
}
