package ${package.ServiceImpl};

import ${package.Entity}.${entity};
import ${package.Mapper}.${table.mapperName};
import ${package.Service}.${table.serviceName};
import ${superServiceImplClassPackage};
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;
import cn.hellochaos.generator.exception.bizException.BizException;

/**
* <p>
* ${table.comment!} 服务实现类
* </p>
*
* @author ${author}
* @since ${date}
*/
@Slf4j
@Service
<#if kotlin>
    open class ${table.serviceImplName} : ${superServiceImplClass}<${table.mapperName}, ${entity}>(), ${table.serviceName} {

    }
<#else>
public class ${table.serviceImplName} extends ${superServiceImplClass}<${table.mapperName}, ${entity}> implements ${table.serviceName} {

    @Override
    public Page<${entity}> list${entity}sByPage(int page, int pageSize, String factor) {
        log.info("正在执行分页查询${entity?uncap_first}: page = {} pageSize = {} factor = {}",page,pageSize,factor);
        QueryWrapper<${entity}> queryWrapper =  new QueryWrapper<${entity}>().like("", factor);
        //TODO 这里需要自定义用于匹配的字段,并把wrapper传入下面的page方法
        Page<${entity}> result = super.page(new Page<>(page, pageSize));
        log.info("分页查询${entity?uncap_first}完毕: 结果数 = {} ",result.getRecords().size());
        return result;
    }

    @Override
    public ${entity} get${entity}ById(int id) {
        log.info("正在查询${entity?uncap_first}中id为{}的数据",id);
        ${entity} ${entity?uncap_first} = super.getById(id);
        log.info("查询id为{}的${entity?uncap_first}{}",id,(null == ${entity?uncap_first}?"无结果":"成功"));
        return ${entity?uncap_first};
    }

    @Override
    public int insert${entity}(${entity} ${entity?uncap_first}) {
        log.info("正在插入${entity?uncap_first}");
        if (super.save(${entity?uncap_first})) {
            log.info("插入${entity?uncap_first}成功,id为{}",${entity?uncap_first}.get${entity}Id());
            return ${entity?uncap_first}.get${entity}Id();
        } else {
            log.error("插入${entity?uncap_first}失败");
            throw new BizException("添加失败");
        }
    }

    @Override
    public int delete${entity}ById(int id) {
        log.info("正在删除id为{}的${entity?uncap_first}",id);
        if (super.removeById(id)) {
            log.info("删除id为{}的${entity?uncap_first}成功",id);
            return id;
        } else {
            log.error("删除id为{}的${entity?uncap_first}失败",id);
            throw new BizException("删除失败[id=" + id + "]");
        }
    }

    @Override
    public int update${entity}(${entity} ${entity?uncap_first}) {
        log.info("正在更新id为{}的${entity?uncap_first}",${entity?uncap_first}.get${entity}Id());
        if (super.updateById(${entity?uncap_first})) {
            log.info("更新d为{}的${entity?uncap_first}成功",${entity?uncap_first}.get${entity}Id());
            return ${entity?uncap_first}.get${entity}Id();
        } else {
            log.error("更新id为{}的${entity?uncap_first}失败",${entity?uncap_first}.get${entity}Id());
            throw new BizException("更新失败[id=" + ${entity?uncap_first}.get${entity}Id() + "]");
        }
    }

}
</#if>
