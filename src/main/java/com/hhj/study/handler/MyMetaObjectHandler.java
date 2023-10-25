package com.hhj.study.handler;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

// 用于自动填充公共字段的处理器 在插入和更新操作中自动填充公共字段
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    /**
     * 第一种：主要是在使用MyBatis-Plus内置的saveOrUpdateUser方法时可以自动识别是新增还是更新 从而自动填充时间
     * @param metaObject 元对象
     */
//    @Override
//    public void insertFill(MetaObject metaObject) {
//        this.strictInsertFill(metaObject, "createTime", Date.class, new Date());
//        this.strictInsertFill(metaObject, "updateTime", Date.class, new Date());
//    }
//
//    @Override
//    public void updateFill(MetaObject metaObject) {
//        this.strictUpdateFill(metaObject, "updateTime", Date.class, new Date());
//    }

    /**
     * 第二种：自己写的增改方法
     * @param metaObject 元对象
     */
    @Override
    public void insertFill(MetaObject metaObject) {
        strictInsertFill(metaObject, "createTime", Date.class, new Date());
        strictInsertFill(metaObject, "updateTime", Date.class, null); // 设置为null，不自动填充
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        strictUpdateFill(metaObject, "updateTime", Date.class, new Date());
    }
}
