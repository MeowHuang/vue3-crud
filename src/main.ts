import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

/*动态注册 Element Plus 图标组件的 Vue 应用程序代码*/
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
const app = createApp(App)
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
}

createApp(App).use(store).use(router).mount('#app')

