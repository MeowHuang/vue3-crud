import { createStore } from 'vuex'
import VuexAlong from 'vuex-along'

export default createStore({
  state: {
    user:{}
  },
  getters: {
    getUser(state) { return state.user },
  },
  mutations: {
    setUser(state, user) { state.user = user },
  },
  actions: {
    asyncUpdateUser(context, user) { context.commit("setUser", user); },
  },
  modules: {},
  plugins: [VuexAlong({	//此插件解决刷新初始state数据问题
    name: "along"
  })]
})
