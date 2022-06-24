<template>
  <div class="relation">
    <title>数据统计分析工具</title>
    <div class="tip">
      <p>类型统计</p>
      <p>|</p>
      <p>总计<span>&nbsp;&nbsp;0 &nbsp;&nbsp;</span>类</p>
    </div>
    <div class="content">
      <el-empty description="暂无数据"></el-empty>
    </div>
  </div>
</template>

<script>
export default {}
</script>

<style lang="scss" scoped>
.relation {
  width: 100%;
  font-weight: 600;

  title {
    display: block;
    height: 45px;
    line-height: 45px;
    margin-top: 12px;
    padding-left: 12px;
    background-color: #fff;
  }
  .tip {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    height: 45px;
    line-height: 45px;
    margin-top: 12px;
    padding-left: 12px;
    p:nth-of-type(2) {
      margin: 0px 10px;
      color: #ccc;
    }
    span {
      color: #4608ad;
    }
  }
  // .content{
  //     height: 500px;
  //     line-height: 500px;
  //     text-align: center;
  //     color: #ccc;
  //     background-color: #fff;
  // }
}
</style>
