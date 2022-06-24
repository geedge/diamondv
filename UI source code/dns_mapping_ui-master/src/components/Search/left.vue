<template>
  <div class="left">
    <el-collapse v-model="activeNames">
      <el-collapse-item title="端口" name="1">
        <div v-for="(val,key,i) in left.portList" :key="i" class="item">
          <p>{{ val.port }}</p>
          <p>{{ val.count }}</p>
        </div>
      </el-collapse-item>
      <el-collapse-item title="地域" name="2">
        <div v-for="(val,key,i) in left.regionList" :key="i" class="item">
          <p>{{ val.province }}</p>
          <p>{{ val.count }}</p>
        </div>
      </el-collapse-item>
      <el-collapse-item title="服务类别" name="3">
        <div v-for="(val,key,i) in left.serviceCategoryList" :key="i" class="item">
          <p>{{ val.key }}</p>
          <p>{{ val.count }}</p>
        </div>
      </el-collapse-item>
      <el-collapse-item title="运营商" name="4">
        <div v-for="(val,key,i) in left.providerList" :key="i" class="item">
          <p>{{ val.provider }}</p>
          <p>{{ val.count }}</p>
        </div>
      </el-collapse-item>
      <el-collapse-item title="服务组件" name="5">
        <div v-for="(val,key,i) in left.componentList" :key="i" class="item">
          <p>{{ val.component }}</p>
          <p>{{ val.count }}</p>
        </div>
      </el-collapse-item>
      <el-collapse-item title="漏洞威胁" name="6">
        <div v-for="(val,key,i) in left.vulnerabilityCountList" :key="i" class="item">
          <p>{{ val.vulnerability }}</p>
          <p>{{ val.count }}</p>
        </div>
      </el-collapse-item>
    </el-collapse>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  data() {
    return {
      activeNames: ['1']
    }
  },
  computed: {
    ...mapGetters({
      left: 'searchlist/left'
    })
  },
  methods: {
    ...mapActions({
      leftlistActions: 'searchlist/leftlistActions'
    })
  }
}
</script>

<style lang="scss" scoped>
.left {
  width: 22%;
  float: left;
  // border-radius: 20px;
  z-index: 2;
  .el-collapse {
    border-radius: 20px;
    border-top: none;
  }
  .item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0px 10px;
    font-size: 15px;
    height: 30px;

    p:nth-of-type(1) {
      color: #4608ad;
    }
    p:nth-of-type(2) {
      color: #aca9b3;
    }
  }
}
.left >>> .el-collapse-item__header {
  font-size: 16px;
  font-weight: 600;
  padding-left: 10px;
}
.left >>> .el-loading-mask{
  z-index: 1 !important;
  background-color: white;
}
</style>
