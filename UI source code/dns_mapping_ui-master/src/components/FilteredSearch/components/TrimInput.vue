<template>
    <!-- input 类型 -->
    <el-input
              :type="type"
              class="rel-input trim-input"
              ref="input"
              :maxlength="maxlength"
              :autoComplete="autoComplete || 'on'"
              autosize
              v-model="valCopy"
              @keydown.native="handleKeydown"
              :placeholder="placeholder || $t('i18n.overall.placeholder.enter')"
              @blur="trim"
              :disabled='disabled'
              @input="handleName"
              v-bind="$attrs"
              :rows="rows"
              :show-word-limit="showWordLimit"
              :id="$attrs.id+'1'"
    >
    </el-input>
</template>

<script>
  import getTxt1CursorPosition from './cursorPosition'
  import lodashCloneDeep from 'lodash/cloneDeep'

  export default {
    name: "Trim-input",
    data() {
      return {
        valCopy: null,
      }
    },
    props: ['specialCharacters','value', 'type', 'rows', 'disabled', 'maxlength', 'autoComplete', 'showPassword', 'placeholder', 'showWordLimit'],
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
      trim(){
        if(this.valCopy!==''&&this.valCopy!=null){
          this.valCopy = this.valCopy.replace(/(^\s*)|(\s*$)/g, "")
        }
        this.$emit('blur', this.valCopy)
      },
      handleKeydown(e) {
        if(!this.specialCharacters){
            this.valCopy = this.valCopy.replace(/(^\s*)/g, "")
        }
        this.$emit('change', this.valCopy)
      },
      handleName(){
        if(this.specialCharacters){
            let name = this.profileName_regular(this.valCopy)
            this.valCopy = name.replace(/(^\s*)/g, "")
        }
        this.$emit('input',this.valCopy)
      },
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
        padding-left: 10px !important;
        min-width: 180px;
        font-size: 12px;
    }
    /deep/ .el-textarea__inner{
        height: auto !important;
    }
</style>
