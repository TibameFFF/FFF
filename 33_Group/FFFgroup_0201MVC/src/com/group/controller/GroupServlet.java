package com.group.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.group.model.*;
@MultipartConfig
public class GroupServlet extends HttpServlet {
	String saveDirectory = "/images_uploaded";
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
						
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("g_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入揪團編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/group/selectgroup_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer g_no = null;
				try {
					g_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("揪團編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/group/selectgroup_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				GroupService groupSvc = new GroupService();
				GroupVO groupVO = groupSvc.getOneGroup(g_no);
				if (groupVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/group/selectgroup_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("groupVO", groupVO); // 資料庫取出的empVO物件,存入req
				String url = "/group/groupdetail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/group/selectgroup_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllGroup.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer g_no = new Integer(req.getParameter("g_no"));
				
				/***************************2.開始查詢資料****************************************/
				
				GroupService groupSvc = new GroupService();
				GroupVO groupVO = groupSvc.getOneGroup(g_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("groupVO", groupVO);         // 資料庫取出的empVO物件,存入req
				String url = "/group/groupedit.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/group/listAllGroup.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				 Integer g_no = new Integer(req.getParameter("g_no").trim());				
				 String g_name = req.getParameter("g_name");
				 Integer g_type_no= new Integer(req.getParameter("g_type_no").trim());
				 String g_content= req.getParameter("g_content").trim();
				 java.sql.Timestamp g_start_time= java.sql.Timestamp.valueOf(req.getParameter("g_start_time").trim());		
				 java.sql.Timestamp g_end_time= java.sql.Timestamp.valueOf(req.getParameter("g_end_time").trim());				
				 java.sql.Timestamp apply_start_time= java.sql.Timestamp.valueOf(req.getParameter("apply_start_time").trim());
				 java.sql.Timestamp apply_end_time= java.sql.Timestamp.valueOf(req.getParameter("apply_end_time").trim());			
				 String place= req.getParameter("place").trim();		
				 Integer number_lower= new Integer(req.getParameter("number_lower").trim());		
				 Integer number_upper= new Integer(req.getParameter("number_upper").trim());				 			
				 Integer number_total= new Integer(req.getParameter("number_total").trim());							 
				 Integer user_id= new Integer(req.getParameter("user_id").trim());				
				 String introduce= req.getParameter("introduce").trim();				
				 String phone= req.getParameter("phone").trim();					
				 String email= req.getParameter("email").trim();				
				 Integer state_no= new Integer(req.getParameter("state_no").trim());				
				 String g_flow_cause= req.getParameter("g_flow_cause").trim();				 
				 Part pic=null;
				 byte[]photo=null;
				 pic=req.getPart("photo");
				 if(pic.getSize()==0) {
					 GroupService groupsvc=new GroupService();
					 GroupVO groupVO2 = new GroupVO();
					 groupVO2=groupsvc.getOneGroup(g_no);
					 photo=groupVO2.getPhoto();
				 }else {	 
					 InputStream in=pic.getInputStream();
					 photo = new byte[in.available()];
					 in.read(photo);
				 }		 
				 String g_url= req.getParameter("g_url").trim();
				


				GroupVO groupVO = new GroupVO();
				
				groupVO.setG_name(g_name);
				groupVO.setG_type_no(g_type_no);
				groupVO.setG_content(g_content);
				groupVO.setG_start_time(g_start_time);
				groupVO.setG_end_time(g_end_time);
				groupVO.setApply_start_time(apply_start_time);
				groupVO.setApply_end_time(apply_end_time);
				groupVO.setPlace(place);
				groupVO.setNumber_lower(number_lower);
				groupVO.setNumber_upper(number_upper);
				groupVO.setNumber_total(number_total);
				groupVO.setUser_id(user_id);
				groupVO.setIntroduce(introduce);
				groupVO.setPhone(phone);
				groupVO.setEmail(email);
				groupVO.setState_no(state_no);
				groupVO.setG_flow_cause(g_flow_cause);
				groupVO.setPhoto(photo);
				groupVO.setG_url(g_url);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("groupVO", groupVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/group/groupedit.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				GroupService groupSvc = new GroupService();
				groupVO = groupSvc.updateGroup(g_no, g_name, g_type_no, g_content, g_start_time, g_end_time, apply_start_time, apply_end_time, place, number_lower, number_upper, number_total, user_id, introduce, phone, email, state_no, g_flow_cause, photo, g_url);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("groupVO", groupVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/group/groupdetail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/group/groupedit.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addEmp.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				 String g_name = req.getParameter("g_name");
				 String g_content= req.getParameter("g_content");
				 Integer g_type_no= new Integer(req.getParameter("g_type_no").trim());
				 java.sql.Timestamp g_start_time= java.sql.Timestamp.valueOf(req.getParameter("g_start_time"));
				 java.sql.Timestamp g_end_time= java.sql.Timestamp.valueOf(req.getParameter("g_end_time"));
				 java.sql.Timestamp apply_start_time= java.sql.Timestamp.valueOf(req.getParameter("apply_start_time"));
				 java.sql.Timestamp apply_end_time= java.sql.Timestamp.valueOf(req.getParameter("apply_end_time"));
				 String place= req.getParameter("place");
				 Integer number_lower= new Integer(req.getParameter("number_lower"));
				 Integer number_upper= new Integer(req.getParameter("number_upper"));
				 Integer number_total= new Integer(req.getParameter("number_total"));
				 Integer user_id= new Integer(req.getParameter("user_id").trim());
				 String introduce= req.getParameter("introduce");
				 String phone= req.getParameter("phone");
				 String email= req.getParameter("email");
				 Integer state_no= new Integer(req.getParameter("state_no"));
				 String g_flow_cause= req.getParameter("g_flow_cause");
				 Part pic=null;
				 byte[]photo=null;
				 pic=req.getPart("photo");
				 if(pic.getSize()==0) {
					 GroupVO groupVO3 = new GroupVO();
					 photo=groupVO3.getPhoto();
				 }else {	 
					 InputStream in=pic.getInputStream();
					 photo = new byte[in.available()];
					 in.read(photo);
				 }	
				 String g_url= req.getParameter("g_url");
				 
						 
						 
				 
				
//				Integer  = new Integer(req.getParameter("").trim());

				GroupVO groupVO = new GroupVO();
				
				groupVO.setG_name(g_name);
				groupVO.setG_type_no(g_type_no);
				groupVO.setG_content(g_content);
				groupVO.setG_start_time(g_start_time);
				groupVO.setG_end_time(g_end_time);
				groupVO.setApply_start_time(apply_start_time);
				groupVO.setApply_end_time(apply_end_time);
				groupVO.setPlace(place);
				groupVO.setNumber_lower(number_lower);
				groupVO.setNumber_upper(number_upper);
				groupVO.setNumber_total(number_total);
				groupVO.setUser_id(user_id);
				groupVO.setIntroduce(introduce);
				groupVO.setPhone(phone);
				groupVO.setEmail(email);
				groupVO.setState_no(state_no);
				groupVO.setG_flow_cause(g_flow_cause);
				groupVO.setPhoto(photo);
				groupVO.setG_url(g_url);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("groupVO", groupVO); // 含有輸入格式錯誤的GroupVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/group/groupform.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				GroupService groupSvc = new GroupService();
				groupVO = groupSvc.addGroup(g_name, g_type_no, g_content, g_start_time, g_end_time, apply_start_time, apply_end_time, place, number_lower, number_upper, number_total, user_id, introduce, phone, email, state_no, g_flow_cause, photo, g_url);
				MemberVO memberVO = new MemberVO();
				memberVO.setRole(0);
				memberVO.setUser_id(user_id);
				memberVO.setG_no(groupVO.getG_no());
				MemberService memberSvc =new MemberService();
				memberVO = memberSvc.addMember(1,user_id,groupSvc.getG_nob());
				System.out.println(groupSvc.getG_nob());
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/group/listAllGroup.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/group/groupform.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer g_no = new Integer(req.getParameter("g_no"));
				
				/***************************2.開始刪除資料***************************************/
				GroupService groupSvc = new GroupService();
				groupSvc.deleteGroup(g_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/group/listAllGroup.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/group/listAllGroup.jsp");
				failureView.forward(req, res);
			}
		}
		
	}
}


