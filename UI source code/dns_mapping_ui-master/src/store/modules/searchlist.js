import { getsearchList, getleftList, getmapList } from '../../api/search'

const state = {
  list: [], // 搜索列表
  size: 10, // 每页多少条数据
  page: 1, // 当前第几页
  pages: 1, // 一共多少页
  resultTotal: 6, // 共多少条数据，分页
  left: [], // 左侧列表
  maplist: [],
  Loging:true,
}

const mutations = {
  changeList(state, arr) {
    state.list = arr
    console.log(state.list, 222)
  },
  changeLoging(state,loging){
    state.Loging = loging
    // console.log(state.Loging,111);
  },
  // 改变右侧列表
  changeLeft(state, left) {
    state.left = left
    // console.log(state.left, 333)
  },
  // 地图
  changeMaplist(state, map) {
    state.maplist = map
    // console.log(state.maplist, 444)
  },
  // 改变页数
  changePage(state, page) {
    state.page = page
  },
  // 改变每页请求条数
  changeSize(state, size) {
    state.size = size
  }
}

const actions = {
  listActions(context, obj) {

    const params = {
      ip: obj.ip ? obj.ip :"",
      port: obj.port ? obj.port : "",
      service: obj.service ? obj.service : "",
      size: state.size,
      page: state.page
    }
    getsearchList(params).then(res => {
      // console.log(params,555);
      if (res.status === 200) {
        if ((res.data.list === null || res.data.list.length === 0) && state.page > 1) {
          // console.log(456);
          const page = state.page - 1
          context.commit('changePage', page)
          context.dispatch('listActions')
          return
        }
        // console.log(res,"res");
        context.commit('changeList', res.data)
        context.commit('changeLoging',false)
      }
    }).catch(() => console.log('列表请求未执行'))
  },
  // 左侧列表请求
  leftlistActions(context, obj) {
    const params = {
      ip: obj.ip,
      port: obj.port,
      service: obj.service
    }
    // console.log(params);
    getleftList(params).then(res => {
      if (res.status === 200) {
        context.commit('changeLeft', res.data)
      }
    }).catch(() => console.log('左侧列表请求未执行'))
  },
  // 地图请求
  maplistActions(context) {
    getmapList().then(res => {
      // console.log(res.data);
      if (res.status === 200) {
        context.commit('changeMaplist', res.data)
      }
    }).catch(() => console.log('地图请求未执行'))
  },
  // 修改当前页码数
  pageActions(context, page) {
    context.commit('changePage', page)
  },
  // 修改每页请求条数
  sizeActions(context, size) {
    context.commit('changeSize', size)
  }
}
// 派生状态
const getters = {
  // 系统自动注入参数state
  list(state) {
    return state.list
  },
  left(state) {
    return state.left
  },
  maplist(state) {
    return state.maplist
  },
  size(state) {
    return state.size
  },
  total(state) {
    return state.resultTotal
  },
  Loging(state){
    return state.Loging
  }
}

// 导出
export default {
  state,
  mutations,
  actions,
  getters,
  namespaced: true// 使用命名空间
}
