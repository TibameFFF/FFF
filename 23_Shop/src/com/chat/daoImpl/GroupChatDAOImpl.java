package com.chat.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.chat.dao.GroupChatDAO;
import com.chat.model.GroupChat;
import com.shop.util.Util;

public class GroupChatDAOImpl implements GroupChatDAO{

	@Override
	public List<GroupChat> getAll() {
		List<GroupChat> groupChatList = new ArrayList<>();

		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		
		try {
			con = DriverManager.getConnection(Util.CHATURL, Util.USER, Util.PASSWORD);
			st = con.createStatement();
			rs = st.executeQuery("SELECT * FROM chat.group_chat");

			while (rs.next()) {
				GroupChat groupChat = new GroupChat();

				groupChat.setChat_leader(rs.getInt("chat_leader"));
				groupChat.setChat_name(rs.getString("chat_name"));
				groupChat.setChat_no(rs.getInt("chat_no"));
				groupChat.setChat_theme(rs.getString("chat_theme"));
				groupChat.setChat_theme_no(rs.getInt("chat_theme_no"));

				groupChatList.add(groupChat);

			}

		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (st != null) {
				try {
					st.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return groupChatList;
	}

}
