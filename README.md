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
- 运行CodeGenerator类，输入数据库表名
- 查看生成的代码

## 三、生成的代码示例

### 1.Controller模板代码示例
```java

package com.qg.flower.controller;


import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.qg.flower.entity.dto.ResultBean;
import com.qg.flower.service.UserService;
import com.qg.flower.entity.User;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
    *  前端控制器
    * </p>
 *
 * @author chaos
 * @since 2020-04-28
 * @version v1.0
 */
@RestController
@RequestMapping("/flower/api/v1/user")
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
        return new ResultBean<>(userService.listByPage(page, pageSize,keyword));
    }


    /**
    * 根据id查询
    */
    @RequestMapping(method = RequestMethod.GET, value = "/{id}")
    public ResultBean<?> getById(@PathVariable("id") Integer id) {
        return new ResultBean<>(userService.getById(id));
    }

    /**
    * 新增
    */
    @RequestMapping(method = RequestMethod.POST)
    public ResultBean<?> insert(@RequestBody User user) {
        return new ResultBean<>(userService.insert(user));
    }

    /**
    * 删除
    */
    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public ResultBean<?> deleteById(@PathVariable("id") Integer id) {
        return new ResultBean<>(userService.deleteById(id));
    }

    /**
    * 修改
    */
    @RequestMapping(method = RequestMethod.PUT)
    public ResultBean<?> updateById(@RequestBody User user) {
        return new ResultBean<>(userService.update(user));
    }
}

```

### 2.Service模板代码示例
```java
package com.qg.flower.service;

import com.qg.flower.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

/**
* <p>
    *  服务类
    * </p>
*
* @author chaos
* @since 2020-04-28
*/
    public interface UserService {

        /**
        * 分页查询
        *
        * @param page     当前页数
        * @param pageSize 页的大小
        * @param keyword  搜索关键词
        */
        Page<User> listByPage(int page, int pageSize, String keyword);

        /**
        * 根据id查询
        */
        User getById(int id);
    
        /**
        * 插入
        */
        int insert(User user);
    
        /**
        * 根据id删除
        */
        int deleteById(int id);
    
        /**
        * 根据id更新
        */
        int update(User user);
    
    }

```

### 3.ServiceImpl模板代码示例

```java
package com.qg.flower.service.impl;

import com.qg.flower.entity.User;
import com.qg.flower.exception.bizException.BizException;
import com.qg.flower.mapper.UserMapper;
import com.qg.flower.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;

/**
* <p>
    *  服务实现类
    * </p>
*
* @author chaos
* @since 2020-04-28
*/
@Slf4j

@Service
    public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

            @Override
            public Page<User> listByPage(int page, int pageSize, String keyword) {
                log.debug("[user]正在执行分页查询: page = " + page + " pageSize = " + pageSize + " keyword = " + keyword);
                Page<User> result = super.page(new Page<>(page, pageSize), new QueryWrapper<User>().like("", keyword));
                log.debug("[user]分页查询完毕: 结果数 = " + result.getRecords().size());
                return result;
            }

            @Override
            public User getById(int id) {
                log.debug("[user]正在查询id为" + id + "的数据");
                User user = super.getById(id);
                log.debug("[user]是否查询到数据: "+(null == user));
                return user;
            }

            @Override
            public int insert(User user) {
                log.debug("[user]正在插入数据");
                if (super.save(user)) {
                    log.debug("[user]插入成功");
                    return user.getUserId();
                } else {
                    throw new BizException("添加失败");
                }
            }

            @Override
            public int deleteById(int id) {
                log.debug("[user]正在删除id为"+id+"的数据");
                if (super.removeById(id)) {
                    log.debug("[user]删除成功");
                    return id;
                } else {
                    throw new BizException("删除失败[id=" + id + "]");
                }
            }

            @Override
            public int update(User user) {
                log.debug("[user]正在更新数据");
                if (super.updateById(user)) {
                    log.debug("[user]更新成功");
                    return user.getUserId();
                } else {
                    throw new BizException("更新失败[id=" + user.getUserId() + "]");
                }
            }
    }

```