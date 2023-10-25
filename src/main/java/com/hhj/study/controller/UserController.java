package com.hhj.study.controller;

import com.baomidou.mybatisplus.extension.api.R;
import com.github.pagehelper.PageInfo;
import com.hhj.study.domain.User;
import com.hhj.study.service.UserService;
import com.hhj.study.util.RedisUtil;
import com.hhj.study.util.ResultUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RedisUtil redisUtil;

    /**
     * 查询所有用户及其角色信息 不分页
     */
    @GetMapping("/queryAll")
    public List<User> getAllUsers() {
        // 尝试从缓存中获取数据
        List<User> users = (List<User>) redisUtil.get("allUsers");
        if (users != null) {
            System.out.println("查询所有用户→从Redis缓存中检索用户!");
            return users;
        } else {
            users = userService.getAllUsersWithRoles();
            // 将查询结果存储在 Redis 中
            redisUtil.set("allUsers", users);
            return users;
        }
    }


    /**
     * 分页查询所有用户
     *
     * @param map 集合
     * @return 返回code msg data(pageNo,pageSize)
     */
    @PostMapping("/queryAllByPage")
    public Object getAllUserByPage(@RequestBody Map<String, Integer> map) {
        /* 1.不使用redis缓存 */
        //return ResultUtil.define(1, "查询成功", userService.getAllUserByPage((Integer) map.get("pageNo"), (Integer) map.get("pageSize")));
        /* 2.使用redis缓存 */
        int pageNo = map.get("pageNo");
        int pageSize = map.get("pageSize");

        // 构建缓存的键
        String cacheKey = "allUsers_page_" + pageNo + "_" + pageSize;

        // 尝试从缓存中获取数据
        PageInfo<User> pageInfo = (PageInfo<User>) redisUtil.get(cacheKey);

        if (pageInfo != null) {
            System.out.println("分页查询所有用户→从Redis缓存中检索用户!");
            return ResultUtil.define(1, "查询成功", pageInfo);
        } else {
            // 调用适当的方法获取 PageInfo<User> 对象
            pageInfo = userService.getAllUserByPage(pageNo, pageSize);
            // 将查询结果存储在 Redis 中
            redisUtil.set(cacheKey, pageInfo);
            return ResultUtil.define(1, "查询成功", pageInfo);
        }


    }

    /**
     * 分页模糊查询
     *
     * @param map 集合
     * @return 返回code msg data(attributes,pageNo,pageSize)
     */
    @PostMapping("/queryByKeywordAndPage")
    public Object getUsersByAttributes(@RequestBody Map<String, Object> map) {
        /* 1.不使用redis缓存 */
        //return ResultUtil.define(1, "查询成功", userService.getUsersByAttributes(String.valueOf(map.get("attributes")), (Integer) map.get("pageNo"), (Integer) map.get("pageSize")));
        /* 2.使用redis缓存 */
        String attribute = String.valueOf(map.get("attributes"));
        int pageNo = (Integer) map.get("pageNo");
        int pageSize = (Integer) map.get("pageSize");

        // 构建缓存的键
        String cacheKey = "users_attribute_" + attribute + "_page_" + pageNo + "_" + pageSize;

        // 尝试从缓存中获取数据
        PageInfo<User> pageInfo = (PageInfo<User>) redisUtil.get(cacheKey);

        if (pageInfo != null) {
            System.out.println("分页模糊查询→从Redis缓存中检索用户!");
            return ResultUtil.define(1, "查询成功", pageInfo);
        } else {
            pageInfo = userService.getUsersByAttributes(attribute, pageNo, pageSize);
            // 将查询结果存储在 Redis 中
            redisUtil.set(cacheKey, pageInfo);
            return ResultUtil.define(1, "查询成功", pageInfo);
        }
    }

    /**
     * 更新用户信息(包括角色信息)
     * @param user
     * @return
     */
    @PutMapping("/UpdateUserInfo")
    public ResponseEntity<Map<String, Object>> updateUserInformation(@RequestBody User user) {
        Map<String, Object> response = new HashMap<>();
        try {
            User updatedUser = userService.updateUserInformation(user);

            // 清空整个 Redis 实例中的所有数据库
            redisUtil.flushDb();
            // 更新所有用户的缓存
            List<User> allUsers = userService.getAllUsersWithRoles();
            redisUtil.set("allUsers", allUsers);

            response.put("message", "User saved or updated successfully!");
            response.put("user", updatedUser);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("message", "Error occurred while saving or updating user.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }



    /**
     * 执行插入或者更新操作 有id则更新，无id则插入
     *
     * @param user
     * @return 返回data{message,user} status statusText headers config
     * @response
     */
//    @PostMapping("/saveOrUpdate")
//    public ResponseEntity<Map<String, Object>> saveOrUpdateUser(@RequestBody User user) {
//        boolean result = userService.saveOrUpdate(user);
//        Map<String, Object> response = new HashMap<>();
//        if (result) {
//            response.put("message", "User saved or updated successfully!");
//            response.put("user", user);
//
//
//            // 清空整个 Redis 实例中的所有数据库
//            redisUtil.flushDb();
//            // 更新所有用户的缓存
//            List<User> allUsers = userService.getAllUsersWithRoles();
//            redisUtil.set("allUsers", allUsers);
//
//
//            return ResponseEntity.ok(response);
//        } else {
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
//        }
//    }

    /* 用于测试更新时前端传到后端的数据格式 */
//    @PostMapping("/saveOrUpdateUser")
//    public ResponseEntity<Map<String, Object>> saveOrUpdateUser(@RequestBody User user) {
//        ObjectMapper objectMapper = new ObjectMapper();
//        try {
//            String userJson = objectMapper.writeValueAsString(user);
//            System.out.println(userJson); // 这里打印出 JSON 字符串
//            // 或者你可以将 JSON 字符串放入一个 Map 中返回
//            Map<String, Object> responseMap = new HashMap<>();
//            responseMap.put("user", userJson);
//            return ResponseEntity.ok(responseMap);
//        } catch (JsonProcessingException e) {
//            e.printStackTrace();
//            return ResponseEntity.status(500).build();
//        }
//    }


    /**
     * 删除用户 根据id
     *
     * @param id 用户id
     * @return
     */
    @DeleteMapping("/removeById/{id}")
    public R removeById(@PathVariable Serializable id) {
        System.out.println("Received ID: " + id);
        Boolean fag = userService.removeById(id);
        if (fag) {
            return R.ok("用户删除成功！");
        } else {
            return R.failed("用户删除失败！");
        }
    }
}
