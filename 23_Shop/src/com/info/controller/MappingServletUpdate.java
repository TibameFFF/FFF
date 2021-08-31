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

import com.info.model.InfoJDBCDAO;
import com.info.model.InfoService;
import com.info.model.InfoVO;

/**
 * Servlet implementation class InfoServletUpdate
 */
@WebServlet("/MappingServletUpdate")
public class MappingServletUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
		try {
			String account = request.getParameter("account");
			if (account.length() == 0) {
				return;
			}
			String mapping = request.getParameter("mapping");
			String agemin = request.getParameter("age_min");
			String agemax = request.getParameter("age_max");
			String mappingsex = request.getParameter("mapping_sex");
			String intro = request.getParameter("intro");
			PrintWriter out = response.getWriter();

			InfoService dao = new InfoService();

			InfoVO infoVO = dao.update_mapping(Integer.parseInt(mapping), Integer.parseInt(agemin),
					Integer.parseInt(agemax), Integer.parseInt(mappingsex), intro, account);
			JSONObject obj = new JSONObject(infoVO);
			out.print(obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
