package com.group.model;

import java.sql.Timestamp;
import java.util.List;

public class ReplyService {

	private ReplyDAO_interface dao;

	public ReplyService() {
		dao = new ReplyJDBCDAO();
	}

	public ReplyVO addReply(
			 Integer user_id,
			 Timestamp Reply_time,
			 String Reply,
			 Integer comment_no) {

		ReplyVO replyVO = new ReplyVO();
		replyVO.setUser_id(user_id);
		replyVO.setReply_time(Reply_time);
		replyVO.setReply(Reply);
		replyVO.setComment_no(comment_no);
		dao.insert(replyVO);

		return replyVO;
	}

	public ReplyVO updateReply(
			 Integer Reply_no,
			 Integer user_id,
			 Timestamp Reply_time,
			 String Reply,
			 Integer comment_no) {

		ReplyVO replyVO = new ReplyVO();

		replyVO.setReply_no(Reply_no);
		replyVO.setUser_id(user_id);
		replyVO.setReply_time(Reply_time);
		replyVO.setReply(Reply);
		replyVO.setComment_no(comment_no);
		dao.update(replyVO);

		return replyVO;
	}

	public void deleteReply(Integer reply_no) {
		dao.delete(reply_no);
	}

	public ReplyVO getOneReply(Integer reply_no) {
		return dao.findByPrimaryKey(reply_no);
	}

	public List<ReplyVO> getAll() {
		return dao.getAll();
	}
}
