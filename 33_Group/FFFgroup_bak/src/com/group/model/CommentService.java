package com.group.model;

import java.sql.Timestamp;
import java.util.List;

public class CommentService {

	private CommentDAO_interface dao;

	public CommentService() {
		dao = new CommentJDBCDAO();
	}

	public CommentVO addComment(
			 Integer user_id,
			 Timestamp comment_time,
			 String comment,
			 Integer g_no) {

		CommentVO commentVO = new CommentVO();
		commentVO.setUser_id(user_id);
		commentVO.setComment_time(comment_time);
		commentVO.setComment(comment);
		commentVO.setG_no(g_no);
		dao.insert(commentVO);

		return commentVO;
	}

	public CommentVO updateComment(
			 Integer comment_no,
			 Integer user_id,
			 Timestamp comment_time,
			 String comment,
			 Integer g_no) {

		CommentVO commentVO = new CommentVO();

		commentVO.setComment_no(comment_no);
		commentVO.setUser_id(user_id);
		commentVO.setComment_time(comment_time);
		commentVO.setComment(comment);
		commentVO.setG_no(g_no);
		dao.update(commentVO);

		return commentVO;
	}

	public void deleteComment(Integer comment_no) {
		dao.delete(comment_no);
	}

	public CommentVO getOneComment(Integer comment_no) {
		return dao.findByPrimaryKey(comment_no);
	}

	public List<CommentVO> getAll() {
		return dao.getAll();
	}
}
