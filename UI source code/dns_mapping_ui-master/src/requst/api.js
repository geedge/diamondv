import { get } from './http'

export const getsearchList = (params) => get('http://192.168.32.6:8888/dns', params)// 搜索列表
