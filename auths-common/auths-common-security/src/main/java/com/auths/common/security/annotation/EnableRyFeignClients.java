package com.auths.common.security.annotation;

import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.cloud.openfeign.FeignAutoConfiguration;

import java.lang.annotation.*;

/**
 * 自定义feign注解
 * 添加basePackages路径
 * 
 * @author auths
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@EnableFeignClients
public @interface EnableRyFeignClients
{
    String[] value() default {};

    String[] basePackages() default { "com.auths" };

    Class<?>[] basePackageClasses() default {};

    Class<?>[] defaultConfiguration() default {};

    Class<?>[] clients() default {};
}
