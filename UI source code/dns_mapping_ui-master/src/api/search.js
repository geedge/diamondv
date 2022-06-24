import request from '@/utils/request'

export function getsearchList(params) {
  return request({
    url: '/dns',
    method: 'get',
    params
  })
}

export function getleftList(params) {
  return request({
    url: '/dns/dataCount',
    method: 'get',
    params
  })
}

export function getmapList(params) {
  return request({
    url: '/dns/mapData',
    method: 'get',
    params
  })
}