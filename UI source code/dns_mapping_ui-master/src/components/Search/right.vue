<template>
  <div class="right bigbox">
    <div class="title">
      <div :class="tabshow == 1 ? 'active' : ''" @click="tab(1)">
        检索结果
      </div>
      <div :class="tabshow == 2 ? 'active' : ''" @click="tab(2)">
        数据统计
      </div>
      <div :class="tabshow == 3 ? 'active' : ''" @click="tab(3)">
        关联分析
      </div>
      <div class="inp">
        <input type="text" placeholder="近一年">
        <el-button type="primary">导出</el-button>
      </div>
    </div>

    <div class="containerbox">
      <div v-show="tabshow == 1"><Result /></div>
      <div v-show="tabshow == 2"><Count /></div>
      <div v-show="tabshow == 3"><Relation /></div>
    </div>
  </div>
</template>

<script>
import Result from '../SearchList/result.vue'
import Count from '../SearchList/count.vue'
import Relation from '../SearchList/relation.vue'
// import { mapGetters } from 'vuex'
export default {
  components: {
    Result,
    Count,
    Relation
  },
  data() {
    return {
      tabshow: 1,
    }
  },
  // computed:{
  //   ...mapGetters({
  //       maplist: "searchlist/maplist",
  //   })
  // },
  created() {},
  methods: {
    tab(val) {
      this.tabshow = val;
      // console.log(val);
       var page = document.getElementsByClassName('block')[0];
      if(val == 2 || val == 3){
        page.style.display = "none"
      }else{
        page.style.display = "block"
      }
    },
  
  },
  
}
</script>

<style lang="scss" scoped>
.right {
  float: right;
  width: 76%;
}
.bigbox .title {
  background-color: #fff;
  height: 60px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.title{
 color: #aca9b3;
//  .inp{
//    flex: 1;
//  }
  div:nth-of-type(1){
    margin-left:10px;
  }
  div:hover{
    color: #4608ad;
    cursor:pointer
  }
 .inp input{
   height: 32px;
   width: 300px;
   border:1px solid #aca9b3;
   outline-style: none;
   border-radius: 5px;
 }
 .inp button{
   vertical-align: top;
   margin-right: 10px;
   background-color: #4608ad;
   border-color: #4608ad;
 }
}
.active {
  font-weight: 600;
  color: #4608ad !important;
  border-bottom:4px solid #4608ad;
}
html,body{
	scroll-behavior:smooth;
}
.right >>> .el-loading-mask{
  z-index: 6 !important;
  background-color: white;
}
</style>
