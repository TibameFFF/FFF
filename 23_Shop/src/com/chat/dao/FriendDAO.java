package com.chat.dao;

import java.util.List;

import com.chat.model.Friend;

public interface FriendDAO {
	List<Friend> findByUserId(int id);
}
