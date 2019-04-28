package com.tgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.tgb.model.Admin;
import com.tgb.model.Files;
import com.tgb.model.PageHelper;
import com.tgb.model.User;
import com.tgb.model.Users;
import com.tgb.service.UserService;
import com.tgb.tools.Files_Utils_DG;
import com.tgb.tools.ResultUtils;
 
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	/**
	 * 获取所有用户列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/getAllUser")
	public String getAllUser(HttpServletRequest request) {

		List<User> findAll = userService.findAll();

		request.setAttribute("userList", findAll);
		return "/allUser";
	}

	/**
	 * 跳转到添加用户界面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddUser")
	public String toAddUser(HttpServletRequest request) {

		return "/addUser";
	}

	/**
	 * 添加用户并重定向
	 * 
	 * @param user
	 * @param request
	 * @return
	 */
	@RequestMapping("/addUser")
	public String addUser(User user, HttpServletRequest request) {
		userService.save(user);
		return "redirect:/user/getAllUser";
	}

	/**
	 * 添加用户并重定向
	 */
	@RequestMapping("/addUserList1")
	public String addUserList1(Users users ,Files myfiles, HttpServletRequest request){
		System.out.println("controller addUserList");
		     
		if(null!=users){
			List<User> userList=users.getUserList();
			if(null!=userList){
				for(int i=0;i<userList.size();i++){
					User user= userList.get(i);
					if(null!=myfiles){
						//List<MultipartFile> mulFiles= files.getMultipartFiles();
						//if(null!=mulFiles){
							//MultipartFile file = mulFiles.get(i);
							MultipartFile file = myfiles.getFiles()[i];
							if(file!=null){
								//System.out.println("fileName："+file);
								System.out.println("fileName："+file.getOriginalFilename());
						        //调用保存文件的帮助类进行保存文件，并返回文件的相对路径
							    String filePath = Files_Utils_DG.FilesUpload_transferTo_spring(request, file, "/files/upload");
							    user.setUserOther(filePath);						
							}
						//}
					}
					userService.save(user);
				}
			}  
		}

		return "redirect:/user/getAllUser";
	}

	/**
	 * 添加用户并重定向
	 */
	@RequestMapping("/addUserList")
	public String addUserList(Users users , HttpServletRequest request){
		System.out.println("controller addUserList");
		     
		if(null!=users){
			List<User> userList=users.getUserList();
			if(null!=userList){
				for(int i=0;i<userList.size();i++){
					User user= userList.get(i);
					System.out.println(user.getUserName());
					userService.save(user);
				}
			}  
		}

		return "redirect:/user/getAllUser";
	}
	
	/**
	 * 编辑用户
	 * 
	 * @param user
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateUser")
	public String updateUser(User user,
			MultipartFile other, HttpServletRequest request) {
		long  startTime=System.currentTimeMillis();
        System.out.println("fileName："+other.getOriginalFilename());
        
       //调用保存文件的帮助类进行保存文件，并返回文件的相对路径
        String filePath = Files_Utils_DG.FilesUpload_transferTo_spring(request, other, "/files/upload");
        user.setUserOther(filePath);
		if (userService.update(user)) {
			user = userService.findById(user.getId());
			request.setAttribute("user", user);
			return "redirect:/user/getAllUser";
		} else {
			return "/error";
		}
	}

	/**
	 * 根据id查询单个用户
	 * 
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getUser")
	public String getUser(int id, HttpServletRequest request) {

		request.setAttribute("user", userService.findById(id));
		return "/editUser";
	}

	/**
	 * 删除用户
	 * 
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping("/delUser")
	public void delUser(int id, HttpServletRequest request,
			HttpServletResponse response) {
		String result = "{\"result\":\"error\"}";

		if (userService.delete(id)) {
			result = "{\"result\":\"success\"}";
		}

		response.setContentType("application/json");

		try {
			PrintWriter out = response.getWriter();
			out.write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@RequestMapping("/searchAllUser")
	public void searchAllUser(PageHelper pageHelper,
			HttpServletResponse response) throws IOException {
		// int curPage = Integer.parseInt((page == null || page == "0") ? "1" :
		// page);
		// 每页显示条数
		// int number = Integer.parseInt((rows == null || rows == "0") ? "20" :
		// rows);
		int curPage = pageHelper.getPage();
		int number = pageHelper.getRows();
		String name = pageHelper.getUserName();
		String age = pageHelper.getAge();
		ResultUtils.toJson(response,
				userService.searchAllUser(number, curPage, name, age));
	}
	
	@RequestMapping("/toRemoveUsers")
	public void toRemoveUsers(String ids,
			HttpServletResponse response) throws IOException {
		System.out.println("toRemoveUsers..ids==="+ids);
		if(null!=ids){
			if((ids.length()-1)==ids.indexOf(",")){
				ids = ids.substring(0, ids.length()-1);
			}
			String[] idStrs = ids.split(",");
			for(String id_one :idStrs){
				System.out.println(id_one);
				userService.delete(Integer.valueOf(id_one));
			}
		}
		ResultUtils.toJson(response,"success", "删除成功!");
	}
	
	@RequestMapping("/download")
	public void download(int id,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		System.out.println("download..id==="+id);
		User user = userService.findById(id);
		Files_Utils_DG.FilesDownload_stream(request,response,user.getUserOther());
	}
	@RequestMapping("/login")
	public String login(
			Admin admin,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		boolean login = userService.login(admin.getName(),admin.getPwd());
		if(login){
			return "redirect:/user/getAllUser";	
		}else{
			return "redirect:/";	
		}
	}
	
}
