package com.hhj.study;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@MapperScan("com.hhj.study.mapper")
@EnableTransactionManagement
public class SpringBootVue3CrudApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringBootVue3CrudApplication.class, args);
    }

}
