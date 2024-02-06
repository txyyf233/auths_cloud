package com.auths.gen;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.auths.common.security.annotation.EnableCustomConfig;
import com.auths.common.security.annotation.EnableRyFeignClients;
import com.auths.common.swagger.annotation.EnableCustomSwagger2;

/**
 * 代码生成
 * 
 * @author auths
 */
@EnableCustomConfig
@EnableCustomSwagger2
@EnableRyFeignClients
@SpringBootApplication
public class AuthsGenApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(AuthsGenApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  代码生成模块启动成功   ლ(´ڡ`ლ)ﾞ");
    }
}
