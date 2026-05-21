package com.project.foodsite;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.project.foodsite.dao")
public class FoodsiteApplication {

	public static void main(String[] args) {
		SpringApplication.run(FoodsiteApplication.class, args);
	}

}
