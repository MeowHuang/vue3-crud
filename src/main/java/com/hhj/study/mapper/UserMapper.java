package com.hhj.study.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hhj.study.domain.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface UserMapper extends BaseMapper<User> {

    /**
     * 查询所有用户及其角色信息
     * @return
     */
    @Select("SELECT u.id, u.name, u.email, u.phone, u.state, u.address, u.create_time, u.update_time, r.role_name as roleName " +
            "FROM tb_user u " +
            "JOIN tb_user_role ur ON u.id = ur.user_id " +
            "JOIN tb_role r ON ur.role_id = r.id " +
            "ORDER BY u.id")
    List<User> findAllUsersWithRoles();

    /**分页模糊查询
     *
     * @param keyword
     * @return
     */
    //@Select("SELECT * FROM `tb_user` u WHERE u.name LIKE concat('%',#{keyword},'%') OR u.state LIKE concat('%',#{keyword},'%') OR u.address LIKE concat('%',#{keyword},'%')")
    @Select("SELECT u.id, u.name, u.email, u.phone, u.state, u.address, u.create_time, u.update_time, r.role_name as roleName " +
            "FROM tb_user u " +
            "JOIN tb_user_role ur ON u.id = ur.user_id " +
            "JOIN tb_role r ON ur.role_id = r.id " +
            "WHERE CONCAT(u.name, u.email, u.phone, u.state, u.address, r.role_name) " +
            "LIKE CONCAT('%',#{keyword},'%') "+
            "ORDER BY u.id")
    List<User> findUsersWithRolesByKeyword(@Param("keyword") String keyword);
}
