<template>
  <!-- 父盒子 -->
  <div class="father_box">
    <div class="sea_box" @click="onclick">
      <div
        v-for="(item, index) in keyword"
        :key="index"
        class="spanbox"
        ref="Tag"
      >
        <span v-if="Array.isArray(item)" class="tagspan">
          <span v-for="(a, i) in item" :key="i">{{ a[a.length - 1] }}</span>
        </span>
        <span class="tagspan" v-else>{{ item }}</span>

        <!-- <span class="tagspan" v-if="Array.isArray(item)">{{ item[item.length-1] }}</span> -->
        <!-- <span class="tagspan" v-for="(a,i) in item" :key="a" v-if="Array.isArray(item)">{{item[0]}}</span> -->
        <i
          class="span_close"
          @click="removeTag(index, item)"
          v-if="index % 2 != 0"
        ></i>
      </div>
      <el-input
        placeholder="请输入检索内容"
        v-model="currentval"
        @keydown.native="handleKeydown"
        @focus="searchFoucs"
        :style="inputStyle"
        class="inputTag"
        ref="inputTag"
        type="text"
        v-if="type === 'input'"
      ></el-input>
      <el-select
        placeholder="请输入检索内容"
        v-model="currentval"
        @change="addTags"
        @keyup.native="handleKeydown"
        @focus="searchFoucs"
        :style="inputStyle"
        class="inputTag"
        ref="inputTag"
        type="text"
        filterable
        remote
        default-first-option
        v-else-if="type == 'select'"
      >
        <el-option
          v-for="item in options"
          :key="item.value"
          :label="item.label"
          :value="item.value"
          :disabled="item.disabled"
        >
        </el-option>
      </el-select>

      <el-cascader
        :options="options"
        :props="{ multiple: true, checkStrictly: true }"
        clearable
        v-model="currentval"
        @change="addTags"
        @keyup.native="handleKeydown"
        @focus="searchFoucs"
        :style="inputStyle"
        class="inputTag"
        ref="inputTag"
        type="text"
        filterable
        remote
        default-first-option
        v-else-if="type == 'more'"
      ></el-cascader> 

      <el-select
        placeholder="请输入检索内容"
        v-model="currentval"
        @change="addTags"
        @keyup.native="handleKeydown"
        @focus="searchFoucs"
        :style="inputStyle"
        class="inputTag"
        ref="inputTag"
        type="text"
        filterable
        remote
        default-first-option
        v-else
      >
        <el-option
          v-for="item in options"
          :key="item.value"
          :label="item.label"
          :value="item.value"
          :disabled="item.disabled"
        >
        </el-option>
      </el-select>
    </div>
  </div>
</template>
 
<script>
export default {
  name: "inputTags",
  props: {
    parentArr: {
      type: Array,
      default() {
        return ["service", "dns-doh"];
      },
    },
    limit: {
      type: Number,
    },
  },
  data() {
    return {
      currentval: "",
      keyword: [],
      inputLength: "",
      // Object: {
      //   arr: [
      //     {
      //       id: 1,
      //       name: "service",
      //       value: "选项1",
      //       type: "select",
      //       child: [
      //         {
      //           value: "dns-doh",
      //           label: "dns-doh",
      //         },
      //         {
      //           value: "dns-do53",
      //           label: "dns-do53",
      //         },
      //       ],
      //     },
      //     {
      //       id: 2,
      //       name: "ip",
      //       type: "input",
      //     },
      //     {
      //       id: 3,
      //       name: "port",
      //       type: "input",
      //     },
      //   ],
      // },
      options: [],
      options1: [
        {
          value: "service",
          label: "service",
          // disabled: false,
        },
        {
          value: "ip",
          label: "ip",
          // disabled: false,
        },
        {
          value: "port",
          label: "port",
          // disabled: false,
        },
      ],
      // options2: [
      //   {
      //     value: "dns-doh",
      //     label: "dns-doh",
      //     disabled: false,
      //   },
      //   {
      //     value: "dns-do53",
      //     label: "dns-do53",
      //     disabled: false,
      //   },
      // ],
      options2: [
        {
          value: "DNS",
          label: "DNS",
          disabled: false,
          children: [
            {
              value: "dns-doh",
              label: "dns-doh",
              disabled: false,
              // children: [
              //   {
              //     value: "open-rdns",
              //     label: "open-rdns",
              //     disabled: false,
              //   },
              //   {
              //     value: "egress-rdns",
              //     label: "egress-rdns",
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
            },
            {
              value: "dns-do53",
              label: "dns-do53",
              disabled: false,
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
          ],
        },
        {
          value: "email",
          label: "email",
          children: [
            {
              value: "email-1",
              label: "email-1",
            },
            {
              value: "email-2",
              label: "email-2",
            },
          ],
        },
      ],
      isFocus: false,
      type: "select",
    };
  },
  watch: {
    keyword() {
      this.$emit("on-change", this.keyword);
    },
    currentval(val) {
      this.inputLength = this.$refs.inputTag.value.length * 12 + 50;
    },
    parentArr() {
      this.keyword = this.parentArr.length ? this.parentArr : [];
    },
  },
  computed: {
    inputStyle() {
      let style = {};
      style.width = `${this.inputLength}px`;
      return style;
    },
    finall() {
      return this.keyword.join(",");
    },
  },
  mounted() {
    this.keyword = this.parentArr;
    this.options = this.options1;
    // this.edit();
  },

  // directives:{
  //   focus:{
  //     inserted:function (e) {
  //       console.log(e);
  //     }
  //   }
  // },
  methods: {
    removeTag(index, item) {
      // console.log(index-1, item);
      this.keyword.splice(index, 1);
      this.keyword.splice(index - 1, 1);
      // this.options1.forEach((item) => {
      //   item.disabled = false;
      // });
      // this.options2.forEach((item) => {
      //   item.disabled = false;
      // });
    },
    addTags() {
      // console.log(this.currentval, "code输入");
      // console.log(this.options1, this.options2, "edit");
      if (this.currentval == "service") {
        this.options = this.options2;
        this.type = "more";
        this.keyword.push(this.currentval);
        this.currentval = "";
      } else if (this.currentval == "ip" || this.currentval == "port") {
        this.type = "input";
        this.keyword.push(this.currentval);
        this.currentval = "";
      } else {
        this.options = this.options1;
        this.type = "select";
        this.keyword.push(this.currentval);
        this.currentval = "";
      }
      // for (var i = 0; i < this.keyword.length; i++) {
      //   console.log(this.keyword[i], 787);
      //   if (this.keyword[i] == "dns-doh") {
      //     // console.log(this.options2[this.options2.findIndex((item) => item.value === "dns-doh")].disabled);
      //     this.options2[
      //       this.options2.findIndex((item) => item.value === "dns-doh")
      //     ].disabled = true;
      //   } else if (this.keyword[i] == "dns-do53") {
      //     this.options2[
      //       this.options2.findIndex((item) => item.value === "dns-do53")
      //     ].disabled = true;
      //   } else if (this.keyword[i] == "ip") {
      //     // console.log(this.options1[this.options2.findIndex((item) => item.value === "dns-doh")].disabled);
      //     this.options1[
      //       this.options1.findIndex((item) => item.value === "ip")
      //     ].disabled = true;
      //   } else if (this.keyword[i] == "port") {
      //     this.options1[
      //       this.options1.findIndex((item) => item.value === "port")
      //     ].disabled = true;
      //   }
      // }
      console.log(this.keyword, "add");

      // this.edit();
    },
    open() {
      this.$alert("输入值不能为空", "提示", {
        confirmButtonText: "确定",
      });
    },
    handleKeydown(e) {
      // console.log(e);
      var keyCode = window.event ? e.keyCode : e.which;
      this.$nextTick(() => {
        if (keyCode === 8) {
          // console.log(this.$refs.inputTag.value,'----value');
          // console.log(this.$refs.inputTag.query,'----query');
          // console.log(this.currentval,'cur');
          if (
            this.$refs.inputTag.query === "" ||
            (this.currentval == "" && this.$refs.inputTag.query == undefined)
          ) {
            setTimeout(() => {
              // console.log(888);
              this.keyword.pop();
              this.searchFoucs();
            });
          }
        }
        if (keyCode == 13) {
          if (
            (this.$refs.inputTag &&
              this.type == "select" &&
              this.currentval != "") ||
            this.type == "input"
          ) {
            console.log(this.$refs.inputTag, this.type, this.currentval);
            //   this.$refs.inputTag.visible = false;
            setTimeout(() => {
              this.addTags();
            });
          }
        }
      });
    },
    onclick() {
      this.$nextTick(() => {
        // this.$refs.inputTag.focus();
        this.searchFoucs();
      });
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
      // console.log(this.keyword,"---keyword");
      var len = this.keyword.length;
      var last = this.keyword[len - 1];
      if (last == "service") {
        this.options = this.options2;
        this.type = "more";
      } else if (last == "ip" || last == "port") {
        this.type = "input";
      } else {
        this.options = this.options1;
        this.type = "select";
      }
    },
    // changeInput() {
    // //  console.log("changeInput");
    // },
  },
};
</script>
 
<style lang="scss" scoped>
/* 外层div */
.father_box {
  /* width: 300px; */
  box-sizing: border-box;
  background-color: white;
  border: 1px solid #dcdee2;
  border-radius: 4px;
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
.spanbox {
  display: inline-block;
  font-size: 14px;
  margin: 3px 4px 3px 0;
  background-color: rgb(229, 229, 229);
  border: 1px solid #e8eaec;
  border-radius: 3px;
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
  color: rgb(26, 26, 26);
  font-weight: 600;
}
.span_close {
  padding: 0 4px 0 4px;
  opacity: 1;
  -webkit-filter: none;
  filter: none;
  color: rgb(26, 26, 26);
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
.el-input--small >>> .el-input__inner {
  border: none;
}
.el-cascader >>> .el-input--small .el-input__inner {
  border: none;
}
.el-cascader >>> .el-input--small .el-input__suffix {
  display: none;
}
</style>
 