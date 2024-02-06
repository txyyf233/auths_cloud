package com.auths.common.security.feign;

import feign.Contract;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.cloud.openfeign.support.SpringMvcContract;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import feign.RequestInterceptor;
import org.springframework.core.annotation.Order;
import org.springframework.core.convert.ConversionService;

/**
 * Feign 配置注册
 *
 * @author auths
 **/
@Configuration
public class FeignAutoConfiguration
{
    @Bean
    public RequestInterceptor requestInterceptor()
    {
        return new FeignRequestInterceptor();
    }
}
