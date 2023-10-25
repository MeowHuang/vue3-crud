package com.hhj.study.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hhj.study.domain.UserRole;
import com.hhj.study.mapper.RoleMapper;
import com.hhj.study.mapper.UserMapper;
import com.hhj.study.mapper.UserRoleMapper;
import com.hhj.study.service.UserRoleService;

import javax.annotation.Resource;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

public class UserRoleServiceImpl implements UserRoleService {

    @Resource
    private UserMapper userMapper;
    @Resource
    private RoleMapper roleMapper;
    @Resource
    private UserRoleMapper userRoleMapper;

    /**
     * 通过用户Id获取用户角色
     *
     * @param userId 用户Id
     * @return
     */
    @Override
    public List<UserRole> getUserRolesByUserId(Integer userId) {
        QueryWrapper<UserRole> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        return userRoleMapper.selectList(queryWrapper);
    }

    /**
     * 更新用户角色
     *
     * @param userId  用户ID
     * @param roleIds 角色ID
     */
    @Override
    public void updateUserRoles(Integer userId, List<Integer> roleIds) {
        QueryWrapper<UserRole> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        userRoleMapper.delete(queryWrapper);

        // Then, insert the new user roles
        for (Integer roleId : roleIds) {
            UserRole userRole = new UserRole();
            userRole.setUserId(userId);
            userRole.setRoleId(roleId);
            userRoleMapper.insert(userRole);
        }
    }

    @Override
    public boolean saveBatch(Collection<UserRole> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdateBatch(Collection<UserRole> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean updateBatchById(Collection<UserRole> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdate(UserRole entity) {
        return false;
    }

    @Override
    public UserRole getOne(Wrapper<UserRole> queryWrapper, boolean throwEx) {
        return null;
    }

    @Override
    public Map<String, Object> getMap(Wrapper<UserRole> queryWrapper) {
        return null;
    }

    @Override
    public <V> V getObj(Wrapper<UserRole> queryWrapper, Function<? super Object, V> mapper) {
        return null;
    }

    @Override
    public BaseMapper<UserRole> getBaseMapper() {
        return null;
    }
}
