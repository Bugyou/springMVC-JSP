package com.tgb.mapper;

import java.util.List;

import com.tgb.model.Admin;
import com.tgb.model.User;

public interface UserMapper {

	void save(User user);

	boolean update(User user);

	boolean delete(int id);

	User findById(int id);

	List<User> findAll();

	List<User> searchAllUser(int pageSize, int firstIndex);

	int searchAllUserCount();

	List<User> searchAllUserByNameAge(int number, int curPage, String name,
			String age);

	int searchAllUserByNameAgeCount(String name, String age);

	List<User> searchAllUserByName(int number, int curPage, String name);

	int searchAllUserByNameCount(String name);

	List<User> searchAllUserByAge(int number, int curPage, String age);

	int searchAllUserByAgeCount(String age);
	
	List<Admin> findAdmin(String name);
}
