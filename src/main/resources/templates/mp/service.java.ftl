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
        * 分页查询
        *
        * @param page     当前页数
        * @param pageSize 页的大小
        * @param keyword  搜索关键词
        */
        Page<${entity}> listByPage(int page, int pageSize, String keyword);

        /**
        * 根据id查询
        */
        ${entity} getById(int id);
    
        /**
        * 插入
        */
        int insert(${entity} ${entity?uncap_first});
    
        /**
        * 根据id删除
        */
        int deleteById(int id);
    
        /**
        * 根据id更新
        */
        int update(${entity} ${entity?uncap_first});
    
    }
</#if>
