export const clickoutside = {
  // 初始化指令
  bind(el, binding, vnode) {
    function documentHandler(e) {
      //这里面执行的是objec ip的代码，需要修改提前说一下
      if (binding.expression == "inputHide") {
        if (el.parentNode.parentNode.parentNode.contains(e.target.form)) {
          return false;
        }
        // // 这里判断点击的元素是否是本身，是本身，则返回
      } else if (el.contains(e.target)) {
        return false;
      }
      // // 这里判断点击的元素是否是本身，是本身，则返回
      // console.log(el.parentNode.parentNode.parentNode.contains(e.target.form),'form');
      // // console.log(el.parentNode.parentNode.parentNode,'父亲');
      // console.log(binding,'本身');

      // if (el.contains(e.target)) {

      //     return false;
      // }
      // 判断指令中是否绑定了函数

      if (binding.expression) {
        // 如果绑定了函数 则调用那个函数，此处binding.value就是handleClose方法
        if (binding.arg) {
          if (typeof binding.arg == 'object') {
            binding.value(binding.arg);
          } else {
            binding.value(e, binding.arg);
          }
        } else {

          binding.value(e);
        }

      }
    }
    // 给当前元素绑定个私有变量，方便在unbind中可以解除事件监听
    el.__vueClickOutside__ = documentHandler;
    document.addEventListener('click', documentHandler);
  },
  unbind(el, binding) {

    // 解除事件监听
    document.removeEventListener('click', el.__vueClickOutside__);
    delete el.__vueClickOutside__;
  },
};
