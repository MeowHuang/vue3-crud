package com.hhj.study.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hhj.study.domain.UserRole;

import java.util.List;

public interface UserRoleService extends IService<UserRole> {

    /**
     * 通过用户Id获取用户角色
     * @param userId 用户Id
     * @return
     */
    List<UserRole> getUserRolesByUserId(Integer userId);

    /**
     * 更新用户角色
     * @param userId 用户ID
     * @param roleIds 角色ID
     */
    void updateUserRoles(Integer userId, List<Integer> roleIds);

}
