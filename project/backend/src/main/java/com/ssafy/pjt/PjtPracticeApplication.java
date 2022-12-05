package com.ssafy.pjt;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
@ComponentScan(basePackages = {"com.ssafy"})
@Configuration
//@EnableAspectJAutoProxy
@MapperScan(basePackages = { "com.ssafy.pjt.**.model.mapper" })
public class PjtPracticeApplication implements WebMvcConfigurer{

	public static void main(String[] args) {
		SpringApplication.run(PjtPracticeApplication.class, args);
	}

}
