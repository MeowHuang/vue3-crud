package com.hhj.study.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.pagehelper.PageInfo;
import com.hhj.study.domain.User;

import java.io.Serializable;
import java.util.List;

public interface UserService extends IService<User> {

    /**
     * 查询所有User
     */
    List<User> getAllUsers();

    /**
     * 查询所有User及其对应的角色信息
     * @return
     */
    List<User> getAllUsersWithRoles();

    /**
     * 分页显示
     * @param pageNo 请求的页数
     * @param pageSize 每页包含的数据条目数
     */
    public PageInfo<User> getAllUserByPage(Integer pageNo, Integer pageSize);

    /**
     * 分页模糊查询
     * @param attributes 模糊字段
     * @param pageNo 请求的页数
     * @param pageSize 每页包含的数据条目数
     */
    public PageInfo<User> getUsersByAttributes(String attributes,Integer pageNo, Integer pageSize);

    /**
     * 更新用户信息(含有用户对应的角色信息)
     * @param user
     * @return
     */
    User updateUserInformation(User user);

    /**
     * 新增用户信息(含用户对应的角色信息)
     * @param user
     * @return
     */
    User addUserInformation(User user);

    /**
     * 删除用户信息(清除用户角色表中的关联)
     * @param id
     * @return
     */
    boolean removeUserByIdWithRole(Serializable id);
}
