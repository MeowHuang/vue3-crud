import axios from 'axios'
import serverConfig from './config'
// import { ElLoading, ElMessage } from 'element-plus'// 引入loading 
//使用axios下面的create([config])方法创建axios实例，其中config参数为axios最基本的配置信息。
const serviceRequest = axios.create({
	baseURL: serverConfig.baseURL, //请求后端数据的基本地址，自定义
	timeout: 200000,               //请求超时设置，单位ms
	withCredentials: true, // 异步请求携带cookie
	headers: {
		// 设置后端需要的传参类型
		'Content-Type': 'application/json',
		// 'token': '',
		'X-Requested-With': 'XMLHttpRequest',
	}
})
let loading: any;
function start() {
	// loading = ElLoading.service({
	// 	lock: true,
	// 	text: 'Loading',
	// 	background: 'rgba(0, 0, 0, 0.7)',
	// })
}
declare module 'axios' {
	interface AxiosInstance {
		(config: AxiosRequestConfig): Promise<any>
	}
}

// loading.close()
// 添加请求拦截器
serviceRequest.interceptors.request.use(
	// function (config:any) {
	// 	if(config.url!="/login"){
	// 		config.headers['access_token']=token
	// 	}
	// 	return config
	// },
	// function (error) {
	// 	// 对请求错误做些什么
	// 	return Promise.reject(error)
	// }
)
// 从localStorage中获取token
// let token = sessionStorage.getItem('token');

// 添加响应拦截器
serviceRequest.interceptors.response.use(
	// function (response) {
	// 	// 2xx 范围内的状态码都会触发该函数。
	// 	// 对响应数据做点什么
	// 	// dataAxios 是 axios 返回数据中的 data
	// 	// loading.close()
	// 	const dataAxios = response.data
	// 	if(dataAxios.data!=null){
	// 		if(dataAxios.data.access_token!=null){//说明从后台发送了一个token过来了
	// 			token=dataAxios.data.access_token
	// 			 // 保存token到sessionStorage
	// 			sessionStorage.setItem('token', dataAxios.data.access_token);
	// 		}
	// 	}
	// 	// 这个状态码是和后端约定的
	// 	const code = dataAxios.reset
	// 	return dataAxios
	// },
	// function (error) {
	// 	// 超出 2xx 范围的状态码都会触发该函数。
	// 	// 对响应错误做点什么
	// 	// loading.close()
	// 	if (error.config.url.indexOf('/api/file/list') == -1) {
	// 		// ElMessage.error(error.response.data.message)
	// 	}
	//
	// 	return Promise.reject(error)
	// }
)

//导出我们建立的axios实例模块，ES6 export用法
export default serviceRequest