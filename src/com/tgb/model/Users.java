package com.tgb.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Users {
	List<User> userList;

	/**
	 * @return the userList
	 */
	public List<User> getUserList() {
		return userList;
	}

	/**
	 * @param userList the userList to set
	 */
	public void setUserList(List<User> userList) {
		this.userList = userList;
	}

	
}