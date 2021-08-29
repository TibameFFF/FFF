package com.chat.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.chat.dao.FriendDAO;
import com.chat.model.Friend;
import com.chat.model.GroupChat;
import com.shop.util.Util;

public class FriendDAOImpl implements FriendDAO{

	@Override
	public List<Friend> findByUserId(int id) {
		List<Friend> friendList = new ArrayList<>();

		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		
		try {
			con = DriverManager.getConnection(Util.CHATURL, Util.USER, Util.PASSWORD);
			st = con.prepareStatement("SELECT * FROM chat.friend WHERE user_id = ?");
			st.setInt(1, id);
			rs = st.executeQuery();

			while (rs.next()) {
				Friend friend = new Friend();
				friend.setFriend_id(rs.getInt("friend_id"));
				friend.setFriend_list_id(rs.getInt("friend_list_id"));
				friend.setFriend_mode(rs.getInt("friend_mode"));
				friend.setUser_id(rs.getInt("user_id"));
				

				friendList.add(friend);

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

		return friendList;
	}

	
}
