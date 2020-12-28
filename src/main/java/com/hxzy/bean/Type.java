package com.hxzy.bean;

public class Type {
    private int typeid;//
    private String typename;//
    private String type;//
     
     
	public int getTypeid() {
		return typeid;
	}
	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
	@Override
	public String toString() {
		return "Type [typeid=" + typeid + ", typename=" + typename + ", type="
				+ type + "]";
	}
     
     
}
