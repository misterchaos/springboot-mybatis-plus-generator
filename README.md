# 基于mybatis-plus的springboot代码生成器

## 使用方法

- 修改application.properties配置文件，设置数据库信息
```
#DataSource Config
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/flower?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=GMT
spring.datasource.username=root
spring.datasource.password=
```
- 运行CodeGenerator类，输入数据库表名
- 查看生成的代码