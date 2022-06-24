<template>
  <div class="block">
    <el-pagination
      :current-page="currentPage4"
      :page-sizes="[10, 20, 30, 40]"
      :page-size="100"
      layout="total, sizes, prev, pager, next, jumper"
      :total="400"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
  </div>
</template>

<script>
export default {
  data() {
    return {
      currentPage1: 5,
      currentPage2: 5,
      currentPage3: 5,
      currentPage4: 4
    }
  },
  methods: {
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`)
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`)
    }
  }
}
</script>

<style lang="scss" scoped>
.block{
    display: flex;
    justify-content: flex-end;
    float: right;
    width: 76%;
    height: 50px;
    line-height: 50px;
    background-color: #fff;
}
 .block >>> .el-pagination{
        height: 50px;
        line-height: 50px;
        padding: 10px 5px;
        // align-items: center;
        .active{
            color: #4608ad;
        }
    }
</style>
