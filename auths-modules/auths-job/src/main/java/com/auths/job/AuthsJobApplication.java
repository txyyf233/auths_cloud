package com.auths.job;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.auths.common.security.annotation.EnableCustomConfig;
import com.auths.common.security.annotation.EnableRyFeignClients;
import com.auths.common.swagger.annotation.EnableCustomSwagger2;

/**
 * 定时任务
 * 
 * @author auths
 */
@EnableCustomConfig
@EnableCustomSwagger2
@EnableRyFeignClients   
@SpringBootApplication
public class AuthsJobApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(AuthsJobApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  定时任务模块启动成功   ლ(´ڡ`ლ)ﾞ");
    }
}
