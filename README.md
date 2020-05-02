# 基于mybatis-plus的springboot代码生成器

## 一、特性
- 实现controller restful风格CURD接口
- service层CURD对IService的方法再次封装，方便添加业务逻辑
- serviceImpl中方法实现执行debug日志打印
- mapper模板在官方模板基础上加入@mapper注解
- 各模板方法添加Javadoc注释
- 实现分页查询，关键词模糊查询
## 二、使用方法

- 修改application.properties配置文件，设置数据库信息
```
#DataSource Config
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/flower?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=GMT
spring.datasource.username=root
spring.datasource.password=
``` 
- 运行CodeGenerator类，输入Author，输入数据库表名
- 运行SpringbootMybatisPlusGeneratorApplication,测试接口

> 注意：数据库表必须符合以下规范<br>
> 每张表的主键命名为 表名_id 如: user_id

## 三、生成的代码示例

### 1.Controller模板代码示例
```java
package cn.hellochaos.generator.controller;


import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import cn.hellochaos.generator.entity.dto.ResultBean;
import cn.hellochaos.generator.service.UserService;
import cn.hellochaos.generator.entity.User;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 用户 前端控制器
 * </p>
 *
 * @author chaos
 * @since 2020-05-02
 * @version v1.0
 */
@RestController
@RequestMapping("/generator/api/v1/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
    * 查询分页数据
    */
    @RequestMapping(method = RequestMethod.GET)
    public ResultBean<?> listByPage(@RequestParam(name = "page", defaultValue = "1") int page,
                                    @RequestParam(name = "pageSize", defaultValue = "10") int pageSize,
                                    @RequestParam String keyword) {
        return new ResultBean<>(userService.listUsersByPage(page, pageSize,keyword));
    }


    /**
    * 根据id查询
    */
    @RequestMapping(method = RequestMethod.GET, value = "/{id}")
    public ResultBean<?> getById(@PathVariable("id") Integer id) {
        return new ResultBean<>(userService.getUserById(id));
    }

    /**
    * 新增
    */
    @RequestMapping(method = RequestMethod.POST)
    public ResultBean<?> insert(@RequestBody User user) {
        return new ResultBean<>(userService.insertUser(user));
    }

    /**
    * 删除
    */
    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public ResultBean<?> deleteById(@PathVariable("id") Integer id) {
        return new ResultBean<>(userService.deleteUserById(id));
    }

    /**
    * 修改
    */
    @RequestMapping(method = RequestMethod.PUT)
    public ResultBean<?> updateById(@RequestBody User user) {
        return new ResultBean<>(userService.updateUser(user));
    }
}

```

### 2.Service模板代码示例
```java
package cn.hellochaos.generator.service;

import cn.hellochaos.generator.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

/**
* <p>
* 用户 服务类
* </p>
*
* @author chaos
* @since 2020-05-02
*/
public interface UserService {

    /**
    * 分页查询User
    *
    * @param page     当前页数
    * @param pageSize 页的大小
    * @param keyword  搜索关键词
    * @return 返回mybatis-plus的Page对象,其中records字段为符合条件的查询结果
    * @author chaos
    * @since 2020-05-02
    */
    Page<User> listUsersByPage(int page, int pageSize, String keyword);

    /**
    * 根据id查询User
    *
    * @param id 需要查询的User的id
    * @return 返回对应id的User对象
    * @author chaos
    * @since 2020-05-02
    */
    User getUserById(int id);

    /**
    * 插入User
    *
    * @param user 需要插入的User对象
    * @return 返回插入成功之后User对象的id
    * @author chaos
    * @since 2020-05-02
    */
    int insertUser(User user);

    /**
    * 根据id删除User
    *
    * @param id 需要删除的User对象的id
    * @return 返回被删除的User对象的id
    * @author chaos
    * @since 2020-05-02
    */
    int deleteUserById(int id);

    /**
    * 根据id更新User
    *
    * @param user 需要更新的User对象
    * @return 返回被更新的User对象的id
    * @author chaos
    * @since 2020-05-02
    */
    int updateUser(User user);

}
```

### 3.ServiceImpl模板代码示例

```java
package cn.hellochaos.generator.service.impl;

import cn.hellochaos.generator.entity.User;
import cn.hellochaos.generator.mapper.UserMapper;
import cn.hellochaos.generator.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;
import cn.hellochaos.generator.exception.bizException.BizException;

/**
* <p>
* 用户 服务实现类
* </p>
*
* @author chaos
* @since 2020-05-02
*/
@Slf4j
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Override
    public Page<User> listUsersByPage(int page, int pageSize, String keyword) {
        log.info("正在执行分页查询user: page = {} pageSize = {} keyword = {}",page,pageSize,keyword);
        QueryWrapper<User> queryWrapper =  new QueryWrapper<User>().like("", keyword);
        //TODO 这里需要自定义用于匹配的字段,并把wrapper传入下面的page方法
        Page<User> result = super.page(new Page<>(page, pageSize));
        log.info("分页查询user完毕: 结果数 = {} ",result.getRecords().size());
        return result;
    }

    @Override
    public User getUserById(int id) {
        log.info("正在查询user中id为{}的数据",id);
        User user = super.getById(id);
        log.info("查询id为{}的user{}",id,(null == user?"无结果":"成功"));
        return user;
    }

    @Override
    public int insertUser(User user) {
        log.info("正在插入user");
        if (super.save(user)) {
            log.info("插入user成功,id为{}",user.getUserId());
            return user.getUserId();
        } else {
            log.error("插入user失败");
            throw new BizException("添加失败");
        }
    }

    @Override
    public int deleteUserById(int id) {
        log.info("正在删除id为{}的user",id);
        if (super.removeById(id)) {
            log.info("删除id为{}的user成功",id);
            return id;
        } else {
            log.error("删除id为{}的user失败",id);
            throw new BizException("删除失败[id=" + id + "]");
        }
    }

    @Override
    public int updateUser(User user) {
        log.info("正在更新id为{}的user",user.getUserId());
        if (super.updateById(user)) {
            log.info("更新d为{}的user成功",user.getUserId());
            return user.getUserId();
        } else {
            log.error("更新id为{}的user失败",user.getUserId());
            throw new BizException("更新失败[id=" + user.getUserId() + "]");
        }
    }

}
```