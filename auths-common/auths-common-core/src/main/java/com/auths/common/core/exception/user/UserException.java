package com.auths.common.core.exception.user;

import com.auths.common.core.exception.base.BaseException;

/**
 * 用户信息异常类
 * 
 * @author auths
 */
public class UserException extends BaseException
{
    private static final long serialVersionUID = 1L;

    public UserException(String code, Object[] args)
    {
        super("user", code, args, null);
    }
}
