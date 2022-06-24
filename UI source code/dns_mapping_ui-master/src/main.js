import Vue from 'vue'

import Cookies from 'js-cookie'

import 'normalize.css/normalize.css'

import Element from 'element-ui'
//
import mavonEditor from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'

import i18n from './lang'

// 数据字典
import dict from './components/Dict'

// 权限指令
import checkPer from '@/utils/permission'
import permission from './components/Permission'
import './assets/styles/element-variables.scss'
// global css
import './assets/styles/index.scss'

// 代码高亮
import VueHighlightJS from 'vue-highlightjs'
import 'highlight.js/styles/atom-one-dark.css'
// 引入echarts
import echarts from 'echarts'
Vue.prototype.$echarts = echarts
// 引入中国地图
import china from 'echarts/map/json/china.json'
echarts.registerMap('china', china)
// 引入世界地图
import '../node_modules/echarts/map/js/world'
// 引入axios
import axios from 'axios'
Vue.prototype.$axios = axios

import request from '../src/utils/request'
Vue.prototype.$login = request.login
Vue.prototype.$post = request.post
Vue.prototype.$get = request.get

import App from './App'
import store from './store'
import router from './router/routers'

import './assets/icons' // icon
import './router/index' // permission control
import 'echarts-gl'

Vue.use(checkPer)
Vue.use(VueHighlightJS)
Vue.use(mavonEditor)
Vue.use(permission)
Vue.use(dict)
Vue.use(Element, {
  size: Cookies.get('size') || 'small' // set element-ui default size
})

Vue.config.productionTip = false

Vue.use(Element, {
  size: Cookies.get('size') || 'medium', // set element-ui default size
  i18n: (key, value) => i18n.t(key, value)
})

new Vue({
  el: '#app',
  router,
  store,
  i18n,
  render: h => h(App)
})
