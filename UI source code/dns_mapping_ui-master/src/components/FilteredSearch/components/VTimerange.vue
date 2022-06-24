<template>
  <!-- 时间范围 -->
  <div class="v-timerange" style="position: relative" @click.stop>
    <el-input
      ref="input"
      autosize
      size="mini"
      @focus="handleFocus"
      :placeholder="placeholder || $t('i18n.overall.searchInfo.selectTime')"
      @keydown.native="handleKeydown"
      v-model="inputVal"/>
    <el-date-picker
      @change="handleChange"
      v-bind="$props"
      v-on="$listeners"
      format="yyyy-MM-dd HH:mm:ss"
      value-format="yyyy-MM-dd HH:mm:ss"
      class="time-picker"
      size="mini"
      ref="timePicker"
      :picker-options="pickerOptions"
      v-model="valCopy"
      type="datetimerange"
      start-placeholder="Start Time"
      end-placeholder="End Time"
      :default-time="['00:00:00','23:59:59']">
    </el-date-picker>
  </div>
</template>

<script>
  import Moment from 'moment'
  import lodashCloneDeep from 'lodash/cloneDeep'
  import getTxt1CursorPosition from "./cursorPosition";
  var dateTime;
  export default {
    name: "v-timerange",
    props: ['value', 'type', 'disabled', 'placeholder'],
    data() {
      return {
        input: '',
        valCopy: [],
        pickerOptions:{
        },
      }
    },
    model: {
      prop: 'value',
      event: 'change'
    },
    methods: {
      focus(value){
        console.log(value);
      },
      blur(value){
        console.log(value);
      },
      handleKeydown(e) {
        var keyCode = window.event ? e.keyCode : e.which;
        var dom = this.$refs.input ? $(this.$refs.input.$el).find('input')[0] : '';
        var cursorIndex = dom ? getTxt1CursorPosition(dom, document) || 0 : 0;
        //删除事件
        if (keyCode === 8) {
          this.$emit("del")
          this.$emit("blur")
          return
        }
        if (keyCode === 13) {  //回车
          this.$refs.timePicker.pickerVisible = false
          this.$emit("blur")
          return
        }
        if (keyCode === 37) { //左箭头  || 37 右箭头
          if (dom && cursorIndex === 0) {
            this.$refs.timePicker.pickerVisible = false
            this.$emit("move", 'left')
          }
          return
        }
        if (keyCode === 39) { //右箭头  || 39 右箭头
          if (!this.inputVal || cursorIndex === this.inputVal.length) {
            this.$refs.timePicker.pickerVisible = false
            this.$emit("move", 'right')
          }
          return
        }
      },
      handleChange(value) {
        if(value){
          
        }
      },
      triggerFocus() {
        //下拉 日期面板展示
        this.$emit("active")
        this.$refs.timePicker.pickerVisible = true;
        this.$nextTick(() => {
          //并非 触发聚焦事件 而是光标移入 类似
          var dom = this.$refs.input.$el.children[0];    //获取输入框DOM 索引
          dom.focus();
        })
      },
      handleFocus() {
        //输入框聚焦
        this.$nextTick(() => {
          this.$refs.timePicker.focus()
        })
      }
    },
    created() {
      this.valCopy = this.value ? lodashCloneDeep(this.value) : [];
    },
    mounted() {
    },
    computed: {
      inputVal: {
        get() {
          var timeVal = this.valCopy || []
          return this.valCopy.join('  -  ')
        },
        set(val) {
          //不允许手动修改时间  校验麻烦
        }
      }
    },
    watch: {
      valCopy(n, o) {
        if (this.value !== n) {
          this.$emit('change', this.valCopy)
        }
      },
      value(n, o) {
        this.valCopy = n || []
      }
    }
  }
</script>

<style lang="less" scoped>
  .v-timerange {
    position: relative;
  }

  .time-picker {
    visibility: hidden;
  }

  /deep/ .el-date-editor {
    position: absolute;
    left: 0;
    right: 0;
    width: auto;
    overflow: hidden;
    border: none;
    padding: 0;
    height: 24px;
  }

  /deep/ .el-input__inner {
    padding-left: 0 !important;
    min-width: 248px !important;
    font-size: 12px;
  }
</style>
