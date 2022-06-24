package com.example.config;

import cn.hutool.log.Log;
import com.baomidou.mybatisplus.core.incrementer.IKeyGenerator;
import com.baomidou.mybatisplus.core.injector.ISqlInjector;
import com.baomidou.mybatisplus.extension.injector.LogicSqlInjector;
import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


/**
 * mybatis-plus 插件配置
 */
@Configuration
public class MybatisPlusPluginsConfig {

    private static final Log logger = Log.get();

    /**
     * 分页插件
     */
    @Bean
    public PaginationInterceptor paginationInterceptor() {
        return new PaginationInterceptor();
    }


    @Bean
    public ISqlInjector sqlInjector() {
        return new LogicSqlInjector();
    }



}
