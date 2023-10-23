import serviceRequest from '../httpServer'

/**
 * 查询所有用户 不分页
 */
export const getAllUsers=(param:any)=>{
    return serviceRequest({
        url:"/user/queryAll",
        method:"get",
        data:param
    })
}

/**
 * 分页查询所有用户
 *
 * @param map 集合
 * @return 返回code msg data(pageNo,pageSize)
 */
export const queryAllByPage=(param:any)=>{
    return serviceRequest({
        url:"/user/queryAllByPage",
        method:"post",
        data:param
    })
}
/**
 * 分页模糊查询
 * @param param
 */
export const getByKeywordAndPage=(param:any)=>{
    return serviceRequest({
        url:"/user/queryByKeywordAndPage",
        method:"post",
        data:param
    })
}

/**
 * 执行插入或者更新操作 有id则更新，无id则插入
 *
 * @param user
 * @return 返回data{message,user} status statusText headers config
 * @response
 */
export const saveOrUpdateUser=(param:any)=>{
    return serviceRequest({
        url:"/user/saveOrUpdate",
        method:"post",
        data:param
    })
}

/**
 * 删除用户 根据id
 *
 * @param id 用户id
 * @return
 */
export const removeUserById=(param:any)=>{
    return serviceRequest({
        url:"/user/removeById/"+param,
        method:"delete",
        data:param
    })
}


