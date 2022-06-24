<template>
  <el-popover
    :popper-append-to-body="true"
    popper-class="RecentSearch"
    placement="bottom-start"
    trigger="hover"
    width="160"
    v-model="visible">
    <div class="list-container" >
      <template v-if="historyList.length>0">
        <template v-for="(item,index) in historyList">
          <div class="el-dropdown-menu__item history-item"  :id="'historyItem'+index" v-idscope @click="handleSelect(item)">
            <template v-for="(condition,conditionIndex) in item">
              <template v-if="conditionIndex>0">;</template>{{ condition.name }} = {{ formatVal(condition.value,condition.options) }}
            </template>
          </div>
        </template>
      </template>
      <template v-else>
        <div  class="history-item">{{$t('i18n.overall.searchInfo.noData')}} </div>
      </template>
    </div>
    <div class="clear-all el-dropdown-menu__item" id="clearHistory" @click="handleClear">{{ $t('i18n.overall.searchInfo.clearHistory') }}</div>
    <i class="el-icon-time history-icon" slot="reference"></i>
  </el-popover>
</template>

<script>
  import searchHistory from './historyApi'
  export default {
    name: "RecentSearch",
    data() {
      return {
        visible: false,
        historyList:[]
      }
    },
    mounted() {

    },
    methods:{
      formatVal(val,options){
        if(val && Array.isArray(val)){
          return val.join('  -  ')
        }
        if(options && Array.isArray(options)){
          var selectItem=options.find(item=>{
            return item.value === val
          })
          return selectItem ? selectItem.label : val
        }
        return  val
      },
      handleClear(){
        searchHistory.clearPageHistory(this.$parent.historyKey)
        this.getHistotyList()
        this.visible=false
      },
      handleSelect(item){
        //选中一条历史记录 回调函数...
        this.$emit("selectHistory",item)
        this.visible=false
      },
      getHistotyList(){
        this.historyList=searchHistory.getPageHistory(this.$parent.historyKey)
      }
    },
    watch:{
      visible:{
        handler(n,o){
          this.getHistotyList()
        },
        immediate:false,
        deep:false
      }
    }
  }
</script>

<style scoped>
  .history-icon {
    padding: 0 10px;
    cursor: pointer;
    line-height: 24px;
  }
  .list-container{
    max-height: 300px;
    overflow-y: auto;
  }
  .clear-all{
    font-size: 12px;
    line-height: 32px;
    text-align: center;
    border-top: 1px solid #DCDFE6;
    cursor: pointer;
  }
  .history-item{
    line-height: 28px;
    padding: 0 20px;
    text-align: left;
    font-size: 12px;
  }
</style>
