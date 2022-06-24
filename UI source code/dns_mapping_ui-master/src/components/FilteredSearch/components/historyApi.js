import remove from 'lodash/remove'
import Moment from 'moment'
/* 配置文件 */
import vue from '@/main.js'
import isEqual from 'lodash/isEqual'

//时间的历史纪录
class searchHistory {
  constructor(key = 'searchHistory', maxLength = 10) {
    this.key = key
    this.maxLength = maxLength
    if (!this.getHistory()) {
      localStorage.setItem(this.key, '{}');
    }
  }

  getSaveKey() {
    //暂时 不这么写
    //获取  页面对应的关键字  , 因为页签的问题, 一个页面 可能出现两个搜索框的问题 ....
    var route = vue.$route.path;
    return route
  }

  getHistory() {
    var historyList = JSON.parse(localStorage.getItem(this.key))
    return historyList
  }

  getPageHistory(saveKey) {  //获取当前页的搜索数据...
    var route = saveKey || vue.$route.path;
    var historyMap = JSON.parse(localStorage.getItem(this.key)) || {}
    return historyMap[route] || []
  }

  setHistory(val) {
    localStorage.setItem(this.key, JSON.stringify(val));
  }

  addItem(item, saveKey) {
    // var route = vue.$route.name
    var route = saveKey || vue.$route.path;        //fullPath path name(使用name最好,就是需要改 )
    var historyMap = JSON.parse(localStorage.getItem(this.key)) || {};
    if (!historyMap[route]) {
      historyMap[route] = []
    }

    //删除 重复的搜索历史记录
    var itemObj = {}
    item.forEach((obj) => {
      itemObj[obj.name] = obj.value
    });
    historyMap[route] = historyMap[route].filter((historyList, index) => {
      var historyItemObj = {};
      historyList.forEach((item) => {
        historyItemObj[item.name] = item.value
      });
      return !isEqual(itemObj, historyItemObj);
    });


    // historyMap[route].push(item);
    historyMap[route].unshift(item);

    if (historyMap[route].length > this.maxLength) {
      historyMap[route].pop()
    }
    var info = JSON.stringify(historyMap)
    localStorage.setItem(this.key, info);
  }

  clearPageHistory(saveKey) {
    //清除当前 页的搜索数据...
    var route = saveKey || vue.$route.path;        //fullPath path name(使用name最好,就是需要改 )
    var historyMap = JSON.parse(localStorage.getItem(this.key) || '{}');
    historyMap[route] = []
    var info = JSON.stringify(historyMap)
    localStorage.setItem(this.key, info);
  }

  clear() {
    localStorage.setItem(this.key, '{}');
  }
}

var history = new searchHistory();
export default history
