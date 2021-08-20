package com.shop.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.tomcat.jni.OS;

import com.shop.model.OrderProd;
import com.shop.service.EvalPicService;
import com.shop.service.OrderProdService;

@WebServlet("/MakeCommentServlet")
@MultipartConfig
public class MakeCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		
		req.setCharacterEncoding("UTF-8");
		
		Enumeration<String> enu = req.getParameterNames();
		
		while (enu.hasMoreElements()) {
			System.out.println(enu.nextElement()); 
			
		}
		
		//���o�q��ӫ~�s��
		String[] prodID = req.getParameterValues("order_prod_id");
		List<Integer> prodIdList = new ArrayList<Integer>();
		List<Integer> starRateList = new ArrayList<Integer>();
		List<String> commentList = new ArrayList<String>();
		for(String str: prodID) {
			//���o�q��ӫ~�s��
			prodIdList.add(Integer.parseInt(str));
			
			//���o�P��
			starRateList.add(Integer.parseInt(req.getParameter("star_rate_"+str)));
			
			//���o����
			commentList.add(req.getParameter("comment_"+str));
		}
		
		
		//��s�q��ӫ~���װ�
		OrderProdService orderProdService = new OrderProdService();
		for(int i=0; i<prodIdList.size(); i++) {
			orderProdService.updateOrderProdComment(starRateList.get(i), commentList.get(i), prodIdList.get(i));
		}
		
		//��s���׹Ϥ�
		Collection<Part> parts = req.getParts();
		for(int i=0; i<prodIdList.size() && i<3; i++) {
			String picId = "pic_"+prodIdList.get(i);
			for(Part part: parts) {
				if(picId.equals(part.getName())) {
					
					InputStream is = part.getInputStream();
					byte[] buffer = new byte[is.available()];
					is.read(buffer);
					EvalPicService evalPicService = new EvalPicService();
					evalPicService.addEvalPic(prodIdList.get(i), buffer);
				}
			}
			
		}
		
		
		
		
		
		res.sendRedirect("http://localhost:8081/FFF/Shop/index.html");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
