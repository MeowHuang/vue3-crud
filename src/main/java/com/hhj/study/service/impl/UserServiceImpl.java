package com.hhj.study.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hhj.study.domain.Role;
import com.hhj.study.domain.User;
import com.hhj.study.domain.UserRole;
import com.hhj.study.mapper.RoleMapper;
import com.hhj.study.mapper.UserMapper;
import com.hhj.study.mapper.UserRoleMapper;
import com.hhj.study.service.UserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
    @Resource
    private UserMapper userMapper;
    @Resource
    private RoleMapper roleMapper;
    @Resource
    private UserRoleMapper userRoleMapper;

    @Override
    public boolean saveBatch(Collection<User> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdateBatch(Collection<User> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean updateBatchById(Collection<User> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdate(User user) {
        if (user.getId() == null) {
            // 如果id为空，执行插入操作
            return userMapper.insert(user) > 0;
        } else {
            // 如果id不为空，执行更新操作
            return userMapper.updateById(user) > 0;
        }
    }

    @Override
    public User getOne(Wrapper<User> queryWrapper, boolean throwEx) {
        return null;
    }

    @Override
    public Map<String, Object> getMap(Wrapper<User> queryWrapper) {
        return null;
    }

    @Override
    public <V> V getObj(Wrapper<User> queryWrapper, Function<? super Object, V> mapper) {
        return null;
    }

    @Override
    public UserMapper getBaseMapper() {
        return userMapper;
    }

    /**
     * 查询所有User
     *
     * @return
     */
    @Override
    public List<User> getAllUsers() {
        return userMapper.selectList(null);
    }

    /**
     * 查询所有User及其对应的角色信息
     *
     * @return
     */
    @Override
    public List<User> getAllUsersWithRoles() {
        return userMapper.findAllUsersWithRoles();
    }

    /**
     * 分页查询
     *
     * @param pageNo   请求的页数
     * @param pageSize 每页包含的数据条目数
     * @return
     */
    @Override
    public PageInfo<User> getAllUserByPage(Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        PageInfo pageInfo = new PageInfo<>(userMapper.findAllUsersWithRoles());
        return pageInfo;
    }

    /**
     * 分页模糊查询
     *
     * @param attributes 模糊字段
     * @param pageNo     请求的页数
     * @param pageSize   每页包含的数据条目数
     * @return
     */
    @Override
    public PageInfo<User> getUsersByAttributes(String attributes, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        PageInfo pageInfo = new PageInfo<>(userMapper.findUsersWithRolesByKeyword(attributes));
        return pageInfo;
    }

    /**
     * 新增用户信息(含用户对应的角色信息)
     * @param user
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.READ_COMMITTED,rollbackFor =Exception.class)
    public User addUserInformation(User user) {
        // 插入用户信息
        user.setCreateTime(new Date()); // 设置创建时间为当前时间
        user.setUpdateTime(null); // 设置更新时间为空，排除更新时间字段
        userMapper.insert(user);

        // 插入用户角色信息
        String roleName = user.getRoleName();
        if (roleName != null) {
            Role role = roleMapper.selectOne(new QueryWrapper<Role>().eq("role_name", roleName));
            if (role != null) {
                UserRole userRole = new UserRole();
                userRole.setUserId(user.getId());
                userRole.setRoleId(role.getId());
                userRoleMapper.insert(userRole);

                user.setRoleName(role.getRoleName());// 将角色名赋值给用户对象的 roleName 字段
            }
        }

        return user;
    }

    /**
     * 更新用户信息(含有用户对应的角色信息)
     *
     * @param user
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED,isolation = Isolation.READ_COMMITTED,rollbackFor =Exception.class)
    public User updateUserInformation(User user) {
        // 更新用户信息
        user.setUpdateTime(new Date()); // 设置更新时间为当前时间
        userMapper.updateById(user);
        // 更新用户角色信息
        String roleName = user.getRoleName();
        if (roleName != null) {
            Role role = roleMapper.selectOne(new QueryWrapper<Role>().eq("role_name", roleName));
            if (role != null) {
                // 根据用户ID找到对应的UserRole记录
                List<UserRole> userRoles = userRoleMapper.selectList(new QueryWrapper<UserRole>().eq("user_id", user.getId()));
                // 更新对应的角色信息
                for (UserRole userRole : userRoles) {
                    userRole.setRoleId(role.getId());
                    userRoleMapper.updateById(userRole);
                }
                user.setRoleName(role.getRoleName()); // 设置返回的user中的roleName字段
            }
        }

        return user;
    }


    /**
     * 删除用户信息(清除用户角色表中的关联)
     * @param id
     * @return
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
    public boolean removeUserByIdWithRole(Serializable id) {
        // 删除用户角色信息
        QueryWrapper<UserRole> userRoleWrapper = new QueryWrapper<>();
        userRoleWrapper.eq("user_id", id);
        userRoleMapper.delete(userRoleWrapper);

        // 删除用户信息
        boolean result = this.removeById(id);

        return result;
    }

}
