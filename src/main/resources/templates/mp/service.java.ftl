package ${package.Service};

import ${package.Entity}.${entity};
import ${superServiceClassPackage};
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

/**
* <p>
* ${table.comment!} 服务类
* </p>
*
* @author ${author}
* @since ${date}
*/
<#if kotlin>
    interface ${table.serviceName} : ${superServiceClass}<${entity}>
<#else>
public interface ${table.serviceName} {

    /**
    * 分页查询${entity}
    *
    * @param page     当前页数
    * @param pageSize 页的大小
    * @param factor  搜索关键词
    * @return 返回mybatis-plus的Page对象,其中records字段为符合条件的查询结果
    * @author ${author}
    * @since ${date}
    */
    Page<${entity}> list${entity}sByPage(int page, int pageSize, String factor);

    /**
    * 根据id查询${entity}
    *
    * @param id 需要查询的${entity}的id
    * @return 返回对应id的${entity}对象
    * @author ${author}
    * @since ${date}
    */
    ${entity} get${entity}ById(int id);

    /**
    * 插入${entity}
    *
    * @param ${entity?uncap_first} 需要插入的${entity}对象
    * @return 返回插入成功之后${entity}对象的id
    * @author ${author}
    * @since ${date}
    */
    int insert${entity}(${entity} ${entity?uncap_first});

    /**
    * 根据id删除${entity}
    *
    * @param id 需要删除的${entity}对象的id
    * @return 返回被删除的${entity}对象的id
    * @author ${author}
    * @since ${date}
    */
    int delete${entity}ById(int id);

    /**
    * 根据id更新${entity}
    *
    * @param ${entity?uncap_first} 需要更新的${entity}对象
    * @return 返回被更新的${entity}对象的id
    * @author ${author}
    * @since ${date}
    */
    int update${entity}(${entity} ${entity?uncap_first});

}
</#if>
