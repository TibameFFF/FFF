package com.fake.data;

public class ImportData {

	public static void main(String[] args) {

	boolean result = false;
		String filePath = "C:\\Users\\Tibame_T14\\Desktop\\第三組專題雲端\\假資料\\";
		// step 0 select Center info 的user_id
		selectCenter Center = new selectCenter();
		int userid = Center.queryCenter();
		
//		// step 1 先匯入article_type
//		Fake_article_type fake_article_type = new Fake_article_type();
//		result = fake_article_type.importArticleType(filePath);
//		
//		//step 2匯入 article
//		Fake_article fake_article = new Fake_article();
//		if (result == true) {
//			result = fake_article.importArticleData(filePath, userid);
//		}
//		
//		// step 3 匯入article_like
//	Fake_article_like fake_article_like = new Fake_article_like();
//		if (result == true) {
//			result = fake_article_like.importArticleLikeData(filePath, userid);
//		}
		
//		// step 4匯入reply
//		Fake_reply fake_reply = new Fake_reply();
//		if(result == true) {
//		fake_reply.importReplyData(filePath,userid);	
//		}
		
		
		// step 5匯入article_picture
		result = true;
		Fake_article_picture fake_article_picture = new Fake_article_picture();
		if(result == true) {
			fake_article_picture.importArticle_PictureData(filePath,userid);
		System.out.println(fake_article_picture);
		}
		
		// Step 6匯入 reply_like 未好
		Fake_reply_like fake_reply_like = new Fake_reply_like();
		if(result == true) {
			fake_reply_like.importReplyLikeData(filePath, userid);
		}
	}

}
