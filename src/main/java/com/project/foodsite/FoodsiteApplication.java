package com.project.foodsite;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@MapperScan("com.project.foodsite.dao")
@EnableScheduling
public class FoodsiteApplication {

	public static void main(String[] args) {
		SpringApplication.run(FoodsiteApplication.class, args);
	}

}
