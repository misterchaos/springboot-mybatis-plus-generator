package cn.hellochaos.generator.exception.bizException;


/**
 * @Description : 异常消息的枚举类(此类属于业务异常枚举类)
 * @Param :
 * @Return :
 * @Author : SheldonPeng
 * @Date : 2019-10-11
 */
public enum BizExceptionCodeEnum implements BizExceptionCode{

    // 已指明的异常,在异常使用时message并不返回前端，返回前端的为throw新的异常时指定的message
    SPECIFIED("-1","系统发生异常,请稍后重试"),

    // 常用业务异常
    USER_NAME_NULL("-1","用户名不能为空，请重新输入!"),
    USER_PASSWORD_NULL("-1","密码不能为空，请重新输入!"),
    USER_PASSWORD_WRONG("-1","密码错误,请检查后重新输入!"),
    PAGE_NUM_NULL("4001","页码不能为空"),
    PAGE_SIZE_NULL("4002","页数不能为空"),
    SEARCH_NULL("4004","搜索条件不能为空,请检查后重新输入!"),
    NO_LOGIN("3001", "用户未进行登录")
    ;

    private final String code;

    private final String message;

    /**
     * @Description :
     * @Param : [code, message]
     * @Return :
     * @Author : SheldonPeng
     * @Date : 2019-10-11
     */
     BizExceptionCodeEnum(String code,String message){

        this.code = code;
        this.message = message;
    }

    @Override
    public String getCode() {
        return code;
    }

    @Override
    public String getMessage() {
        return message;
    }
}
