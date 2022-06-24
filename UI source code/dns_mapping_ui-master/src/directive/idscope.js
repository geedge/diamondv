import app from '../main.js'

//异步写法  暂时不用
export async function getParentAsync(context, componentPath = '') {
  await app.$nextTick(() => {

  }, 10)
  return getParent(context, componentPath = '')
}


export function getParent(context, componentPath = '') {
  var currentIndex = null;
  var currentName = null
  !context ? context = this : ''
  //获取父级节点
  var parent = context && context.$parent || null;
  var siblings = (parent && parent.$children) || [];

  currentIndex = siblings.findIndex((item, index) => {
    return item._uid === context._uid
  });
  currentName = context.$options.name || 'anonymousComponent'

  // var currentPath = currentName + currentIndex  //加index,异步组件 会导致索引变化
  var currentPath = currentName

  componentPath = componentPath ? componentPath + '_' + currentPath : currentPath
  if (parent) {
    return getParent(parent, componentPath)
  }
  return componentPath
}

export const idscope = {
  bind: function (el, binding, vnode) {
    var context = vnode.context;
    var id = el.getAttribute('id') || null;
    // 同步写法
    var prefix = getParent(context);
    if (id) {
      var scopedId = id + '-_' + prefix;
      el.setAttribute('id', scopedId)

    }

    //异步写法
    // getParentAsync(context).then((prefix) => {
    //   if (id) {
    //     var scopedId = id + '-_' + prefix;
    //     el.setAttribute('id', scopedId)
    //   }
    // });
  }
}



