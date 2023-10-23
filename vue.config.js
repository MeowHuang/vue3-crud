const {defineConfig} = require('@vue/cli-service')
module.exports = defineConfig({
    transpileDependencies: true,
})

const AutoImport = require('unplugin-auto-import/webpack');
const Components = require('unplugin-vue-components/webpack');
const {ElementPlusResolver} = require('unplugin-vue-components/resolvers');

module.exports = {
    publicPath: './',
    configureWebpack: {
        //配置webpack自动按需引入element-plus
        plugins: [
            AutoImport({
                resolvers: [ElementPlusResolver()]
            }),
            Components({
                resolvers: [ElementPlusResolver()]
            })
        ]
    },
    devServer: {
        port: 8090,
        proxy: {
            '/apis': {
                target: 'http://localhost:8080', //接口域名
                changeOrigin: true, //是否跨域
                ws: true, //是否代理 websockets
                secure: false, //是否https接口
                pathRewrite: { //路径重置
                    '^/apis': ''
                }
            }
        }
    }
};