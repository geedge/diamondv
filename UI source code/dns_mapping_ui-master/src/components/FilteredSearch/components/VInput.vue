<template>
  <!-- input 类型 -->
  <el-input size="mini"
            class="rel-input v-input"
            ref="input"
            :maxlength="255"
            :autoComplete="autoComplete || 'off'"
            autosize
            v-bind="$props"
            v-on="$listeners"
            v-model="valCopy"
            @keydown.native="handleKeydown"
            :placeholder="placeholder || $t('i18n.overall.searchInfo.inputVal')"
  >
  </el-input>
</template>

<script>
  import getTxt1CursorPosition from './cursorPosition'
  import lodashCloneDeep from 'lodash/cloneDeep'

  export default {
    name: "v-input",
    data() {
      return {
        valCopy: null,
      }
    },
    props: ['value', 'type', 'rows', 'disabled', 'maxlength', 'autoComplete', 'showPassword', 'placeholder'],
    model: {
      prop: 'value',
      event: 'change'
    },
    created() {
      this.valCopy = lodashCloneDeep(this.value)
    },
    mounted() {
    },
    methods: {
      handleKeydown(e) {
        var dom = this.$refs.input ? $(this.$refs.input.$el).find('input')[0] : '';
        var cursorIndex = dom ? getTxt1CursorPosition(dom, document) || 0 : 0;
        var keyCode = window.event ? e.keyCode : e.which;
        //删除事件
        if (keyCode === 8) {
          if (this.valCopy === "" || this.valCopy == null) {
            this.$emit("del")
          }
          return
        }
        if (keyCode === 13) {  //回车
          this.$emit("blur")
          return
        }

        if (keyCode === 37) { //左箭头  || 37 右箭头
          if (dom && cursorIndex === 0) {
            this.$emit("move", 'left')
          }
          return
        }
        if (keyCode === 39) { //右箭头  || 39 右箭头
          if (!this.valCopy || cursorIndex === this.valCopy.length) {
            this.$emit("move", 'right')
          }
          return
        }
      },
      triggerFocus() {
        this.$emit("active")
        this.$nextTick(() => {
          //并非 触发聚焦事件 而是光标移入 类似
          var dom = this.$refs.input.$el.children[0];    //获取输入框DOM 索引
          dom.focus();
        })
      }
    },
    watch: {
      valCopy(n, o) {
        if (this.value !== n) {
          this.$emit('change', this.valCopy)
        }
      },
      value(n, o) {
        this.valCopy = n
      }
    }
  }
</script>

<style lang="less" scoped>
  /deep/ .el-input__inner {
    padding-left: 0 !important;
    min-width: 180px;
    font-size: 12px;
  }
</style>
