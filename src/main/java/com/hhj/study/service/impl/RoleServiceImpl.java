package com.hhj.study.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hhj.study.domain.Role;
import com.hhj.study.mapper.RoleMapper;
import com.hhj.study.service.RoleService;

import javax.annotation.Resource;
import java.util.Collection;
import java.util.Map;
import java.util.function.Function;

public class RoleServiceImpl implements RoleService {

    @Resource
    private RoleMapper roleMapper;

    @Override
    public Role getRoleById(Integer id) {
        return roleMapper.selectById(id);
    }

    @Override
    public boolean saveBatch(Collection<Role> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdateBatch(Collection<Role> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean updateBatchById(Collection<Role> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdate(Role entity) {
        return false;
    }

    @Override
    public Role getOne(Wrapper<Role> queryWrapper, boolean throwEx) {
        return null;
    }

    @Override
    public Map<String, Object> getMap(Wrapper<Role> queryWrapper) {
        return null;
    }

    @Override
    public <V> V getObj(Wrapper<Role> queryWrapper, Function<? super Object, V> mapper) {
        return null;
    }

    @Override
    public BaseMapper<Role> getBaseMapper() {
        return null;
    }
}
