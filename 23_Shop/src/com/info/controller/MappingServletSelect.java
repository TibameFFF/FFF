package com.info.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.info.model.InfoService;
import com.info.model.InfoVO;

@WebServlet("/MappingServletSelect")
public class MappingServletSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		try {
			
			String account = request.getParameter("account");
			if(account.length()==0) {
				return;
			}
			PrintWriter out = response.getWriter();
			InfoService dao = new InfoService();

			HashMap userInfoMap = new HashMap();
			InfoVO infoVO = dao.findByPrimaryKey(account);

			userInfoMap.put("mapping", infoVO.getMapping());
			userInfoMap.put("sex", infoVO.getSex());
			userInfoMap.put("age_min", infoVO.getAge_min());
			userInfoMap.put("age_max", infoVO.getAge_max());
			userInfoMap.put("mapping_sex", infoVO.getMapping_sex());
			if (infoVO.getIntro() == null) {
				userInfoMap.put("intro", "");
			} else {
				userInfoMap.put("intro", infoVO.getIntro());
			}
			String base64 = Base64.getMimeEncoder().encodeToString(infoVO.getPhoto());
			userInfoMap.put("photo", "data:image/jpeg;base64," + base64);

			JSONObject obj = new JSONObject(userInfoMap);
			out.println(obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
