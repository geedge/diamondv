<template>
  <!-- 详情右侧 -->
  <el-tabs v-model="activeName" @tab-click="handleClick">
    <el-tab-pane label="响应" name="a1">
      <div class="contentright_box">
        <div>
          <textarea
            id=""
            v-model="xylist"
            readonly
            name=""
            cols="30"
            rows="10"
          />
        </div>
      </div>
    </el-tab-pane>
    <el-tab-pane label="证书" name="a2">
      <div class="contentright_box">
        <div>
          <textarea
            id=""
            v-model="zslist"
            readonly
            name=""
            cols="30"
            rows="10"
          />
        </div>
      </div>
    </el-tab-pane>
    <el-tab-pane label="http" name="a3">
      <div class="contentright_box">
        <div>
          <textarea id="" v-model="httplist" name="" cols="30" rows="10" />
        </div>
      </div>
    </el-tab-pane>
  </el-tabs>
</template>

<script>
export default {
  props: { tabData: {}},
  data() {
    return {
      // first: 1,
      // second: 2,
      // third: 3,
      activeName: 'a1'
    }
  },
  computed: {
    // 处理证书展示
    zslist: function() {
      let zslist1 = ''
      //   console.log(this.tabData.ipCert);
      if (this.tabData.ipCert == undefined || this.tabData.ipCert == null) {
        return zslist1
      } else {
        if (this.tabData.ipCert.length >= 1) {
          this.tabData.ipCert.map((item, index) => {
            // console.log(item, index, 999);
            zslist1 += `${item.certificate}\n-----------------------\n`
          })
          return zslist1
        }
      }
    },
    // banner 响应区
    xylist: function() {
      let xylist1 = ''
      // doh 设置展示数据格式
      if (this.tabData.banner && this.tabData.dnsType == undefined) {
        if (this.tabData.banner.length >= 1) {
          this.tabData.banner.map((item, index) => {
            // console.log(item,"length");
            xylist1 += `${item}\n----------------------\n`
          })
          return xylist1
        }
      } else if (this.tabData.banner === undefined) {
        return xylist1
      } else if (this.tabData.dnsType == 5) {
        console.log(555);
        if (this.tabData.banner.length >= 1) {
          this.tabData.banner.map((item, index) => {
          console.log(item);
            if(index===0){
              xylist1 += `${item}\n----------------------\n`
            }else{
              xylist1 +=`record=${item.record}\n----------------------\n`
            }
            // else{
            // xylist1 =`record=${this.tabData.record}`
            // }
            })
        }
        return xylist1
        // return `record=${this.tabData.record}`
      } else if (this.tabData.dnsType === 3 || this.tabData.dnsType === 2) {
        if (this.tabData.banner.length >= 1) {
          this.tabData.banner.map((item, index) => {
            if(index===0){
              xylist1 += `${item}\n--------------------\n`
            }else{
              xylist1 += JSON.stringify(item)+`\n--------------------\n`
              // xylist1 +=
              // `服务器ip地址:${item.city}\n` +
              // `IP所属国家:${item.country}\n` +
              // `IP所属省份:${item.province}\n` +
              // `IP所属城市:${item.city}\n` +
              // `IP所属区县:${item.district}\n` +
              // `IP所属提供服务商:${item.provider}\n` +
              // `IP所属运行商:${item.isp}\n` +
              // `自治域编码:${item.asnumber}\n----------------\n`;

            }
            // console.log(item,"length");
            // this.xylist += JSON.stringify(item)+'\n'
            
          })
          return xylist1
        } else {
          return this.tabData.banner[0]
        }
      } else {
        xylist1 = this.tabData.banner[0]
      }
      return xylist1
    },
    // http页签展示处理
    httplist: function() {
      // 数据格式和接口返回值暂时版
      let httpHearders = ''
      if (this.tabData.httpContent === undefined || this.tabData.httpContent === null) {
        return httpHearders
      } else {
        this.tabData.httpContent.map((item, index) => {
          // console.log(item,"length");
          httpHearders += `${item}\n-------------------------------\n`
        })
        return httpHearders
      }
      return httpHearders
    }
  },
  created() {},
  methods: {
    handleClick(tab, event) {
      // console.log(tab, event);
    }
  }
}
</script>

<style lang="scss" scoped>
textarea {
  width: 100%;
  resize: none;
  outline: none;
  border: none;
  background-color: #f9fafb;
  color: #aca9b3;
  font-size: 16px;
}

</style>
<style>
.el-tabs__nav-scroll {
  padding-left: 12px;
}
.el-tabs__nav-scroll .is-active {
  color: #4608ad !important;
}
.el-tabs__active-bar {
  background-color: #4608ad !important;
}
.el-tabs__nav :hover{
    color: #4608ad !important;
}
</style>
