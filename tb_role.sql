/*
 Navicat Premium Data Transfer

 Source Server         : ssm
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : demo

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 24/10/2023 01:54:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_role`;
CREATE TABLE `tb_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_role
-- ----------------------------
INSERT INTO `tb_role` VALUES (1, '管理员');
INSERT INTO `tb_role` VALUES (2, '教师');
INSERT INTO `tb_role` VALUES (3, '学生');
INSERT INTO `tb_role` VALUES (4, '评估员');

-- ----------------------------
-- Table structure for tb_role_authority
-- ----------------------------
DROP TABLE IF EXISTS `tb_role_authority`;
CREATE TABLE `tb_role_authority`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NULL DEFAULT NULL,
  `authority_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `authority_id`(`authority_id`) USING BTREE,
  CONSTRAINT `tb_role_authority_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tb_role_authority_ibfk_2` FOREIGN KEY (`authority_id`) REFERENCES `tb_authority` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_role_authority
-- ----------------------------
INSERT INTO `tb_role_authority` VALUES (1, 1, 1);
INSERT INTO `tb_role_authority` VALUES (2, 1, 2);
INSERT INTO `tb_role_authority` VALUES (3, 1, 3);
INSERT INTO `tb_role_authority` VALUES (4, 1, 4);
INSERT INTO `tb_role_authority` VALUES (5, 1, 5);
INSERT INTO `tb_role_authority` VALUES (6, 2, 4);
INSERT INTO `tb_role_authority` VALUES (7, 2, 6);
INSERT INTO `tb_role_authority` VALUES (8, 3, 4);
INSERT INTO `tb_role_authority` VALUES (9, 4, 4);
INSERT INTO `tb_role_authority` VALUES (10, 4, 5);

-- ----------------------------
-- Table structure for tb_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_role`;
CREATE TABLE `tb_user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  CONSTRAINT `tb_user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tb_user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_role
-- ----------------------------
INSERT INTO `tb_user_role` VALUES (1, 1, 1);
INSERT INTO `tb_user_role` VALUES (2, 2, 1);
INSERT INTO `tb_user_role` VALUES (3, 3, 4);
INSERT INTO `tb_user_role` VALUES (4, 4, 4);
INSERT INTO `tb_user_role` VALUES (5, 5, 3);
INSERT INTO `tb_user_role` VALUES (6, 6, 3);
INSERT INTO `tb_user_role` VALUES (7, 7, 3);
INSERT INTO `tb_user_role` VALUES (8, 8, 3);
INSERT INTO `tb_user_role` VALUES (9, 9, 3);
INSERT INTO `tb_user_role` VALUES (10, 10, 3);
INSERT INTO `tb_user_role` VALUES (11, 11, 3);
INSERT INTO `tb_user_role` VALUES (12, 12, 3);
INSERT INTO `tb_user_role` VALUES (13, 13, 3);
INSERT INTO `tb_user_role` VALUES (14, 14, 3);
INSERT INTO `tb_user_role` VALUES (15, 15, 3);
INSERT INTO `tb_user_role` VALUES (16, 16, 3);
INSERT INTO `tb_user_role` VALUES (17, 17, 3);
INSERT INTO `tb_user_role` VALUES (18, 18, 3);
INSERT INTO `tb_user_role` VALUES (19, 19, 3);
INSERT INTO `tb_user_role` VALUES (20, 20, 3);
INSERT INTO `tb_user_role` VALUES (21, 21, 3);
INSERT INTO `tb_user_role` VALUES (22, 22, 3);
INSERT INTO `tb_user_role` VALUES (23, 23, 3);
INSERT INTO `tb_user_role` VALUES (24, 24, 3);
INSERT INTO `tb_user_role` VALUES (25, 25, 3);
INSERT INTO `tb_user_role` VALUES (26, 26, 3);
INSERT INTO `tb_user_role` VALUES (27, 27, 3);
INSERT INTO `tb_user_role` VALUES (28, 28, 3);
INSERT INTO `tb_user_role` VALUES (29, 29, 3);
INSERT INTO `tb_user_role` VALUES (30, 30, 3);
INSERT INTO `tb_user_role` VALUES (31, 31, 3);
INSERT INTO `tb_user_role` VALUES (32, 32, 3);
INSERT INTO `tb_user_role` VALUES (33, 33, 3);
INSERT INTO `tb_user_role` VALUES (34, 34, 3);
INSERT INTO `tb_user_role` VALUES (35, 35, 3);
INSERT INTO `tb_user_role` VALUES (36, 36, 3);
INSERT INTO `tb_user_role` VALUES (37, 37, 3);
INSERT INTO `tb_user_role` VALUES (38, 38, 3);
INSERT INTO `tb_user_role` VALUES (39, 39, 2);
INSERT INTO `tb_user_role` VALUES (40, 40, 2);
INSERT INTO `tb_user_role` VALUES (41, 41, 3);
INSERT INTO `tb_user_role` VALUES (42, 42, 3);
INSERT INTO `tb_user_role` VALUES (43, 43, 3);
INSERT INTO `tb_user_role` VALUES (44, 44, 3);
INSERT INTO `tb_user_role` VALUES (45, 45, 3);
INSERT INTO `tb_user_role` VALUES (46, 46, 3);
INSERT INTO `tb_user_role` VALUES (47, 47, 3);
INSERT INTO `tb_user_role` VALUES (48, 48, 3);
INSERT INTO `tb_user_role` VALUES (49, 49, 3);
INSERT INTO `tb_user_role` VALUES (50, 50, 3);
INSERT INTO `tb_user_role` VALUES (51, 51, 3);
INSERT INTO `tb_user_role` VALUES (52, 52, 3);
INSERT INTO `tb_user_role` VALUES (53, 53, 3);
INSERT INTO `tb_user_role` VALUES (54, 54, 3);
INSERT INTO `tb_user_role` VALUES (55, 55, 3);
INSERT INTO `tb_user_role` VALUES (56, 56, 3);
INSERT INTO `tb_user_role` VALUES (57, 57, 3);
INSERT INTO `tb_user_role` VALUES (58, 58, 3);
INSERT INTO `tb_user_role` VALUES (59, 59, 3);
INSERT INTO `tb_user_role` VALUES (60, 60, 3);
INSERT INTO `tb_user_role` VALUES (61, 61, 3);
INSERT INTO `tb_user_role` VALUES (62, 62, 3);
INSERT INTO `tb_user_role` VALUES (63, 63, 3);
INSERT INTO `tb_user_role` VALUES (64, 64, 3);
INSERT INTO `tb_user_role` VALUES (65, 65, 3);
INSERT INTO `tb_user_role` VALUES (66, 66, 3);
INSERT INTO `tb_user_role` VALUES (67, 67, 3);
INSERT INTO `tb_user_role` VALUES (68, 68, 3);
INSERT INTO `tb_user_role` VALUES (69, 69, 3);
INSERT INTO `tb_user_role` VALUES (70, 70, 3);
INSERT INTO `tb_user_role` VALUES (71, 71, 3);
INSERT INTO `tb_user_role` VALUES (72, 72, 3);
INSERT INTO `tb_user_role` VALUES (73, 73, 3);
INSERT INTO `tb_user_role` VALUES (74, 74, 3);
INSERT INTO `tb_user_role` VALUES (75, 75, 3);
INSERT INTO `tb_user_role` VALUES (76, 76, 3);
INSERT INTO `tb_user_role` VALUES (77, 77, 3);
INSERT INTO `tb_user_role` VALUES (78, 78, 2);
INSERT INTO `tb_user_role` VALUES (79, 79, 3);
INSERT INTO `tb_user_role` VALUES (80, 80, 3);
INSERT INTO `tb_user_role` VALUES (81, 81, 3);
INSERT INTO `tb_user_role` VALUES (82, 82, 3);
INSERT INTO `tb_user_role` VALUES (83, 83, 1);
INSERT INTO `tb_user_role` VALUES (84, 84, 2);
INSERT INTO `tb_user_role` VALUES (85, 85, 2);
INSERT INTO `tb_user_role` VALUES (86, 86, 3);
INSERT INTO `tb_user_role` VALUES (87, 87, 3);
INSERT INTO `tb_user_role` VALUES (88, 88, 3);
INSERT INTO `tb_user_role` VALUES (89, 89, 3);
INSERT INTO `tb_user_role` VALUES (90, 90, 3);
INSERT INTO `tb_user_role` VALUES (91, 91, 3);
INSERT INTO `tb_user_role` VALUES (92, 92, 3);
INSERT INTO `tb_user_role` VALUES (93, 93, 3);
INSERT INTO `tb_user_role` VALUES (94, 94, 3);
INSERT INTO `tb_user_role` VALUES (95, 95, 3);
INSERT INTO `tb_user_role` VALUES (96, 96, 3);
INSERT INTO `tb_user_role` VALUES (97, 97, 3);
INSERT INTO `tb_user_role` VALUES (98, 98, 3);
INSERT INTO `tb_user_role` VALUES (99, 99, 3);
INSERT INTO `tb_user_role` VALUES (100, 100, 3);
INSERT INTO `tb_user_role` VALUES (101, 101, 3);
INSERT INTO `tb_user_role` VALUES (102, 102, 3);
INSERT INTO `tb_user_role` VALUES (103, 103, 3);

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (1, 'user', '2356325488@gmail.com', '1386358945', '在职', '湖北省武汉市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (2, '小羊', '3254879652@gmail.com', '1398745632', '在职', '上海市黄浦区', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (3, 'Linda', '9856321475@gmail.com', '1365987412', '离职', '北京市朝阳区', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (4, 'Bob', '3256987412@gmail.com', '1387412596', '在职', '广东省深圳市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (5, 'Alice', '9874521368@gmail.com', '1358745962', '在职', '浙江省杭州市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (6, 'John', 'john@example.com', '1234567890', '在职', '加利福尼亚', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (7, 'Emily', 'emily@example.com', '2345678901', '离职', '纽约', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (8, 'Michael', 'michael@example.com', '3456789012', '离职', '伦敦', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (9, 'Jessica', 'jessica@example.com', '4567890123', '在职', '巴黎', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (10, 'William', 'william@example.com', '5678901234', '在职', '东京', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (11, 'Daniel', 'daniel@example.com', '6789012345', '在职', '柏林', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (12, 'Sophia', 'sophia@example.com', '7890123456', '在职', '罗马', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (13, 'James', 'james@example.com', '8901234567', '离职', '马德里', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (14, 'Olivia', 'olivia@example.com', '9012345678', '在职', '莫斯科', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (15, 'Alexander', 'alexander@example.com', '0123456789', '在职', '北京', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (16, 'Mia', 'mia@example.com', '1234567890', '在职', '东京', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (17, 'William', 'william@example.com', '2345678901', '在职', '纽约', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (18, 'Ava', 'ava@example.com', '3456789012', '离职', '伦敦', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (19, 'Benjamin', 'benjamin@example.com', '4567890123', '在职', '巴黎', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (20, 'Amelia', 'amelia@example.com', '5678901234', '在职', '柏林', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (21, 'Oliver', 'oliver@example.com', '6789012345', '在职', '莫斯科', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (22, 'Sophia', 'sophia@example.com', '7890123456', '在职', '东京', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (23, 'Lucas', 'lucas@example.com', '8901234567', '离职', '柏林', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (24, 'Isabella', 'isabella@example.com', '9012345678', '在职', '伦敦', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (25, 'Henry', 'henry@example.com', '1234567809', '在职', '纽约', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (26, 'Alexander', 'alexander@example.com', '2345678901', '在职', '巴黎', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (27, 'Mia', 'mia@example.com', '3456789012', '在职', '米兰', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (28, 'Michael', 'michael@example.com', '4567890123', '离职', '华盛顿', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (29, 'Aria', 'aria@example.com', '5678901234', '在职', '洛杉矶', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (30, 'Benjamin', 'benjamin@example.com', '6789012345', '在职', '首尔', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (31, '王丽', 'wangli@example.com', '18712347890', '在职', '山东省青岛市', '2023-10-23 00:38:30', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (32, '李明', 'liming@example.com', '18712347891', '离职', '北京市海淀区', '2023-10-23 00:38:30', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (33, '张伟', 'zhangwei@example.com', '18712347892', '在职', '上海市徐汇区', '2023-10-23 00:38:30', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (34, '赵芳', 'zhaofang@example.com', '18712347893', '在职', '广东省深圳市', '2023-10-23 00:38:30', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (35, '陈红', 'chenhong@example.com', '18712347894', '离职', '江苏省南京市', '2023-10-23 00:38:30', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (36, '刘敏', 'liumin@example.com', '18712347895', '在职', '浙江省杭州市', '2023-10-23 00:38:30', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (37, '周静', 'zhoujing@example.com', '18712347896', '在职', '四川省成都市', '2023-10-23 00:38:30', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (38, '吴强', 'wuqiang@example.com', '18712347897', '离职', '重庆市渝中区', '2023-10-23 00:38:30', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (39, '张三', 'zhangsan@example.com', '13812345678', '在职', '北京', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (40, '李四', 'lisi@example.com', '13912345678', '在职', '上海', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (41, '王五', 'wangwu@example.com', '13612345678', '在职', '广州', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (42, '赵六', 'zhaoliu@example.com', '13712345678', '离职', '深圳', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (43, '钱七', 'qianqi@example.com', '13512345678', '在职', '成都', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (44, '陈八', 'chenba@example.com', '13812345679', '在职', '重庆', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (45, '杨九', 'yangjiu@example.com', '13912345679', '在职', '湖北省武汉市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (46, '周十', 'zhoushi@example.com', '13612345679', '在职', '南京', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (47, '吴十一', 'wushiyi@example.com', '13712345679', '离职', '天津', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (48, '郑十二', 'zhengshier@example.com', '13512345679', '在职', '西安', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (49, '王十三', 'wangshisan@example.com', '13812345680', '在职', '杭州', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (50, '赵十四', 'zhaoshisi@example.com', '13912345680', '在职', '苏州', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (51, '孙十五', 'sunshiwu@example.com', '13612345680', '在职', '郑州', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (52, '李十六', 'lishiliu@example.com', '13712345680', '离职', '青岛', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (53, '周十七', 'zhoushiquan@example.com', '13512345680', '在职', '厦门', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (54, '吴十八', 'wushiba@example.com', '13812345681', '在职', '福州', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (55, '郑十九', 'zhengshijiu@example.com', '13912345681', '在职', '长沙', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (56, '孙二十', 'sunshier@example.com', '13612345681', '在职', '南昌', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (57, '李二十一', 'lierer@example.com', '13712345681', '离职', '太原', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (58, '张二十二', 'zhangershier@example.com', '13512345681', '在职', '沈阳', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (59, '王二十三', 'wangersanshi@example.com', '13812345682', '在职', '长春', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (60, '赵二十四', 'zhaosishisi@example.com', '13912345682', '在职', '哈尔滨', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (61, '孙二十五', 'sunersiwu@example.com', '13612345682', '在职', '乌鲁木齐', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (62, '李二十六', 'lierliu@example.com', '13712345682', '离职', '拉萨', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (63, '张二十七', 'zhangershichu@example.com', '13512345682', '在职', '台北', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (64, '刘二十八', 'liuerba@example.com', '13812345683', '在职', '香港', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (65, '陈二十九', 'chenshiyao@example.com', '13912345683', '在职', '澳门', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (66, '杨三十', 'yangshisan@example.com', '13612345683', '在职', '台中', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (67, '周三十一', 'zhoushiyi@example.com', '13712345683', '离职', '高雄', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (68, '吴三十二', 'wusanshi@example.com', '13512345683', '在职', '基隆', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (69, '郑三十三', 'zhengshisan@example.com', '13812345684', '在职', '台南', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (70, '王三十四', 'wangshisi@example.com', '13912345684', '在职', '新竹', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (71, '赵三十五', 'zhaosiwu@example.com', '13612345684', '在职', '嘉义', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (72, '孙三十六', 'sunshiliu@example.com', '13712345684', '离职', '桃园', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (73, '李三十七', 'lishiqi@example.com', '13512345684', '在职', '屏东', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (74, '周三十八', 'zhoushiba@example.com', '13812345685', '在职', '花莲', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (75, '吴三十九', 'wushijiu@example.com', '13912345685', '在职', '宜兰', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (76, '郑四十', 'zhengshisi@example.com', '13612345685', '在职', '彰化', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (77, '孙四十一', 'sunshiyi@example.com', '13712345685', '离职', '云林', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (78, '李四十二', 'lishier@example.com', '13512345685', '在职', '苗栗', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (79, '张四十三', 'zhangshisan@example.com', '13812345686', '在职', '金门', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (80, '王四十四', 'wangsishi@example.com', '13912345686', '在职', '澎湖', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (81, '赵四十五', 'zhaosiwushi@example.com', '13612345686', '在职', '连江', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (82, '孙四十六', 'sunsanliu@example.com', '13712345686', '离职', '云南省昆明市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (83, '李四十七', 'lishiqiba@example.com', '13512345686', '在职', '湖北省随州市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (84, '张三', 'zhangsan@example.com', '13812345678', '在职', '天津', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (85, '李四', 'lisi@example.com', '13987654321', '在职', '上海市浦东区', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (86, '王五', 'wangwu@example.com', '15898765432', '离职', '广东省深圳市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (87, '赵六', 'zhaoliu@example.com', '18612349876', '在职', '江苏省南京市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (88, '小明', 'xiaoming@example.com', '15678904321', '在职', '浙江省杭州市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (89, '小红', 'xiaohong@example.com', '18765431234', '离职', '湖北省武汉市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (90, '李华', 'lihua@example.com', '13578906543', '在职', '四川省成都市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (91, '王芳', 'wangfang@example.com', '18712347890', '在职', '山东省青岛市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (92, '张敏', 'zhangmin@example.com', '18234569870', '离职', '河南省郑州市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (93, '李雷', 'lilei@example.com', '13398762345', '在职', '湖南省长沙市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (94, '王强', 'wangqiang@example.com', '13476548923', '在职', '陕西省西安市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (95, '赵虎', 'zhaohu@example.com', '15698234760', '离职', '重庆市渝中区', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (96, '周霞', 'zhouxia@example.com', '18723456789', '在职', '江西省南昌市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (97, '孙风', 'sunfeng@example.com', '13587659876', '在职', '山西省太原市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (98, '吴亮', 'wuliang@example.com', '13956879043', '离职', '广西壮族自治区南宁市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (99, '郑晓', 'zhengxiao@example.com', '15623458976', '在职', '云南省昆明市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (100, '冯明', 'fengming@example.com', '13867903456', '在职', '贵州省贵阳市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (101, '陈芳', 'chenfang@example.com', '18712345678', '离职', '甘肃省兰州市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (102, '朱燕', 'zhuyan@example.com', '15923456789', '在职', '青海省西宁市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (103, '林岚', 'linlan@example.com', '13298765432', '在职', '新疆维吾尔自治区乌鲁木齐市', '2023-10-23 00:13:52', '2023-10-23 22:48:28');
INSERT INTO `tb_user` VALUES (104, '小号', 'xiaohao@163.com', '1564569998', '离职', '江苏苏州市', '2023-10-23 12:59:56', '2023-10-23 22:48:28');

SET FOREIGN_KEY_CHECKS = 1;
