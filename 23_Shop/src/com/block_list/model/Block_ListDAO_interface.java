package com.block_list.model;

import java.util.*;

public interface Block_ListDAO_interface {
	public void insert(Block_ListVO block_listVO);

	public void delete(Integer user_id, Integer block_user_id);

	public Block_ListVO findByPrimaryKey(Integer user_id, Integer block_user_id);

	public List<Block_ListVO> getAll();
}
