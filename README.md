# FFF

把自己的檔案放入自己的資料夾吧~


目前有的連線池名字，自己改帳號密碼使用呦
<Resource auth="Container" driverClassName="com.mysql.cj.jdbc.Driver" maxIdle="10" maxTotal="20" 
          maxWaitMillis="-1" name="jdbc/TestDB3" password="password" type="javax.sql.DataSource" 
          url="jdbc:mysql://localhost:3306/Center?serverTimezone=Asia/Taipei" username="root"/>
    
<Resource auth="Container" type="javax.sql.DataSource" driverClassName="com.mysql.cj.jdbc.Driver" 
   	 	name="jdbc/Shop" url="jdbc:mysql://localhost:3306/SHOP?serverTimezone=Asia/Taipei" 
    	username="root" password="password"  maxIdle="10" maxTotal="20" maxWaitMillis="-1" />
    
<Resource auth="Container" type="javax.sql.DataSource" driverClassName="com.mysql.cj.jdbc.Driver" 
   	 	name="jdbc/chat" url="jdbc:mysql://localhost:3306/chat?serverTimezone=Asia/Taipei" 
    	username="root" password="password"  maxIdle="10" maxTotal="20" maxWaitMillis="-1" />
