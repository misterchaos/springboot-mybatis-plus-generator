package cn.hellochaos.generator.entity.dto;

import cn.hellochaos.generator.exception.bizException.BizException;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * @Description: $
 * @Param: $
 * @return: $
 * @author: SheledonPeng
 * @Date: $
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ResultBean<T> implements Serializable {


    // 处理成功的状态码
    public static final String SUCCESS_CODE = "1";
    // 发生未知错误的状态码
    public static final String UNSPECIFIED_CODE = "500";

    public static final String BIND_CODE = "4005";

    private String message = "success";
    private String code = ResultBean.SUCCESS_CODE;

    private T data;

    public ResultBean(String msg, String code) {
        this.message = msg;
        this.code = code;
    }

    public ResultBean(T data) {
        this.data = data;
    }

    public ResultBean(String code, T data){
        this.code = code;
        this.data = data;
    }

    /**
     * @Description : 此时系统发生未知异常
     * @Param : [e]
     * @Return :
     * @Author : SheldonPeng
     * @Date : 2019-10-11
     */
    public ResultBean(Throwable e) {
        super();
        this.message = "发生未知错误，请稍后重试!";
        this.code = ResultBean.UNSPECIFIED_CODE;
    }

    public ResultBean(BizException e){
        super();
        this.message = e.getMessage();
        this.code = e.getCode();
    }


}
