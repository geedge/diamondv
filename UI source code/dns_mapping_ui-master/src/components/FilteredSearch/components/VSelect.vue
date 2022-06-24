<template>
    <!-- 暂时不支持 异步,关联下拉 需要的话 请在该组件改写 -->
    <el-select
      :popper-append-to-body="true"
      popper-class="select-popper"
      @focus.stop
      @blur.stop
      class="v-select"
      ref="select"
      :collapse-tags="collapseTags"
      size="mini"
      autosize
      filterable
      v-model="valCopy"
      @visible-change="visibleChangeHandle"
      v-bind="$props"
      :loading="loading"
      @keydown.native="handleKeydown"
      :placeholder="placeholder || $t('i18n.overall.searchInfo.selectVal')"
    >
      <!--&lt;!&ndash;:allow-create="true"&ndash;&gt; 根据TSG-9309 问题关闭创建条目需求 后期有其他需求再另加判断-->
      <template v-for="(item,index) in optionsCopy">
        <el-option
          :id="item.value"
          v-idscope
          :disabled="item.disabled"
          :label="item.label"
          :value="item.value">
        </el-option>
      </template>
    </el-select>
</template>

<script>
  import lodashCloneDeep from 'lodash/cloneDeep'
  import getTxt1CursorPosition from "./cursorPosition";
  export default {
    name: "v-select",
    props: ['value', 'collapseTags', 'options', 'multiple', 'filterable', 'disabled', 'clearable', 'wrapper','placeholder'],
    data () {
      return {
        optionsCopy: [],    //下拉框的值
        valCopy: null,      //绑定值
        loading: false,
      }
    },
    model: {
      prop: 'value',
      event: 'change'
    },
    created () {
      this.value ? this.valCopy = lodashCloneDeep(this.value) : '';
      this.setOptions()
    },
    mounted () {

    },
    methods: {
      handleKeydown(e) {
        var keyCode = window.event ? e.keyCode : e.which;
        var dom =this.$refs.select ? $(this.$refs.select.$el).find('input')[0] :'';
        var cursorIndex = dom ? getTxt1CursorPosition(dom, document) || 0 : 0;
        //删除事件
        if (keyCode === 8) {
          if (this.$refs.select.query === "" || this.$refs.select.query == null ) {
            this.$emit("blur");
            this.$emit("del")
          }
        }
        // if (keyCode === 13) {  //回车
        //   this.$emit("blur")
        // }
        if (keyCode === 37) { //左箭头  || 38 右箭头
          if (dom && cursorIndex === 0) {
            this.$refs.select.visible=false
            this.$emit("blur")
            this.$emit("move", 'left')
          }
          return
        }
        if (keyCode === 39) { //左箭头  || 38 右箭头
          if (!this.$refs.select.query || cursorIndex === this.$refs.select.query.length) {
            this.$refs.select.visible=false
            this.$emit("blur")
            this.$emit("move", 'right')
          }
        }
      },
      triggerFocus(){
        this.$emit("active")
        this.$nextTick(() => {
          //触发 下拉事件
          var dom = this.$refs.select.$el.children[0];    //获取输入框DOM 索引
          dom.click();
        })
        // this.$nextTick(() => {
        //   this.$refs.select.visible=true
        // })
      },
      visibleChangeHandle (status) {
        //放弃 原生事件, 重写聚焦 失焦事件(原因 里面有个输入框, 不好界定 聚焦 失焦)
        if(status === false){
          this.$emit("blur")
        }else {
          this.$emit("focus")
        }
      },
      setOptions(){
        this.optionsCopy = this.options ? lodashCloneDeep(this.options) : []
        // if (typeof this.options === Function) {
        //   this.options=[];
        //   this.loading=true;
        //   this.options().then(options=>{
        //     this.loading=false;
        //     this.optionsCopy =options
        //   });
        // }else {
        //   this.optionsCopy = this.options ? lodashCloneDeep(this.options) : []
        // }
      }
    },
    watch: {
      options (n, o) {
        //监听下拉数据的变化
        this.optionsCopy = this.options ? [...this.options] : []
      },
      valCopy (n, o) {
        if (this.value !== n) {
          this.$emit('change', this.valCopy)
        }
      },
      value (n, o) {
        this.valCopy = n
      }
    }
  }
</script>

<style lang="less" scoped>
  .v-select{
    width: auto;
  }
  /deep/ .el-input__suffix{
    display: none;
  }
  /deep/ input{
    padding-left: 0 !important;
  }
</style>
