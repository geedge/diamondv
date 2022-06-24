<template>
  <div class="dashboard-container">
    <div class="form_list">
      <div style="width: 100%; background-color: #fff">
        <div class="form_title">
          <div :class="tabshow == 1 ? 'active' : ''" @click="tab(1)">
            <i class="el-icon-date" />服务数据
          </div>
          <div :class="tabshow == 2 ? 'active' : ''" @click="tab(2)">
            <i class="el-icon-picture-outline" />网络数据
          </div>
          <div :class="tabshow == 3 ? 'active' : ''" @click="tab(3)">
            <i class="el-icon-notebook-2" />主机数据
          </div>
        </div>
        <div class="middle">
          <!-- 父盒子 -->
          <div class="father_box">
            <div class="sea_box" @click="onclick()">
              <div
                v-for="(item, index) in keyword"
                :key="index"
                ref="Tag"
                :class="index % 2 != 0 ? 'spanbox_value' : 'spanbox_key'"
              >
                <span v-if="Array.isArray(item)" class="tagspan">
                  <span v-for="(a,i) in item" :key="i">{{ a[a.length-1] }}</span>
                </span>
                <span v-else class="tagspan">{{ item }}</span>
                <i
                  v-if="index % 2 != 0"
                  class="span_close"
                  @click="removeTag(index, item)"
                />
              </div>
              <el-input
                v-if="type === 'input'"
                ref="inputTag"
                v-model="currentval"
                placeholder="请输入检索内容"
                :style="inputStyle"
                class="inputTag"
                type="text"
                @keydown.native="handleKeydown"
                @focus="searchFoucs"
              />
              <el-select
                v-else-if="type == 'select'"
                ref="inputTag"
                v-model="currentval"
                placeholder="请输入检索内容"
                :style="inputStyle"
                class="inputTag"
                type="text"
                filterable
                remote
                default-first-option
                @change="addTags"
                @keyup.native="handleKeydown"
                @focus="searchFoucs"
              >
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                  :disabled="item.disabled"
                />
              </el-select>

              <el-cascader
                v-else-if="type == 'more'"
                ref="inputTag"
                v-model="currentval"
                :options="options"
                :props="{ multiple: true, checkStrictly: true }"
                clearable
                :style="inputStyle"
                class="inputTag"
                type="text"
                filterable
                remote
                default-first-option
                @change="addTags"
                @keyup.native="handleKeydown"
                @focus="searchFoucs"
              />

              <el-select
                v-else
                ref="inputTag"
                v-model="currentval"
                placeholder="请输入检索内容"
                :style="inputStyle"
                class="inputTag"
                type="text"
                filterable
                remote
                default-first-option
                @change="addTags"
                @keyup.native="handleKeydown"
                @focus="searchFoucs"
              >
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                  :disabled="item.disabled"
                />
              </el-select>
            </div>
          </div>
          <!-- 搜索按钮 -->
          <el-row>
            <el-button
              type="primary"
              @click="search"
            >搜&nbsp;&nbsp;索</el-button>
          </el-row>
          <!-- </el-form> -->
          <div class="text">
            <p class="massage">
              共<i v-if="loging" class="el-icon-loading" />
              <span v-if="!loging">{{ list.resultTotal }}</span>条,含<i v-if="loging" class="el-icon-loading" />
              <span v-if="!loging">
                {{ handleIndependIpNum(list.independentIpNum) }}</span>

              个独立IP,<i v-if="loging" class="el-icon-loading" /><span
                v-if="!loging"
                class="second"
              >用时{{ list.totalTime }}秒</span>
            </p>
            <div class="switch">
              <el-switch v-model="value1" inactive-text="排除蜜罐" />
              <el-switch v-model="value2" inactive-text="数据去重" />
              <el-switch v-model="value3" inactive-text="排除CDN" />
              <el-switch v-model="value4" inactive-text="最新数据" />
            </div>
          </div>
        </div>
      </div>
      <div class="form_box">
        <!-- 内容 -->
        <div v-show="tabshow == 1">
          <Sreviceleft v-if="leftShow" v-loading.lock="loging" />
          <SreviceRight v-if="rightShow" v-loading.lock="loging" />
          <div class="clear" />
          <!-- 分页 -->
          <div class="block">
            <el-pagination
              v-if="pageShow"
              :page-sizes="[10, 20, 30, 40]"
              :page-size="size"
              layout="total, sizes, prev, pager, next, jumper"
              :total="list.resultTotal"
              @size-change="handleSizeChange"
              @current-change="curPage"
            />
          </div>
          <!-- <Foot /> -->
          <!-- <pagination/> -->
        </div>
        <div v-show="tabshow == 2" />
        <div v-show="tabshow == 3">3</div>
      </div>
    </div>
    <!-- 返回顶部 -->
    <div class="top">
      <span
        v-if="btnFlag"
        class="backtop"
        @click="toTop"
      ><i
        class="el-icon-top"
      /></span>
    </div>
  </div>
</template>

<script>
import Sreviceleft from '../components/Search/left.vue'
import SreviceRight from '../components/Search/right.vue'
import { mapActions, mapGetters } from 'vuex'
import fackClickOutSide from '@/utils/fackClickOutSide'
// import Search from "../components/SearchInput/SearchInput.vue";

export default {
  mixins:[fackClickOutSide],
  name: 'InputTags',
  components: {
    Sreviceleft,
    SreviceRight
    // Search,
  },
  props: {
    parentArr: {
      type: Array,
      default() {
        return ['service', 'dns-doh']
      }
    },
    limit: {
      type: Number
    }
  },
  data() {
    return {
      tabshow: 1,
      value1: false,
      value2: false,
      value3: false,
      value4: false,
      pageShow: true,
      rightShow: true,
      leftShow: true,
      btnFlag: false, // 返回顶部
      // 搜索框
      keyword: [],
      obj: { service: 'dns-doh' },
      obj1: [],
      currentval: '',
      inputLength: '',
      // nav_list: true,
      // // Loading: false,
      // Loadshow: false,
      options: [],
      options1: [{
        value: 'service',
        label: 'service',
        disabled: false
      },
      {
        value: 'ip',
        label: 'ip',
        disabled: false
      },
      {
        value: 'port',
        label: 'port',
        disabled: false
      }],
      // options3: [ {
      //     value: "dns-doh",
      //     label: "dns-doh",
      //     disabled: false
      //   },
      //   {
      //     value: "dns-do53",
      //     label: "dns-do53",
      //     disabled: false
      //   },],
      options2: [
        {
          value: 'DNS',
          label: 'DNS',
          disabled: false,
          children: [
            {
              value: 'dns-doh',
              label: 'dns-doh',
              disabled: false
              // children: [
              //   {
              //     value: "proxy",
              //     label: "proxy",
              //     disabled: false,
              //   },
              //   {
              //     value: "server",
              //     label: "server",
              //     disabled: false,
              //   },
              // ],

            },
            {
              value: 'dns-do53',
              label: 'dns-do53',
              disabled: false
              // children: [
              //   {
              //     value: "open-rdns",
              //     label: "open-rdns",
              //     disabled: false,
              //   },
              //   {
              //     value: "egress-dns",
              //     label: "egress-dns",
              //     disabled: false,
              //   },
              //   {
              //     value: "forwarder",
              //     label: "forwarder",
              //     disabled: false,
              //   },
              //   {
              //     value: "fwd/rdns",
              //     label: "fwd/rdns",
              //     disabled: false,
              //   },
              //   {
              //     value: "nonstandard",
              //     label: "nonstandard",
              //     disabled: false,
              //   },
              //   {
              //     value: "root",
              //     label: "root",
              //     disabled: false,
              //   },
              //   {
              //     value: "tld",
              //     label: "tld",
              //     disabled: false,
              //   },
              //   {
              //     value: "ns",
              //     label: "ns",
              //     disabled: false,
              //   },
              // ],
            }
          ]
        }
        // {
        //   value: "email",
        //   label: "email",
        //   disabled: false,
        //   children: [
        //     {
        //       value: "email-1",
        //       label: "email-1",
        //       disabled: false,
        //     },
        //     {
        //       value: "email-2",
        //       label: "email-2",
        //       disabled: false,
        //     },
        //   ],
        // },
      ],
      isFocus: false,
      type: 'select',
      newSer: [],
      newip: [],
      newPort: [],
      find: { service: 'dns-doh' }
    }
  },
  watch: {
    keyword() {
      this.$emit('on-change', this.keyword)
    },
    currentval(val) {
      this.inputLength = this.$refs.inputTag.value.length * 12 + 50
    },
    parentArr() {
      this.keyword = this.parentArr.length ? this.parentArr : []
    }
  },
  created() {
    window.addEventListener('scroll', this.scrollToTop)
    // this.enterSearch();

    // document.addEventListener('click', (e) => {
    //   var nav = document.getElementsByClassName('listhide')[0]
    //   if (nav.contains(e.target)) {
    //     this.nav_list = true
    //   } else {
    //     this.nav_list = false
    //   }
    // })
  },
  destroyed() {
    window.removeEventListener('scroll', () => {
      this.scrollToTop()
    })
  },
  computed: {
    ...mapGetters({
      list: 'searchlist/list',
      size: 'searchlist/size',
      left: 'searchlist/left',
      // xylist: 'searchlist/xylist',
      loging: 'searchlist/Loging'
    }),
    inputStyle() {
      const style = {}
      style.width = `${this.inputLength}px`
      return style
    },
    finall() {
      return this.keyword.join(',')
    }
  },
  
  methods: {
    // 删除
    removeTag(index, item) {
      // console.log(index, item);
      this.keyword.splice(index, 1)
      this.keyword.splice(index - 1, 1)
      this.update()
      // this.gs()
      for (var i = 0; i < this.obj1.length; i++) {
        if (item == this.obj1[i].service || item == this.obj1[i].ip || item == this.obj1[i].port) {
          // console.log(this.obj1[i].service,i)
          this.obj1.splice(i, 1)
          i--
        }
      }
      this.concat()
      // this.contrast(this.newSer,item)
      // this.contrast(this.newip,item)
      // this.contrast(this.newPort,item)
      // console.log(this.newSer,this.newip,this.newPort,"---del")
    },
    // 比较
    // contrast(arr,item){
    //   if(arr){
    //     for(var i=0;i<arr.length;i++){
    //     // console.log(arr[0],item,90);
    //     if(item == arr[i]){
    //      return arr.splice(i,1)
    //     }
    //   }
    //   }

    // },
    edit() {
      var str = []
      this.keyword.forEach(item => {
        if (Array.isArray(item)) {
          item.forEach(a => {
            str.push(a[a.length - 1])
          })
        } else {
          str.push(item)
        }
      })
      for (var i = 0; i < str.length; i++) {
        if (str[i] == 'DNS') {
          this.options2[this.options2.findIndex((item) => item.value === 'DNS')].disabled = true
          for (var a = 0; a < this.options2.length; a++) {
            if (this.options2[a].children) {
              for (var j = 0; j < this.options2[a].children.length; j++) {
                this.$set(this.options2[a].children[j], 'disabled', true)
                if (this.options2[a].children[j].children) {
                  for (var b = 0; b < this.options2[a].children[j].children.length; b++) {
                    this.$set(this.options2[a].children[j].children[b], 'disabled', true)
                  }
                }
              }
            }
          }
        } else if (str[i] == 'dns-doh') {
          var text1 = this.options2[this.options2.findIndex((item) => item.value === 'DNS')].children
          text1[text1.findIndex((item) => item.value === 'dns-doh')].disabled = true
          for (var a = 0; a < text1.length; a++) {
            if (text1[a].children) {
              for (var b = 0; b < text1[a].children.length; b++) {
                this.$set(text1[a].children[b], 'disabled', true)
              }
            }
          }
        } else if (str[i] == 'dns-do53') {
          var text1 = this.options2[this.options2.findIndex((item) => item.value === 'DNS')].children
          text1[text1.findIndex((item) => item.value === 'dns-do53')].disabled = true
          for (var a = 0; a < text1.length; a++) {
            if (text1[a].children) {
              for (var b = 0; b < text1[a].children.length; b++) {
                this.$set(text1[a].children[b], 'disabled', true)
              }
            }
          }
        }
      }
    },
    update() {
      this.options2.forEach(item => {
        this.$set(item, 'disabled', false)
        if (item.children) {
          item.children.forEach(a => {
            this.$set(a, 'disabled', false)
            if (a.children) {
              a.children.forEach(b => {
                this.$set(b, 'disabled', false)
              })
            }
          })
        }
      })
    },
    addTags(e) {
      // console.log(this.currentval,e, "code输入");
      // console.log(this.options1, this.options2, "下拉列表");
      if (this.currentval != '') {
        if (this.currentval == 'service') {
          this.options = this.options2
          this.type = 'more'
          this.keyword.push(this.currentval)
          this.currentval = ''
        } else if (this.currentval == 'ip' || this.currentval == 'port') {
          this.type = 'input'
          this.keyword.push(this.currentval)
          this.currentval = ''
        } else {
          this.options = this.options1
          this.type = 'select'
          this.keyword.push(this.currentval)
          this.currentval = ''
        }
        // console.log(this.keyword);
        this.edit()
        this.concat()
      }
    },
    // 拼接格式
    concat() {
      var str = []
      this.keyword.forEach(item => {
        if (Array.isArray(item)) {
          item.forEach(a => {
            str.push(a[a.length - 1])
          })
        } else {
          str.push(item)
        }
      })
      var ser = []
      var ip = []
      var port = []
      for (var i = 1; i <= str.length / 2; i++) {
        this.$set(this.obj, str[2 * i - 2], str[2 * i - 1])
        if (str[2 * i - 2] == 'service') {
          ser.push(str[2 * i - 1])
        } else if (str[2 * i - 2] == 'ip') {
          ip.push(str[2 * i - 1])
        } else if (str[2 * i - 2] == 'port') {
          port.push(str[2 * i - 1])
        }
      }
      this.newSer = this.delRepeat(ser)
      this.newip = this.delRepeat(ip)
      this.newPort = this.delRepeat(port)
      var serArr = this.newSer.join(' AND ')
      var ipArr = this.newip.join(' AND ')
      var portArr = this.newPort.join(' AND ')
      this.$set(this.find, 'service', serArr)
      this.$set(this.find, 'ip', ipArr)
      this.$set(this.find, 'port', portArr)
      // console.log(this.obj1,"1111");
      console.log(this.find)
    },
    // 去重
    delRepeat(arr) {
      const newArr = []
      for (let i = 0; i < arr.length; i++) {
        let flag = true
        for (let j = 0; j < newArr.length; j++) {
          arr[i] === newArr[j] ? flag = false : flag
        }
        flag ? newArr.push(arr[i]) : newArr
      }
      return newArr
    },
    handleKeydown(e) {
      console.log(e);
      var keyCode = window.event ? e.keyCode : e.which
      this.$nextTick(() => {
        if (keyCode === 8) {
          // console.log(this.$refs.inputTag.value,'----value');
          // console.log(this.$refs.inputTag.query,'----query');
          // console.log(this.currentval,'cur');

          if (this.$refs.inputTag.query === '' || (this.currentval == '' && this.$refs.inputTag.query == undefined)) {
            setTimeout(() => {
              // console.log(888);
              this.keyword.pop()
              this.searchFoucs()
            })
          }
        }
        if (keyCode == 13) {
          if (this.type == 'input') {
            // console.log(this.$refs.inputTag,this.type,this.currentval,898);
            //   this.$refs.inputTag.visible = false;
            setTimeout(() => {
              this.addTags()
              this.search()
            })
          } else if (this.type == 'select' && this.keyword.length % 2 === 0) {
            setTimeout(() => {
              this.addTags()
              // this.keyword.pop();
              this.search()
            })
          }
        }
      })
    },
    onclick() {
      this.$nextTick(() => {
        this.$refs.inputTag.focus();
        this.searchFoucs()
        // this.redit()
      })
    },
    // 输入框键盘删除键删除tag
    // deleteTags(state) {
    // var keyCode = window.event ? e.keyCode : e.which;
    // if (state) {
    //   setTimeout(() => {
    //       this.keyword.pop();
    //       this.searchFoucs();
    //   });
    // }
    // },
    // changeArr(arr) {
    //   var item = {};
    //   // arr = arr.toString().split("");
    //   for (var i = 0; i < arr.length; i++) {
    //     var dt = arr[i];
    //     if (item[dt]) {
    //       item[dt]++;
    //     } else {
    //       item[dt] = 1;
    //     }
    //   }
    //   return item;
    // },
    searchFoucs() {
      var str = []
      this.keyword.forEach(item => {
        if (Array.isArray(item)) {
          item.forEach(a => {
            str.push(a[a.length - 1])
          })
        } else {
          str.push(item)
        }
      })
      var len = str.length
      var last = str[len - 1]
      if (last == 'service') {
        this.options = this.options2
        this.type = 'more'
      } else if (last == 'ip' || last == 'port') {
        this.type = 'input'
      } else {
        this.options = this.options1
        this.type = 'select'
      }
      this.update()
      this.edit()
    },
    ...mapActions({
      listActions: 'searchlist/listActions',
      leftlistActions: 'searchlist/leftlistActions',
      changePage: 'searchlist/pageActions',
      changeSize: 'searchlist/sizeActions'
    }),

    // 搜索点击方法
    search() {
      this.addTags()
      this.concat()
      this.leftlistActions(this.find)
      this.curPage(1)
      this.pageShow = false
      this.rightShow = false;
      (this.leftShow = false),
      this.$nextTick(() => {
        this.pageShow = true
        this.rightShow = true
        this.leftShow = true
      })
      this.$store.state.searchlist.Loging = true
      //  console.log(this.obj,13);
    },
    // 回车搜索
    // enterSearch() {
    //   document.onkeydown = (e) => {
    //     if (e.key === "Enter" && this.keyword.length % 2 ===0) {
    //       console.log("执行搜索", this.keyword.length % 2);
    //       this.search();
    //     }
    //   };
    // },
    // 返回顶部
    toTop() {
      window.scroll({
        top: 0,
        left: 0,
        behavior: 'smooth'
      })
    },
    scrollToTop() {
      const scrollTop =
        window.pageYOffset ||
        document.documentElement.scrollTop ||
        document.body.scrollTop
      const h =
        window.innerHeight ||
        document.documentElement.clientHeight ||
        document.body.clientHeight
      if (scrollTop > h) {
        this.btnFlag = true
      } else {
        this.btnFlag = false
      }
    },
    // 分页
    curPage(page) {
      this.changePage(page)
      this.listActions(this.find)
      this.$store.state.searchlist.Loging = true
    },
    // 每页条数
    handleSizeChange(val) {
      this.changeSize(val)
      // this.listActions(this.obj);
      this.listActions(this.find)
    },
    // 选项卡切换
    tab(val) {
      this.tabshow = val
    },
    handleIndependIpNum(independentIpNum) {
      if (!isNaN(independentIpNum)) {
        return independentIpNum
      } else {
        // independentIpNum.forEach(a=>{
        //   res += a.key + ':' + a.value + ','
        // })
        let val = JSON.stringify(independentIpNum)
        val = val.substring(1, val.length - 1)
        return val.replaceAll('\"', '')
      }
    }
  },
  mounted() {
    this.keyword = this.parentArr
    this.listActions(this.find)
    this.leftlistActions(this.find)
    this.keyword = this.parentArr
    this.options = this.options1
    // this.gs()
    this.concat()
  }
}
</script>

<style lang="scss" scoped>
.dashboard-container {
  // width: 91%;
  // margin: 0px auto;
  height: 100vh;
  .form_list {
    width: 100%;
    padding-bottom: 20px;
    background-color: #f9fafd;
    .middle {
      width: 91%;
      margin: 0px auto;
      background-color: white;
      margin-bottom: 10px;
      margin-top: 5px;
      .el-button--primary {
        background-color: #4608ad;
        border-color: #4608ad;
      }
    }
    .form_title {
      width: 91%;
      margin: 0px auto;
      display: flex;
      align-items: center;
      height: 45px;
      line-height: 45px;
      text-align: center;
      // margin-top: 10px;
      // border: 1px solid transparent;
      background-color: white;
      div {
        width: 180px;
        padding-left: 5px;
        background-color: #f9fafd;
        border-radius: 10px 10px 0px 0px;
        color: #000;
        margin-right: 4px;
        margin-top: 10px;
      }
      .active {
        background-color: #4608ad;
        color: white;
      }
    }
    .form_box {
      width: 91%;
      margin: 0px auto;
    }
    .clear {
      clear: both;
    }
  }
  .search {
    width: 100%;
    height: 44px;
    border: 1px solid #ccc;
    border-radius: 0px 10px 10px 10px;
    outline-style: none;
    padding: 0;
  }
  .el-button--primary {
    position: absolute;
    right: 2px;
    bottom: 4px;
    height: 34px;
    width: 132px;
    font-size: 16px;
    border-radius: 5px;
    z-index: 1;
  }
  .text {
    display: flex;
    justify-content: space-between;
    align-items: center;
    .massage {
      // background: palegreen;
      width: 70%;
      // float: left;
      span {
        color: #4608ad;
      }
      .second {
        color: rgb(228, 107, 100);
      }
    }
    .switch {
      // background: pink;
      // width: 30%;
      // float: right;
      margin: 16px 0px;
      color: white !important;
      div >>> .el-switch__label.is-active {
        color: #ccc !important;
      }
    }
  }
  .backtop {
    background-color: transparent;
    border: 1px solid #4608ad;
    border-radius: 50%;
    text-align: center;
    color: #4608ad;
  }
}
@media only screen and (min-width: 768px) and (max-width: 1370px) {
  .dashboard-container .text >>> .massage {
    width: 60%;
  }
  .backtop {
    position: fixed;
    width: 40px;
    height: 40px;
    bottom: 40px;
    right: 10px;
    line-height: 40px;
  }
}
@media only screen and (min-width: 1371px) and (max-width: 2400px) {
  .dashboard-container .text >>> .massage {
    width: 63%;
  }
  .backtop {
    position: fixed;
    width: 50px;
    height: 50px;
    bottom: 50px;
    right: 20px;
    line-height: 50px;
  }
}
.el-select--small >>> .el-input--small .el-input__inner {
  height: 44px !important;
  border: 1px solid #ccc;
  border-radius: 0px 10px 10px 10px;
  outline-style: none;
  padding: 0;
  z-index: -3;
}
.block {
  // display: flex;
  // justify-content: flex-end;
  float: right;
  width: 76%;
  height: 50px;
  line-height: 50px;
  background-color: #fff;
}
.block >>> .el-pagination {
  height: 50px;
  line-height: 50px;
  padding: 10px 5px;
  float: right;
  .active {
    color: #4608ad;
  }
}
/* 外层div */
.father_box {
  .sea_box {
    height: 40px;
    line-height: 40px;
  }
  /* width: 300px; */
  box-sizing: border-box;
  background-color: white;
  border: 1px solid #7b68ee;
  border-radius: 0px 8px 8px 8px;
  font-size: 12px;
  text-align: left;
  padding-left: 5px;
  word-wrap: break-word;
  overflow: hidden;
}
/* 标签 */
.key,
.value {
  display: inline-block;
  font-size: 14px;
  margin: 3px 4px 3px 0;
  background-color: rgb(229, 229, 229);
  border: 1px solid #e8eaec;
  border-radius: 3px;
}
// .spanbox {
//   display: inline-block;
//   font-size: 14px;
//   margin: 3px 4px 3px 0;
//   background-color: #e5e5e5;
//   border: 1px solid #e8eaec;
//   border-radius: 3px;
//   height: 30px;
//   line-height: 30px;
// }
.spanbox_value {
  display: inline-block;
  font-size: 14px;
  margin: 6px 4px 3px 0;
  background-color: #d9e4ff;
  border: 1px solid #e8eaec;
  border-radius: 3px;
  height: 30px;
  line-height: 30px;
}
.spanbox_key {
  display: inline-block;
  font-size: 14px;
  margin: 6px 4px 3px 0;
  background-color: #b5c8f8;
  border: 1px solid #e8eaec;
  border-radius: 3px;
  height: 30px;
  line-height: 30px;
}
.tagspan {
  height: 24px;
  line-height: 22px;
  max-width: 100%;
  position: relative;
  display: inline-block;
  padding-left: 8px;
  padding-right: 8px;
  color: #495060;
  font-size: 14px;
  cursor: pointer;
  opacity: 1;
  vertical-align: middle;
  overflow: hidden;
  transition: 0.25s linear;
  color: #4608ad;
  font-weight: 600;
}
.span_close {
  padding: 0 4px 0 4px;
  opacity: 1;
  -webkit-filter: none;
  filter: none;
  color: #4608ad;
  font-weight: 600;
}
.span_close:after {
  content: "\00D7";
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  /* line-height: 27px; */
  transition: 0.3s, color 0s;
}
/* input */
.inputTag {
  font-size: 16px;
  border: none;
  box-shadow: none;
  outline: none;
  background-color: transparent;
  padding: 0;
  width: auto;
  min-width: 250px;
  vertical-align: top;
  height: 32px;
  color: #495060;
  line-height: 32px;
}
.el-select--small >>> .el-input--small .el-input__inner {
  border: none;
}
.el-select--small >>> .el-input--small .el-input__suffix {
  display: none;
}
.el-cascader  >>>.el-input--small .el-input__inner{
  border: none;
}
.el-cascader  >>> .el-input--small .el-input__suffix {
  display: none;
}
.el-cascader  >>> .el-cascader__tags{
  margin-top: 5px;
  font-size: 13px;
  padding: 0px;
}
.el-cascader  >>> .el-cascader__search-input{
  margin: 0px;
}
.el-input--small >>> .el-input__inner {
  border: none;
  margin-top: 5px;
  font-size: 13px;
  padding: 0px;
}
.nav_list {
  position: relative;
  width: 100%;

  ul {
    box-shadow: 5px 5px 16px rgba(0, 0, 0, 0.1);
    width: 100%;
    position: absolute;
    padding: 0px;
    margin: 0px;
    list-style: none;
    background-color: white;
    top: 0;
    left: 0;
    z-index: 1;
    li {
      display: inline-block;
      width: 100%;
      height: 30px;
      line-height: 30px;
      padding-left: 12px;
    }
  }
}
// .el-cascader__dropdown{
//     position: absolute !important;
//     top: 174px !important;
//     left: 324px !important;
//     z-index: 1 !important;
// }
</style>
