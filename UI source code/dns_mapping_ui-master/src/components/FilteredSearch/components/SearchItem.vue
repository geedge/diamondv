<template>
  <div class="ListItem clearfix" :class="{'last-item':isLast && isFocus}">
    <!-- label 标签 -->
    <div class="label">
      <span class="el-tag el-tag--info el-tag--mini el-tag--light" @click.stop="editlabel">
        <span class="el-select__tags-text">{{ label }}</span>
      </span>
    </div>
    <!-- value 标签 -->
    <div class="value" v-show="!isFocus" :class="{'none': !value || ( Array.isArray(value) && value.length<=0)}">
      <span class="el-tag el-tag--info el-tag--mini el-tag--light" @click.stop="editVal">
        <el-tooltip class="item" effect="light" :content="getVal(value,selectItem.type || 'input')" placement="bottom">
          <span class="el-select__tags-text">{{ getVal(value,selectItem.type || 'input') }}</span>
        </el-tooltip>
        <i class="el-tag__close el-icon-close" @click.stop="handleDel"></i>
      </span>
    </div>
    <!-- 输入框操作项 -->
    <div class="input-item" v-show="isFocus">
      <template v-if="type==='timeRange'">
        <v-timerange
          @move="handleMove"
          @del="handleDel"
          @focus="handleFocus"
          @blur="handleBlur"
          @keydown="handleKeydown"
          @active="handleActive"
          ref="item"
          class="input"
          :placeholder="placeholder"
          v-model="value"/>
      </template>
      <template v-else-if="type === 'select'">
        <v-select
          @move="handleMove"
          @active="handleActive"
          @del="handleDel"
          @focus="handleFocus"
          @blur="handleBlur"
          @keydown="handleKeydown"
          ref="item"
          class="input"
          :popper-append-to-body="false"
          popper-class="autocomplete-popover"
          :placeholder="placeholder"
          v-model="value"
          :options="selectItem.options"/>
      </template>
      <template v-else>
        <v-input
          @move="handleMove"
          @active="handleActive"
          @del="handleDel"
          @focus="handleFocus"
          @blur="handleBlur"
          @keydown="handleKeydown"
          ref="item"
          class="input"
          :popper-append-to-body="false"
          popper-class="autocomplete-popover"
          v-model="value"
          :maxlength="255"
          :placeholder="placeholder"/>
      </template>
    </div>
  </div>
</template>

<script>
  import VPicker from './VPicker.vue'
  import VInput from './VInput.vue'
  import VTimerange from './VTimerange.vue'
  import VSelect from './VSelect.vue'

  var timer=null
  export default {
    name: "ListItem",
    props: ['selectItem', "isLast", 'currentIndex'],
    data() {
      return {
        loading: "",
        isFocus: false,
        placeholder: "",
        label: "",
        type: "",     //time timeRange   select  input  ,当前输入框类型
      }
    },
    created() {
      this.label = this.selectItem.name || null;
      this.type = this.selectItem.type || null;
      this.placeholder = this.selectItem.placeholder || null
    },
    mounted() {
      //新增一项数据  直接触发聚焦事件

    },
    methods: {
      clickItem(){
        setTimeout(()=>{
          this.$emit('clickItem')
        })
      },
      handleMove(direction) {
        //direction left right 移动方向 ...
        setTimeout(()=>{
          if (direction === 'left') {
            if (this.currentIndex) {
              this.$emit('moveTo', {
                self:this,
                toIndex: this.currentIndex - 1,
              })
            }
          } else {
            this.$emit('moveTo', {
              self:this,
              toIndex: this.currentIndex + 1,
            })
          }
        })
      },
      handleActive() {
        //会执行 多次,但是不会影响功能
        this.$emit('active', {
          currentIndex: this.currentIndex,
          currentItem: this.selectItem
        })
      },
      visibleChangeHandle() {
        //输入框 可能需要异步请求接口
      },
      getVal(value, type = 'input') {
        if (type === 'timeRange' && value) {
          return value.join('  -  ')
        }
        if (type === 'select' && value) {
          var selItem=this.selectItem.options.find((item,index)=>{
            return item.value === value
          })
        return (selItem && selItem.label) || value
        }
        return value
      },
      handleFocus() {
        this.isFocus = true;                                 //修改当前组件的 操作状态
        this.$parent.conditionConfig.isShow = false;         //展示 搜索的字段
        this.$parent.isFocus = true;
        this.$refs.item && this.$refs.item.triggerFocus()     //触发 光标移入 或者下拉  ...
      },
      handleBlur() {

        if(this.type=='timeRange'){
          var time1 = this.value[0]
          var time2 = this.value[1]
          if(new Date(time1).getTime()==new Date(time2).getTime()){
            this.$message.error(this.$t('i18n.overall.other.dateTimeTips'));
            this.handleFocus();
            return false
          }
        }

        this.isFocus = false;
        this.$parent.isFocus = false;
        this.$parent.conditionConfig.isShow = true;

        clearTimeout(timer)
         timer=setTimeout(()=>{
          this.$parent.triggerFocus()
          clearTimeout(timer)
        },300)
      },
      handleKeydown() {
        var keyCode = window.event ? e.keyCode : e.which;
        //删除事件
        if (keyCode === 8) {  //删除

        }
        if (keyCode === 13) {  //回车

        }
      },
      handleClear() {
        //清空所有 选中内容
        if (this.type === 'timeRange') {
          this.value = [];
          return
        }
        this.value = ""
      },
      handleDel() {
        this.$emit("del", this.selectItem)
        this.clickItem()
      },
      editVal() {
        //编辑值
        this.isFocus = true;
        this.$parent.isFocus = true;
        this.$parent.conditionConfig.isShow = false;
        this.$refs.item && this.$refs.item.triggerFocus()
        this.clickItem()
      },
      editlabel() {
        //编辑label
        this.isFocus = true;
        this.$parent.isFocus = true;
        this.$parent.conditionConfig.isShow = false;
        this.$refs.item && this.$refs.item.triggerFocus()
        this.clickItem()
      }
    },
    computed: {
      value: {
        get() {
          return this.selectItem.value
        },
        set(val) {
          // this.selectItem.value = val
          this.$set(this.selectItem, 'value',val)
        }
      }
    },
    components: {
      VPicker,
      VInput,
      VTimerange,
      VSelect,
    },
    destroyed() {
      clearTimeout(timer);
      timer=null
    },
    deactivated() {
      clearTimeout(timer);
      timer=null
    }
  }
</script>

<style lang="less" scoped>
  .input-item {
    flex: auto;
  }

  .input-item .input {
    width: 100%;
  }

  /deep/ .input-item input {
    min-width: 200px;
    width: 100%;
    border: none;
    box-shadow: none;
  }


  /deep/ .autocomplete-popover {
    width: auto !important;
    max-width: 300px !important;
  }

  /deep/ .input .el-input__inner {
    font-size: 12px;
    height: 24px;
    line-height: 24px;
    padding: 0 2px;
  }

  .ListItem {
    font-size: 0;
    margin-right: 8px;
    display: flex;
  }

  .ListItem div {
    /*float: left;*/
    white-space: nowrap;
    display: inline-block;
  }

  .clearfix:after {
    content: ".";
    display: block;
    height: 0;
    clear: both;
    visibility: hidden;
  }

  .label {
    margin: 1px;
  }

  .value {
    margin: 1px;
  }

  .el-tag {
    height: 16px;
    line-height: 16px;
  }

  .ListItem:hover .el-tag.el-tag--info {
    background-color: #DFDFDF;
  }

  .el-tag.el-tag--info {
    background-color: #f4f4f5;
  }

  /* 空数据 */
  .none .el-tag {
    padding: 0;
  }

  .none .el-tag .el-tag__close {
    left: 0px;
    /*top: -1px;*/
  }

  .last-item {
    display: flex;
    flex: auto;
  }

  .el-tag {
    vertical-align: middle;
    box-sizing: inherit;
  }

  .el-select__tags-text {
    vertical-align: unset;
    float: none !important;
  }

  .el-tag .el-icon-close {
    /*top: -5px*/
    vertical-align: top;
    top:0;
  }


  /deep/ .item {
    max-width: 240px;
  }
</style>
