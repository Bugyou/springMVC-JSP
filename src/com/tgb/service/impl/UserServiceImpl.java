package com.tgb.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tgb.mapper.UserMapper;
import com.tgb.model.Admin;
import com.tgb.model.User;
import com.tgb.service.UserService;

@Service
@Transactional
// 此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class UserServiceImpl implements UserService {

	@Resource
	private UserMapper mapper;

	public boolean delete(int id) {
		System.out.println("delete " + id);
		return mapper.delete(id);
	}

	public List<User> findAll() {
		List<User> findAllList = mapper.findAll();
		
		return findAllList;
	}

	public User findById(int id) {

		User user = mapper.findById(id);

		return user;
	}

	public void save(User user) {

		mapper.save(user);
	}

	public boolean update(User user) {

		return mapper.update(user);
	}

	@Override
	public Map<String, Object> searchAllUser(int number, int curPage, String name,
			String age) {
		// TODO Auto-generated method stub
		List<User> findAllList;
		int total=0;
		if (isNull(name) && isNull(age)) {
			total = mapper.searchAllUserCount();
			findAllList = mapper.searchAllUser(number, number * (curPage - 1));
		}else if(isNull(age)){
			total = mapper.searchAllUserByNameCount(name);
			findAllList = mapper.searchAllUserByName(number, number * (curPage - 1) ,name);
		}else if(isNull(name)){
			total = mapper.searchAllUserByAgeCount(age);
			findAllList = mapper.searchAllUserByAge(number, number * (curPage - 1) ,age);
		}else{
			total = mapper.searchAllUserByNameAgeCount(name, age);
			findAllList = mapper.searchAllUserByNameAge(number, number * (curPage - 1), name, age);			
		}
		System.out.println("number:" + number + "  curPage:" + curPage
				+ " name:" + name + "  age:" + age);
		if(null!=findAllList){
			System.out.println("findAllList:" + findAllList.size());
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", findAllList);
		return map;
	}

	boolean isNull(String str){
		return (null==str)||("".equals(str));
	}

	@Override
	public boolean login(String name, String pwd) {
		// TODO Auto-generated method stub

		List<Admin> admins =  mapper.findAdmin(name);
		if(null!=admins){
			for(Admin admin:admins){
				if((null!=admin.getPwd())&&(admin.getPwd().equals(pwd))){
					return true;
				}
			}			
		}
		return false;
	}
}
