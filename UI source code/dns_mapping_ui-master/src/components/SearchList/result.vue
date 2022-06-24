<template>
  <div class="result">
    <div class="box">
      <ul>
        <li v-for="(item1, index1) in list.list" :key="index1" class="item">
          <!-- 详情的标题 -->
          <div class="title">
            <div class="title_left">
              <span>{{ item1.ip }}</span>
              <span>{{
                item1.ipInformation ? item1.ipInformation.country : ""
              }}</span>
              <span>{{
                item1.ipInformation ? item1.ipInformation.province : ""
              }}</span>
              <span>{{
                item1.ipInformation ? item1.ipInformation.city : ""
              }}</span>
            </div>
            <div class="title_right">
              <i class="el-icon-time" /><span>{{ item1.timestamp }}</span>
            </div>
          </div>
          <!-- 详情的内容 -->
          <div class="content">
            <!-- 详情左侧 -->
            <div class="content_left">
              <!-- 左侧头部标签 -->
              <div class="tag">
                <div class="tag_left">
                  <p>漏洞威胁</p>
                </div>
                <div class="tag_right">
                  <span><i class="el-icon-receiving" />{{ item1.protocolType }}</span>
                  <span><i class="el-icon-film" />{{ item1.ipType }}</span>
                </div>
              </div>
              <!-- 左侧链接接内容 -->
              <div class="link">
                <i class="el-icon-thumb" />
                <p>{{ item1.statusCode }}</p>
              </div>
              <!-- 左侧列表内容 -->
              <div class="content_list">
                <div class="list_left">
                  <div class="text">
                    <p>自治域编号</p>
                    <p
                      :title="`${
                        item1.ipInformation
                          ? item1.ipInformation.asnumber
                            ? item1.ipInformation.asnumber
                            : ''
                          : ''
                      }`"
                    >
                      {{
                        item1.ipInformation
                          ? item1.ipInformation.asnumber
                            ? item1.ipInformation.asnumber
                            : "--"
                          : "--"
                      }}
                    </p>
                  </div>
                  <div class="text">
                    <p>自治域</p>
                    <p>--</p>
                  </div>
                  <div class="text">
                    <p>运营商</p>
                    <p
                      :title="`${
                        item1.ipInformation
                          ? item1.ipInformation.provider
                            ? item1.ipInformation.provider
                            : ''
                          : ''
                      }`"
                    >
                      {{
                        item1.ipInformation
                          ? item1.ipInformation.provider
                            ? item1.ipInformation.provider
                            : "--"
                          : "--"
                      }}
                    </p>
                  </div>
                  <div class="text">
                    <p> IP归属</p>
                    <p
                      :title="`${
                        item1.ipInformation
                          ? item1.ipInformation.isp
                            ? item1.ipInformation.isp
                            : ''
                          : ''
                      }`"
                    >
                      {{
                        item1.ipInformation
                          ? item1.ipInformation.isp
                            ? item1.ipInformation.isp
                            : "--"
                          : "--"
                      }}
                    </p>
                  </div>
                </div>
                <div class="list_right">
                  <div class="text">
                    <p>服务组件</p>
                    <select
                      v-if="item1.componentList && item1.componentList.length != 0"
                      id=""
                      name=""
                    >
                      <option
                        v-for="(a, index) in item1.componentList"
                        :key="index"
                        value=""
                      >
                        {{ a }}
                      </option>
                    </select>
                    <p v-else>--</p>
                  </div>
                  <div class="text">
                    <p>访问路径</p>
                    <!-- <select v-if="item1.pathList.length != 0" id="" name=""> -->
                    <select v-if="item1.pathList ? item1.pathList.length : ''" id="" name="">
                      <option
                        v-for="(b, index) in item1.pathList"
                        :key="index"
                        value=""
                        :title="`${b}`"
                      >{{ b }}
                      </option>
                    </select>
                    <p v-else>--</p>
                  </div>
                  <div class="text">
                    <p>主机名</p>
                    <p :title="`${item1.host}`">
                      {{ item1.host ? item1.host : "--" }}
                    </p>
                  </div>
                  <div class="text">
                    <p>服务类别</p>
                    <!-- <p>DNS,DNS-DoH,转发服务器</p> -->
                    <!-- <div class="tag"> -->
                    <div class="tag_left">
                      <el-tag
                        v-for="(c, index) in item1.tags"
                        :key="index"
                        :title="`${c}`"
                      >
                        {{ c }}
                      </el-tag>
                    </div>
                    <!-- </div> -->
                  </div>
                </div>
              </div>
              <!-- 底部小框 -->
              <div class="content_bottom">
                <i class="el-icon-data-analysis" />
                <p v-for="(d, index) in item1.ipCert" :key="index" :title="`${d.ca}`">
                  {{ d.ca }}
                </p>
              </div>
            </div>
            <!-- 详情右侧 -->
            <div class="content_right">
              <result-tab :tab-data="item1" />
            </div>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import resultTab from './resultTab.vue'
// import { Tab } from "./xxk";
// import indexVue from "../Breadcrumb/index.vue";

export default {
  components: { resultTab },
  data() {
    return {}
  },
  created() {},
  computed: {
    ...mapGetters({
      list: 'searchlist/list'
    })
  },
  methods: {
    ...mapActions({
      listAction: 'searchlist/listActions'
    })
  },
  mounted() {}
}
</script>

<style lang="scss" scoped>
.box {
  ul {
    padding: 0px;
    margin: 10px 0px;
    li {
      list-style: none;
      background-color: #fff;
      margin-bottom: 15px;
    }
  }
  .item {
    // width: 100%;
    .title {
      // width: 50%;
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: white;
      padding: 0px 20px;
      height: 50px;
      border-bottom: 1px solid #dcdcdc;
      margin: 0px;
      .title_left span:nth-of-type(1) {
        font-size: 20px;
        color: #4608ad;
      }
      .title_left span:nth-of-type(2),
      span:nth-of-type(3),
      span:nth-of-type(4) {
        color: #aca9b3;
        padding-left: 13px;
        font-size: 15px;
      }
    }
    .content {
      width: 100%;
      // width: 566px;
      display: flex;
      .content_left {
        width: 50%;
        border-right: 1px solid #dcdcdc;
        // 左侧标签
        .tag {
          height: 50px;
          // background-color: palevioletred;
          display: flex;
          align-items: center;
          justify-content: space-between;
          padding: 0px 20px;
          p {
            display: inline-block;
            height: 30px;
            width: 72px;
            line-height: 30px;
            text-align: center;
            border-radius: 7px;
            font-size: 13px;
          }
          p:nth-of-type(1) {
            background-color: #d9e4ff;
            color: #4608ad;
          }
          // p:nth-of-type(2) {
          //   background-color: #eef7fc;
          //   color: #5abee7;
          // }
        }
        // 左侧链接
        .link {
          width: 95%;
          height: 30px;
          margin: 10px auto;
          background-color: #d9e4ff;
          border-radius: 16px;
          position: relative;
          .el-icon-thumb {
            display: inline-block;
            border-radius: 50%;
            background-color: #4608ad;
            color: #fff;
            width: 25px;
            height: 25px;
            line-height: 25px;
            text-align: center;
            position: absolute;
            left: 10px;
            top: 3px;
          }
          p {
            // margin-left: 35px;
            line-height: 30px;
            margin: 0px 40px;
          }
        }
        // 左侧列表内容
        .content_list {
          display: flex;
          justify-content: space-between;
          align-items: flex-start;
          margin: 10px 0px;
          .list_right {
            border-left: 1px solid #dcdcdc;
          }
          .list_left,
          .list_right {
            width: 50%;
            .text {
              display: flex;
              justify-content: space-between;
              align-items: center;
              // width: 283px;
              // background-color: #ff0;
              padding: 0px 20px;
              font-size: 15px;
              select {
                border: 0px;
                outline-style: none;
                margin-right: 50px;
              }
              @media only screen and (min-width: 768px) and (max-width: 1370px) {
                select {
                  margin-right: 10px;
                  width: 50%;
                }
              }
              @media only screen and (min-width: 1371px) and (max-width: 2048px) {
                select {
                  margin-right: 15px;
                  width: 50%;
                  white-space: nowrap;
                text-overflow: ellipsis;
                }
              }
              p {
                line-height: 30px;
                margin: 0px;
                overflow: hidden;
                white-space: nowrap;
                text-overflow: ellipsis;
                cursor: pointer;
                width: 50%;
              }
              .tag_left {
                display: flex;
                width: 50%;
                flex-wrap: wrap;
                cursor: pointer;
                .el-tag--small {
                  background-color: #d9e4ff;
                  color: #4608ad;
                  white-space: nowrap;
                  text-overflow: ellipsis;
                  overflow: hidden;
                  width: 65px;
                  margin-right: 3px;
                }
                @media only screen and (min-width: 768px) and (max-width: 1370px) {
                  .el-tag--small {
                    width: 45px;
                  }
                }
                @media only screen and (min-width: 1371px) and (max-width: 2048px) {
                  .el-tag--small {
                    width: 50px;
                  }
                }
                // flex-direction: column !important;
                // p {
                //   display: inline-block;
                //   height: 30px;
                //   width: 67px !important;
                //   line-height: 30px;
                //   text-align: center;
                //   border-radius: 7px;
                //   font-size: 13px;
                //   margin-bottom: 3px;
                //   margin-right: 3px;
                // }
              }
              p:nth-of-type(2) {
                // flex: 1;
                // -webkit-box-flex: 1;
                width: 50%;
                text-align: center;
                // width: 90px;
              }
            }
          }
        }
      }
      // 右侧列表
      .content_right {
        // display: flex;
        width: 50%;
      }
    }
  }
}

.el-tabs__content >>> .el-tab-pane #text {
  width: 100% !important;
  resize: none;
  outline: none;
  border: none;
  background-color: #f9fafb;
  color: #aca9b3;
  font-size: 16px;
}
.content_bottom {
  display: flex;
  align-items: center;
  padding-left: 20px;
  height: 30px;
  line-height: 30px;
  margin: 10px 0px;
  width: 93%;
  // width: auto;
  // border: 1px solid transparent;
  // border-radius:7px ;
  .el-icon-data-analysis {
    display: inline-block;
    border-radius: 10px 0px 0px 10px;
    background-color: #4608ad;
    color: white;
    display: inline-block;
    height: 30px;
    line-height: 30px;
    width: 30px;
    text-align: center;
  }
  P {
    padding: 0px 7px;
    display: inline-block;
    background-color: #d9e4ff;
    font-size: 15px;
    overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  cursor: pointer;
  }
  p:last-child {
    border-left: 1px solid #cbc8c8;
    border-radius: 0px 10px 10px 0px;
  }
}
.tab input {
  background: #f6f3f3;
  border: 1px solid #ff0000;
}
.tab .active {
  background: #e9d4d4;
}
.tab div {
  width: 300px;
  height: 250px;
  display: none;
  padding: 10px;
  background: #e9d4d4;
  border: 1px solid #ff0000;
}
</style>
