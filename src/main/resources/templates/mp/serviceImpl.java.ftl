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
            public Page<${entity}> listByPage(int page, int pageSize, String keyword) {
                log.debug("[${entity?uncap_first}]正在执行分页查询: page = " + page + " pageSize = " + pageSize + " keyword = " + keyword);
                Page<${entity}> result = super.page(new Page<>(page, pageSize), new QueryWrapper<${entity}>().like("", keyword));
                log.debug("[${entity?uncap_first}]分页查询完毕: 结果数 = " + result.getRecords().size());
                return result;
            }

            @Override
            public ${entity} getById(int id) {
                log.debug("[${entity?uncap_first}]正在查询id为" + id + "的数据");
                ${entity} ${entity?uncap_first} = super.getById(id);
                log.debug("[${entity?uncap_first}]是否查询到数据: "+(null == ${entity?uncap_first}));
                return ${entity?uncap_first};
            }

            @Override
            public int insert(${entity} ${entity?uncap_first}) {
                log.debug("[${entity?uncap_first}]正在插入数据");
                if (super.save(${entity?uncap_first})) {
                    log.debug("[${entity?uncap_first}]插入成功");
                    return ${entity?uncap_first}.get${entity}Id();
                } else {
                    throw new BizException("添加失败");
                }
            }

            @Override
            public int deleteById(int id) {
                log.debug("[${entity?uncap_first}]正在删除id为"+id+"的数据");
                if (super.removeById(id)) {
                    log.debug("[${entity?uncap_first}]删除成功");
                    return id;
                } else {
                    throw new BizException("删除失败[id=" + id + "]");
                }
            }

            @Override
            public int update(${entity} ${entity?uncap_first}) {
                log.debug("[${entity?uncap_first}]正在更新数据");
                if (super.updateById(${entity?uncap_first})) {
                    log.debug("[${entity?uncap_first}]更新成功");
                    return ${entity?uncap_first}.get${entity}Id();
                } else {
                    throw new BizException("更新失败[id=" + ${entity?uncap_first}.get${entity}Id() + "]");
                }
            }
    }
</#if>
