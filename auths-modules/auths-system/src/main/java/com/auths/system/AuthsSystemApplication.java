package com.auths.system;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.auths.common.security.annotation.EnableCustomConfig;
import com.auths.common.security.annotation.EnableRyFeignClients;
import com.auths.common.swagger.annotation.EnableCustomSwagger2;

/**
 * 系统模块
 * 
 * @author auths
 */
@EnableCustomConfig
@EnableCustomSwagger2
@EnableRyFeignClients
@SpringBootApplication
public class AuthsSystemApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(AuthsSystemApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  系统模块启动成功   ლ(´ڡ`ლ)ﾞ");
    }
}
