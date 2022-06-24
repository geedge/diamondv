export function fireKeyEvent(el, evtType, keyCode) {
  var evtObj;
  if (document.createEvent) {
    if (window.KeyEvent) {//firefox 浏览器下模拟事件
      evtObj = document.createEvent('KeyEvents');
      evtObj.initKeyEvent(evtType, true, true, window, true, false, false, false, keyCode, 0);
    } else {//chrome 浏览器下模拟事件
      evtObj = document.createEvent('UIEvents');
      evtObj.initUIEvent(evtType, true, true, window, 1);

      delete evtObj.keyCode;
      if (typeof evtObj.keyCode === "undefined") {//为了模拟keycode
        Object.defineProperty(evtObj, "keyCode", { value: keyCode });
      } else {
        evtObj.key = String.fromCharCode(keyCode);
      }

      if (typeof evtObj.ctrlKey === 'undefined') {//为了模拟ctrl键
        Object.defineProperty(evtObj, "ctrlKey", { value: true });
      } else {
        evtObj.ctrlKey = true;
      }
    }
    el.dispatchEvent(evtObj);

  } else if (document.createEventObject) {//IE 浏览器下模拟事件
    evtObj = document.createEventObject();
    evtObj.keyCode = keyCode
    el.fireEvent('on' + evtType, evtObj);
  }
}
