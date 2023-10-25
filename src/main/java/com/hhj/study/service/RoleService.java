package com.hhj.study.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hhj.study.domain.Role;

public interface RoleService extends IService<Role> {

    /**
     * 通过Id获取角色
     * @param id
     * @return
     */
    Role getRoleById(Integer id);

}
