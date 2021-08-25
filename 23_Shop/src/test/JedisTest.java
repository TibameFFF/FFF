package test;

import java.util.HashMap;

import redis.clients.jedis.Jedis;

public class JedisTest {
	public static void main(String[] args) {
		Jedis jedis = new Jedis("localhost", 6379);

		//�h����Ƥ@�_�x�s
//		HashMap<String, String> data = new HashMap<>();//�]�w�e��
//		data.put("brand", "Pentel");// ��ȡA�L������ORM�]�p�A�i�ۥѬ�key�W��ۤv�ݭn�����P����
//		data.put("price", "50");
//		data.put("color", "blue");
		
		HashMap<String, String> cart = new HashMap<>();
		cart.put("2", "3");
		cart.put("1", "3");
		cart.put("2", "4");
				
		jedis.hmset("id:1", cart); //��Ʀs�J��Ʈw
		HashMap<String, String> cartData = (HashMap<String, String>)jedis.hgetAll("id:2");//�@�����X�h�����
		System.out.println(cartData);
		
		System.out.println(jedis.hexists("id:1", "3"));

	}
}
