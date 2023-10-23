<template>
  <h3>Hello Dear Admin</h3>
  <div class="table-box">
    <!--标题-->
    <div class="title">
      <h1>最简单的 CRUD Demo</h1>
    </div>
    <!--query查找框-->
    <div class="query-box">
      <div class="search-box">
        <el-input class="query-input" v-model="queryInput" @keydown.enter="toSearch" placeholder="请输入查询的内容🔍"/>
        <el-button type="primary" :icon="Search" @click="toSearch" style="margin-left: 10px">查询</el-button>
      </div>
      <div class="btn-list">
        <el-button type="success" :icon="Upload" @click="handleAdd">增加</el-button>
        <el-button type="danger" :icon="Delete" @click="handleDellist" v-if="multipleSelection.length>0">删除多选
        </el-button>
      </div>
    </div>
    <!--table-->
    <el-table ref="multipleTableRef"
              :data="tableData"
              style="width: 100%"
              @selection-change="handleSelectionChange"
              border
              max-height="450"
              stripe>

      <el-table-column type="selection" width="40"/>

      <el-table-column prop="id" label="ID" width="60"/>
      <el-table-column prop="name" label="姓名" width="100"/>
      <el-table-column prop="roleName" label="角色" width="100"/>
      <el-table-column prop="email" label="邮箱" width="210"/>
      <el-table-column prop="phone" label="电话" width="120"/>
      <el-table-column prop="state" label="状态" width="70"/>
      <el-table-column prop="address" label="城市" width="150"/>
      <el-table-column prop="createTime" label="创建时间" width="180" :formatter="formatCreateDate" />
      <el-table-column prop="updateTime" label="更新时间" width="180" :formatter="
      formatUpdateDate" />

      <el-table-column fixed="right" label="操作" width="120">
        <template #default="scope">
          <el-button link type="primary" size="small" @click="handleRoleDel(scope.row)" style="color: #F56C6C">删除
          </el-button>
          <el-button link type="primary" size="small" @click="handleEdit(scope.row)">编辑</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!--分页-->
    <div class="demo-pagination-block">
      <div class="pagin-box">
        <el-pagination
            v-model:current-page="currentPage"
            v-model:page-size="pageSize"
            :page-sizes="[5, 10, 15, 20, 50, 100, 200, 500, 1000]"
            :small="false"
            :disabled="disabled"
            :background="true"
            layout="total, sizes, prev, pager, next, jumper"
            :total="totalPage"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
        />
      </div>
    </div>

    <!--Dialog弹窗-->
    <el-dialog v-model="dialogFormVisible" :title="dialogType==='add'?'新增':'编辑'"
               style="width:600px;border-radius: 15px">
      <el-form :model="tableForm">
        <el-form-item label="姓名" :label-width="70">
          <el-input v-model="tableForm.name" autocomplete="off"/>
        </el-form-item>
        <el-form-item label="角色" :label-width="70">
          <el-input v-model="tableForm.roleName" autocomplete="off"/>
        </el-form-item>
        <el-form-item label="邮箱" :label-width="70">
          <el-input v-model="tableForm.email" autocomplete="off"/>
        </el-form-item>
        <el-form-item label="电话" :label-width="70">
          <el-input v-model="tableForm.phone" autocomplete="off"/>
        </el-form-item>
        <el-form-item label="状态" :label-width="70">
          <el-input v-model="tableForm.state" autocomplete="off"/>
        </el-form-item>
        <el-form-item label="地址" :label-width="70">
          <el-input v-model="tableForm.address" autocomplete="off"/>
        </el-form-item>

      </el-form>
      <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取消</el-button>
        <el-button type="primary" @click="dialogConfirm">
          确定
        </el-button>
      </span>
      </template>
    </el-dialog>

  </div>
</template>

<script setup>

  import {onMounted, ref} from "vue";
  import {useStore} from "vuex"
  import {Delete, Search, Upload} from '@element-plus/icons-vue'
  import {getByKeywordAndPage, queryAllByPage, removeUserById, saveOrUpdateUser} from "../http/apis/userApi"

  /* 数据 */
  let queryInput = ref("");
  let tableData = ref([
    {
      "id": "1",
      "name": "Tom",
      "email": "2356325488@gmail.com",
      "phone": "1386358945",
      "state": "在职",
      "address": "湖北省武汉市"
    },
    {
      "id": "2",
      "name": "Jerry",
      "email": "3254879652@gmail.com",
      "phone": "1398745632",
      "state": "在职",
      "address": "上海市黄浦区"
    },
    {
      "id": "3",
      "name": "Linda",
      "email": "9856321475@gmail.com",
      "phone": "1365987412",
      "state": "离职",
      "address": "北京市朝阳区"
    },
    {
      "id": "4",
      "name": "Bob",
      "email": "3256987412@gmail.com",
      "phone": "1387412596",
      "state": "在职",
      "address": "广东省深圳市"
    },
    {
      "id": "5",
      "name": "Alice",
      "email": "9874521368@gmail.com",
      "phone": "1358745962",
      "state": "在职",
      "address": "浙江省杭州市"
    }
  ]);

  let tableDataCopy = Object.assign(tableData) // 浅复制


  let multipleSelection = ref([]); // 多选框 => 用于存储表格的id(用户的ID)
  let dialogFormVisible = ref(false); // 弹窗表单是否可见
  let tableForm = ref({
    //name: "张三",
    //mail: "email.com",
    //phone: "152456336",
    //state: "在职",
    //address: "湖北省武汉市"
  }); // 弹窗表单 => JSON格式
  let dialogType = ref('add'); // 对话框的类型 => 'add'?'新增':'编辑'

  let pageSize = ref(15)	//一页的数据条数
  let currentPage = ref(1)	//当前页数
  let totalPage = ref()	//所有的数据条数

  onMounted(() => {
    ///* 获取所有用户信息 */
    //getAllUsers(null).then(res => {
    //  res.data.forEach((i, index) => {
    //    tableData.value = res.data;
    //    //console.log("后台获取到的数据：" + JSON.stringify(i))
    //  })
    //})
    handleCurrentChange(1); // 设置页面初始加载时从 第1页 开始显示数据
  })


  /* 方法 */
  const disabled = ref(false)
  const store = useStore()

  /**
   * 页面大小的更改
   */
  const handleSizeChange = (val) => {
    pageSize.value = val;
    handleCurrentChange(currentPage.value); // 重新加载当前页面数据
  }

  /**
   * 分页查询(看输入框中有无值选择queryAllByPage和getByKeywordAndPage函数
   * @param pageNo
   */
  const handleCurrentChange = (pageNo) =>
  {
    tableData.value.splice(0, tableData.value.length);
    if (queryInput.value == null) {
      queryAllByPage({"pageNo": pageNo, "pageSize": pageSize.value}).then(res => {
        if (res.data && res.data.data && res.data.data.list) {
          store.dispatch("asyncUpdateUser", res.data); // 将响应的数据发送到 store 以进行更新
          // 遍历数据
          res.data.data.list.forEach((item, index) => {
            tableData.value.push(item);
            //console.log("后台获取到的数据：" + JSON.stringify(item));
          });
        } else {
          console.error("数据结构不正确或缺失必要的属性");
        }
        totalPage.value = res.data.data.total
      });
    } else {
      getByKeywordAndPage({"attributes": queryInput.value, "pageNo": pageNo, "pageSize": pageSize.value}).then(res => {
        if (res.data && res.data.data && res.data.data.list) {
          store.dispatch("asyncUpdateUser", res.data); // 将响应的数据发送到 store 以进行更新
          // 遍历数据
          res.data.data.list.forEach((item, index) => {
            tableData.value.push(item);
            //console.log("模糊分页查询后台获取到的数据：" + JSON.stringify(item));
          });
        } else {
          console.error("数据结构不正确或缺失必要的属性");
        }
        totalPage.value = res.data.data.total
      });
    }

  };

  /**
   * 查询
   */
  /* 第一类：前端单机查询 */
  //const queryName = (val) => {
  //  //console.log(queryInput.value) // 得到的是输入框的值
  //  //console.log(val) // 得到的是输入框的值
  //  if (val.length > 0) {
  //    tableData = tableDataCopy.value.filter(item => (item.name).toLowerCase().match(val))
  //  } else {
  //    tableData = tableDataCopy
  //  }
  //  console.log("浅复制" + JSON.stringify(tableDataCopy.value))
  //  console.log("表数据" + JSON.stringify(tableData))
  //}
  /* 第二类：后端分页模糊查询 */
  const toSearch = (event) => {
    event.preventDefault(); // 阻止默认的回车事件传播
    tableData.value.splice(0, tableData.value.length);
    getByKeywordAndPage({"attributes": queryInput.value, "pageNo": 1, "pageSize": pageSize.value}).then(res => {
      if (res.data && res.data.data && res.data.data.list) {
        store.dispatch("asyncUpdateUser", res.data); // 将响应的数据发送到 store 以进行更新
        // 遍历数据
        res.data.data.list.forEach((item, index) => {
          tableData.value.push(item);
          console.log("后台获取到的数据：" + JSON.stringify(item));
        });
      } else {
        console.error("数据结构不正确或缺失必要的属性");
      }
      totalPage.value = res.data.data.total
    });
  }

  /**
   * 格式日期
   * @param value
   * @returns {string}
   */
  const formatCreateDate = (data) => {
    if (!data || !data.createTime) return 'No date provided';
    try {
      const date = new Date(data.createTime);
      if (isNaN(date.getTime())) {
        console.error('Invalid Date string:', data.createTime);
        return 'Invalid Date Format';
      }
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const day = String(date.getDate()).padStart(2, '0');
      const hours = String(date.getHours()).padStart(2, '0');
      const minutes = String(date.getMinutes()).padStart(2, '0');
      const seconds = String(date.getSeconds()).padStart(2, '0');
      return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    } catch (error) {
      console.error('Error occurred while formatting date:', error);
      return 'Invalid Date Format';
    }
  };
   const formatUpdateDate = (data) => {
    if (!data || !data.updateTime) return 'No date provided';
    try {
      const date = new Date(data.updateTime);
      if (isNaN(date.getTime())) {
        console.error('Invalid Date string:', data.updateTime);
        return 'Invalid Date Format';
      }
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const day = String(date.getDate()).padStart(2, '0');
      const hours = String(date.getHours()).padStart(2, '0');
      const minutes = String(date.getMinutes()).padStart(2, '0');
      const seconds = String(date.getSeconds()).padStart(2, '0');
      return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    } catch (error) {
      console.error('Error occurred while formatting date:', error);
      return 'Invalid Date Format';
    }
  };






  /**
   * 编辑
   * @param row
   */
  const handleEdit = (row) => {
    // 1.打开弹窗
    dialogFormVisible.value = true
    // 2.更改弹窗属性
    dialogType.value = 'edit'
    // 3.将当前行的数据给到弹窗表单
    tableForm.value = {...row}
    console.log("弹出的表单" + JSON.stringify(tableForm.value))
  };

  //删除单行
  const handleRoleDel = (row) => {
    console.log("当前行的id为" + row.id)
    // 1.通过id获取条目对应的索引值
    let index = tableData.value.findIndex(item => item.id === row.id)
    console.log("当前行的索引为" + index)
    // 2.通过索引值进行删除对应条目
    tableData.value.splice(index, 1)
    // 3.后台同步删除数据
    removeUserById(row.id).then(res => {
      console.log("删除数据的res响应：" + JSON.stringify(res.data))
      if (res.status == 200) {
        ElMessage({
          showClose: true,
          message: '数据删除成功！',
          type: 'success',
        })
        console.log("数据删除成功！")
      } else {
        ElMessage({
          showClose: true,
          message: '数据新增失败！',
          type: 'error',
        })
        console.log("数据新增失败！")
      }
    })
  };

  //删除多选
  const handleDellist = () => {
    // 1.遍历多选框数组中的id值，调用单行删除函数'handleRoleDel'
    multipleSelection.value.forEach(id => {
      handleRoleDel({id})
    })
    // 2. 清空多选框数组
    multipleSelection.value = []
  };


  //多选框
  const handleSelectionChange = (val) => {
    //multipleSelection.value = val.id
    //console.log(val)

    // 1.清空多选框数组
    multipleSelection.value = []
    // 2.循环遍历将每行的id值存入多选框数组中
    val.forEach(item => {
      multipleSelection.value.push(item.id)
    })
    console.log("多选框中存入的行值：" + JSON.stringify(multipleSelection.value))

  };

  //新增
  const handleAdd = () => {
    dialogFormVisible.value = true //打开弹窗
    dialogType.value = 'add' //窗体名称为'编辑'
    tableForm.value = {} //弹窗表单清空
  };

  //确定(包括新增和编辑)
  const dialogConfirm = () => {

    /* 判断是新增还是编辑 */
    if (dialogType.value === 'add') {
      /* 执行新增操作 */
      if (!tableForm.value.name || !tableForm.value.email || !tableForm.value.phone) {
        ElMessage({
          showClose: true,
          message: '姓名|邮箱|电话不能为空！',
          type: 'error',
        })
        console.error("姓名|邮箱|电话不能为空！无法插入！")
        return
      }
      // 1.拿到数据
      // 2.添加到tableData中
      //tableData.value.push({
      //  //id: (tableData.value.length + 1).toString(),//单机版前端id值由表的下标+1
      //  ...tableForm.value
      //})
      console.log("新增操作下确定按下后的数据：" + JSON.stringify(tableForm.value))
      // 3.后端同步新增数据
      saveOrUpdateUser(tableForm.value).then(res => {
        if (res && res.data.user.id) {
          tableForm.value.id = res.data.user.id; // 由于弹窗表单tableForm没有id，所以从后台响应拿到id给到弹窗表单，再把弹窗表单push到表格中
          tableData.value.push(tableForm.value);
          ElMessage({
            showClose: true,
            message: '数据新增成功！',
            type: 'success',
          })
          console.log("数据新增成功！后端的res相应" + JSON.stringify({data: res.data, status: res.status}))
        } else {
          ElMessage({
            showClose: true,
            message: '数据新增失败！',
            type: 'error',
          })
          console.log("数据新增失败！")
        }
      })
      dialogFormVisible.value = false //关闭弹窗
    } else {
      /* 执行编辑操作 */
      // 1.获取当前这条索引
      let index = tableData.value.findIndex(item => item.id === tableForm.value.id)
      console.log("编辑操作下确定按下后的当前索引" + index)
      //// 2.将弹窗表单的数据替换给当前表格对应的索引值的数据(单机前端版)
      //tableData.value[index] = tableForm.value
      //console.log("编辑操作下确定按下后的表单值" + JSON.stringify(tableForm.value))


      // 2.将弹窗表单的数据替换给当前表格对应的索引值的数据
      tableData.value[index] = {...tableData.value[index], ...tableForm.value};
      console.log("编辑操作下确定按下后的表单值" + JSON.stringify(tableForm.value));
      // 3.后端同步更新数据
      saveOrUpdateUser(tableForm.value).then(res => {
        if (res) {
          ElMessage({
            showClose: true,
            message: '数据更新成功！',
            type: 'success',
          });
          console.log("数据更新成功！后端的res相应" + JSON.stringify(res));
        } else {
          ElMessage({
            showClose: true,
            message: '数据更新失败！',
            type: 'error',
          });
          console.log("数据更新失败！");
        }
      });
      dialogFormVisible.value = false; //关闭弹窗
    }
  };

</script>

<style scoped>
  .table-box {
    width: 1000px;
    position: relative;
    top: 10%;
    margin: 0 auto;
    transform: translate(-20% ，-50%);

  }

  .title {
    text-align: center;
  }

  .query-box {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
  }

  .query-input {
    width: 300px;
  }

  .demo-pagination-block + .demo-pagination-block {
    margin-top: 30px;
  }

  .demo-pagination-block .demonstration {
    margin-bottom: 16px;
  }

  .pagin-box {
    margin-top: 10px;
    margin-left: 10px;
  }
</style>


