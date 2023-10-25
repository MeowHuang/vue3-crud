package com.hhj.study.config;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.Configuration;

@Configuration // 标识该类为Spring的配置类
public class AppConfig implements ApplicationContextAware {

    // 用于保存ApplicationContext的静态变量
    private static ApplicationContext applicationContext;

    // 实现ApplicationContextAware接口的方法，用于设置ApplicationContext
    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        // 设置静态变量applicationContext为传入的applicationContext
        this.applicationContext = applicationContext;
    }

    // 通过指定的名称从ApplicationContext中获取Bean
    public static Object getBean(String name) {
        return applicationContext.getBean(name);
    }
}

/*
上面这种写法通常是在需要在非Spring管理的类中获取Spring管理的Bean时使用。
由于非Spring管理的类无法直接通过自动注入等方式获取Spring的ApplicationContext，
因此可以通过实现ApplicationContextAware接口，并将ApplicationContext保存为静态变量的方式来实现。
当有需要在没有直接注入ApplicationContext的情况下获取Bean时，可以使用这种方式。
一些特殊的工具类或者需要在静态方法中获取Bean的情况下可能会用到这种写法。
但是需要注意这种写法会引入一些潜在的问题，比如可能会导致内存泄漏或者线程安全问题，因此在使用的时候需要注意管理好相应的资源。*/
