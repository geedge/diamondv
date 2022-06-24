/* 不能导入导出 global 是不支持document的 */

export default function getTxt1CursorPosition(dom,document){
  var oTxt1 =dom
  var cursurPosition=-1;
  if(oTxt1.selectionStart || oTxt1.selectionStart===0){//非IE浏览器
    cursurPosition= oTxt1.selectionStart;
  }else{//IE
    var range = document.selection.createRange();
    range.moveStart("character",-oTxt1.value.length);
    cursurPosition=range.text.length;
  }
 return cursurPosition
}
