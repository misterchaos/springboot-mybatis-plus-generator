package cn.hellochaos.generator.exception.bizException;

/**
 * @Description : 运行时业务中出现的异常
 * @Param :
 * @Return :
 * @Author : SheldonPeng
 * @Date : 2019-10-11
 */
public class BizException extends RuntimeException{

    private static final long serialVersionUID = -7864604160297181941L;

    private final String code;

    /**
     * @Description : 指定枚举类中的错误类
     * @Param : [errorCode]
     * @Return :
     * @Author : SheldonPeng
     * @Date : 2019-10-11
     */
    public BizException(final BizExceptionCode exceptionCode) {
        super(exceptionCode.getMessage());
        this.code = exceptionCode.getCode();
    }
    /**
     * @Description : 指定具体业务错误的信息
     * @Param : [detailedMessage]
     * @Return :
     * @Author : SheldonPeng
     * @Date : 2019-10-11
     */
    public BizException(final String message) {
        super(message);
        this.code = BizExceptionCodeEnum.SPECIFIED.getCode();
    }

    public String getCode() {
        return code;
    }

}
