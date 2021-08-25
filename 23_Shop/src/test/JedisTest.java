package test;

import java.util.HashMap;

import redis.clients.jedis.Jedis;

public class JedisTest {
	public static void main(String[] args) {
		Jedis jedis = new Jedis("localhost", 6379);

		//多筆資料一起儲存
//		HashMap<String, String> data = new HashMap<>();//設定容器
//		data.put("brand", "Pentel");// 放值，無須對應ORM設計，可自由為key增減自己需要的欄位與欄位值
//		data.put("price", "50");
//		data.put("color", "blue");
		
		HashMap<String, String> cart = new HashMap<>();
		cart.put("2", "3");
		cart.put("1", "3");
		cart.put("2", "4");
				
		jedis.hmset("id:1", cart); //資料存入資料庫
		HashMap<String, String> cartData = (HashMap<String, String>)jedis.hgetAll("id:2");//一次取出多筆資料
		System.out.println(cartData);
		
		System.out.println(jedis.hexists("id:1", "3"));

	}
}
