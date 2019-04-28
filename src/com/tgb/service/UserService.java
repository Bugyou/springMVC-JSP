package com.tgb.service;

import java.util.List;
import java.util.Map;

import com.tgb.model.User;

public interface UserService {
	void save(User user);

	boolean update(User user);

	boolean delete(int id);

	User findById(int id);

	List<User> findAll();

	Map<String, Object> searchAllUser(int number, int curPage, String c2, String c3);
	boolean login(String name , String pwd);
}
