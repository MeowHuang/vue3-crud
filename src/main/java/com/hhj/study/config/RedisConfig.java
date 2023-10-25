package com.hhj.study.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;

import java.net.UnknownHostException;

@Configuration // 表明这个类是Spring配置类，将被自动扫描
public class RedisConfig {
	//往IOC容器中注入一个redisTemplate，用于替换之前的默认redisTemplate
	@Bean
	// 通过自动注入从上下文中获取Redis连接工厂
	public RedisTemplate<Object, Object> redisTemplate(LettuceConnectionFactory connectionFactory)
			throws UnknownHostException {
		// 创建一个新的RedisTemplate实例
		RedisTemplate<Object, Object> redisTemplate = new RedisTemplate<>();
		// 设置Redis连接工厂
		redisTemplate.setConnectionFactory(connectionFactory);
		// 设置键（key）的序列化方式，默认是JDK序列化
		redisTemplate.setKeySerializer(new JdkSerializationRedisSerializer());
		// 设置值（value）的序列化方式为JSON
		redisTemplate.setValueSerializer(new GenericJackson2JsonRedisSerializer());
		return redisTemplate;
	}
}
