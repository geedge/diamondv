<template>
  <div class="filtered-search-container" v-clickoutside="handleClickoutside" v-idscope id="filtersearch">
    <!-- 搜索框容器  -->
    <div class="filtered-search-box" :class="isFocus ? 'focus':''">
      <!-- 历史记录下拉菜单...` -->
      <!-- <recent-search ref="historySearch" @selectHistory="setDefaultItems"/> -->
      <!-- <el-divider direction="vertical" class="divider"></el-divider> -->
      <div class="scroll-container">
        <div class="list-container">
          <search-item
            :key="item.id"
            v-for="(item,index) in selectItems"
            :id="item.label"
            @del="handleDel"
            @active="handleActive"
            @moveTo="handleMove"
            @clickItem="handleClickItem"
            :currentIndex="index"
            :isLast="index === selectItems.length-1"
            :selectItem="item" :ref="'selectItem'+index"/>
          <el-select
            id="select-label"
            ref="select"
            :popper-append-to-body="true"
            popper-class="select-popper select-list-zindex"
            class="label-select"
            v-if="conditionConfig.isShow"
            v-model="conditionConfig.currentCondition"
            @change="addCondition"
            @focus="handleFocus"
            @blur="handleBlur"
            size="mini"
            remote
            filterable
            :allow-create="false"
            default-first-option
            @keydown.native="handleKeydown"
            @visible-change="visibleChangeHandle"
            placeholder="请输入检索内容">
            <template v-for="item in conditionConfig.conditionList">
              <el-option
                :id="item.id"
                v-idscope
                :disabled="item.disabled === true"
                :key="item.id"
                v-if="item.visible!==false"
                :label="item.name"
                :value="item.id">
              </el-option>
            </template>
          </el-select>
        </div>
      </div>
      <i id="searchClear" v-if="selectItems && selectItems.length>0" class="el-icon-close clear-icon"
         @click="handleClear"></i>
    </div>
    <i id="searchQuery" class="el-icon-search  search-icon" @click="handleQuery"></i>
  </div>
</template>

<script>
  /*
  * {
          id: 1,
          name: 'ID',
          icon: 'iconfont icon-id',
          type: 'input',
          label: 'profileId',
          disabled: false,
          visiable:true,
          value:''
      },
  * */
  // import fireKeyEvent from './components/keyboard'
  import searchHistory from './components/historyApi'
  import SearchItem from './components/SearchItem.vue'
  import lodashCloneDeep from 'lodash/cloneDeep'
  import getTxt1CursorPosition from './components/cursorPosition'
  import {cloneDeep, debounce} from "lodash";


  export default {
    name: "FilteredSearch",
    components: {
      // GlIcon,
      RecentSearch: () => import('./components/RecentSearch.vue'),
      SearchItem
    },
    props: {  //参数 ...
      historyKey: {},
      sourceList: {}, //原始 查询条件列表
      defaultList: {} //默认选中值 --可选
    },
    data() {
      return {
        //标签列表  可选的参数分类
        conditionConfig: {
          conditionList: [],
          isShow: true,
          currentCondition: "",  //当前搜索条件
          currentIndex: 0        //当前 指针位置
        },
        //选中的数据 ...
        selectItems: [],
        //对外输入框 搜索过滤框
        isFocus: false,
        permission: JSON.parse(localStorage.getItem('permissions'))
      };
    },
    created() {
      this.setDefaultItems()
    },
    methods: {
      sortConditoins() {
        //列表排序 ...
        //  conditionConfig.conditionList

      },
      // handleClickItem() {
      //   // 下拉 和  历史数据悬浮同时存在 问题(预留)
      //   // this.$refs.historySearch ?  this.$refs.historySearch.visible=false :''
      // },
      // handleClickoutside() {

      // },
      handleMove({toIndex, self}) {
        if (toIndex < 0 || toIndex > this.selectItems.length - 1) {
          self.handleBlur()
          return
        }
        this.focusItem(toIndex)
      },
      handleActive({currentIndex, currentItem}) {
        if (currentIndex === this.conditionConfig.currentIndex) {
          return
        }
        // this.conditionConfig.currentCondition=currentItem.id
        this.conditionConfig.currentIndex = currentIndex
      },
      validator(resultMap) {
        var validField = ['id', 'profileId']
        var errList = []
        var reg = /^[\d,]*$/;
        validField.forEach((field) => {
          var val = resultMap[field] || '';
          if (field === 'id' || field === 'profileId') {
            var idList = val.split(',')
            idList.forEach((item) => {
              if (item && !reg.test(item)) {
                errList.push(this.$t('i18n.overall.searchInfo.idValid'))
              } else {
                if (item && (+item >= 2147483647)) {
                  errList.push(this.$t("maxnumTips"))
                }
              }
            })
          }
        });
        return errList
      },
      handleQuery: debounce(function () {
        //执行查询方法  对外抛出查询参数...
        console.log("执行查询方法");
        searchHistory.addItem(this.selectItems, this.historyKey);
        var resultMap = {}
        this.selectItems.forEach((item, index) => {
          resultMap[item.label] = item.value
        });
        //校验查询条件
        var errList = []
        console.log(resultMap);
        errList = this.validator(resultMap) || []
        if (errList.length > 0) {
          this.$message.error(errList[0]);
          return
        }

        this.$emit('query', resultMap, this.selectItems);
        //重新刷新一下  下拉(防止用户反复回车-可以删除)
        this.conditionConfig.isShow = false
        setTimeout(() => {
          this.isFocus = false
          this.conditionConfig.isShow = true
        })
      }, 500),
      handleKeydown(e) {
        var keyCode = window.event ? e.keyCode : e.which;
        //删除事件
        this.$nextTick(() => {
          var dom = this.$refs.select ? $(this.$refs.select.$el).find('input')[0] : '';
          var cursorIndex = dom ? getTxt1CursorPosition(dom, document) || 0 : 0;

          //回车  直接回车搜索(备用)
          if (keyCode === 13) {
            if (this.$refs.select && this.$refs.select.hoverIndex === -1) {
              this.$refs.select.visible = false;
              if (this.isFocus) {
                this.handleQuery()
              }
              this.isFocus = false
            }
          }
          if (keyCode === 8) {
            if (this.$refs.select.query === "" || this.$refs.select.query == null) {
              var focusIndex = this.conditionConfig.currentIndex - 1;
              setTimeout(() => {
                this.focusItem(focusIndex)
              })
            }
          }
          if (keyCode === 37) { //左箭头  || 38 右箭头
            if (cursorIndex === 0) {
              // console.log('左箭头到头了');
              var leftIndex = this.conditionConfig.currentIndex - 1;
              setTimeout(() => {
                this.focusItem(leftIndex)
              })
            }
          }
          if (keyCode === 39) { //左箭头  || 38 右箭头
            if (!this.$refs.select.query || cursorIndex === this.$refs.select.query.length) {
              // console.log('右箭头到头了');
            }
          }
        });
      },
      setDefaultItems(historyList = []) {
        // this.handleClear();
        var permanentItems = [{
          id: -1,
          name: this.$t("i18n.overall.searchList.defaultName"),
        }];
        for(let v of this.sourceList){
          if(v.id === 6||v.id === 666){
            if(!this.permission['system_accounts/system_UserManagement']){
              v.visible=false
            }
          }
        }
        this.conditionConfig.conditionList = permanentItems.concat(this.sourceList);
        //存在 历史记录 就走历史记录, 否则就选中 默认选中值...
        var selectList = [];
        var conditionList = [];

        if (historyList && historyList.length > 0) {
          selectList = historyList;
        } else {
          selectList = this.defaultList;
        }

        conditionList = lodashCloneDeep(this.conditionConfig.conditionList) || [];
        //获取已存在 字段id
        conditionList = conditionList.filter((item, index) => {
          var findIndex = null;
          var findItem = selectList.find((selItem, selIndex) => {
            if (selItem.id === item.id) {
              findIndex = selIndex;
              return true //考虑对象合并
            }
            return false
          });

          if (findItem) {
            return false
          }
          return true
        });
        this.conditionConfig.conditionList = conditionList;
        this.selectItems = selectList
        //点击历史记录输入框聚焦
        if (historyList && historyList.length > 0) {
          this.$nextTick((x) => {
            this.$refs.select.focus()
          })
        }
      },
      visibleChangeHandle(state) {
        if (state) {
          this.isFocus = true
          this.handleClickItem()
        }
      },
      triggerFocus() {
        this.$nextTick(() => {
          if (this.conditionConfig.isShow === true) {
            if (this.conditionConfig.conditionList.length <= 0) {
              return
            }
            var dom = this.$refs.select.$el.children[0];    //获取输入框DOM 索引
            dom.click();
          }
        })
        // setTimeout(() => {
        //   if (this.conditionConfig.isShow === true) {
        //     if (this.conditionConfig.conditionList.length <= 0) {
        //       return
        //     }
        //     var dom = this.$refs.select.$el.children[0];    //获取输入框DOM 索引
        //     dom.click();
        //   }
        // }, 200)
      },
      handleFocus() {
        this.isFocus = true
      },
      handleBlur() {
        this.isFocus = false
      },
      focusItem(index) {
        //选中某一项
        if (this.selectItems && this.selectItems.length > 0) {
          this.$nextTick(() => {
            var lastComponent = this.$refs['selectItem' + index] && this.$refs['selectItem' + index][0];
            lastComponent && lastComponent.handleFocus && lastComponent.handleFocus()
          });
        }
      },
      addCondition(conditionCode) {
        if (conditionCode === -1) {
          this.handleQuery();
          this.conditionConfig.currentCondition = null;
          this.$refs.select.visible = false;
          return
        }
        var currentIndex = null;
        var addItem = this.conditionConfig.conditionList.find((item, index) => {
          if (item.id === conditionCode) {
            currentIndex = index;
            return true
          }
          return false
        });
        //增加一项选中数据 且 删除标签该项
        if (addItem) {
          addItem.value = addItem.defaultVal;
          this.selectItems.push(addItem);
          this.conditionConfig.conditionList.splice(currentIndex, 1)
        }
        //最后一个搜索项 聚焦
        // if (this.selectItems && this.selectItems.length > 0) {
        //   this.$nextTick(() => {
        //     var lastIndex = this.selectItems.length - 1;
        //     var lastComponent = this.$refs['selectItem' + lastIndex] && this.$refs['selectItem' + lastIndex][0];
        //     lastComponent && lastComponent.handleFocus && lastComponent.handleFocus()
        //   });
        // }
        var lastIndex = this.selectItems.length - 1;
        this.focusItem(lastIndex)
        this.conditionConfig.currentCondition = null
        this.conditionConfig.isShow = false
      },
      handleReset() {
        this.selectItems = []
        this.conditionConfig.currentCondition = ""
        this.conditionConfig.currentIndex = 0
      },
      handleClear() {
        this.selectItems.forEach((item, index) => {
          item.value = ''
          this.conditionConfig.conditionList.push(item)
        });
        this.selectItems = [];

        this.conditionConfig.isShow = true
      },
      handleDel(delItem) {
        var delIndex = this.selectItems.findIndex((item, index) => {
          if (delItem.id === item.id) {
            delIndex = index;
            return true
          }
          return false
        });
        this.selectItems.splice(delIndex, 1);
        delItem.value = delItem.defaultVal;
        this.conditionConfig.conditionList.push(delItem);
      }
    },
    watch: {
      isFocus(n, o) {
        this.$emit("focus", n)
      },
      'conditionConfig.isShow': {
        handler(n, o) {
          if (n) {
            //如果是  展示了那么
            this.conditionConfig.currentIndex = this.selectItems.length
          }
        },
        deep: false,
        immediate: true
      },
      sourceList: {
        handler(n, o) {
          this.setDefaultItems()
          // this.conditionConfig.conditionList = n;
        },
        deep: false,
        immediate: false
      },
      selectItems: {
        handler: debounce(function (n, o) {
          //当选中数据变化的时候 ,去修改标签可选择列表项
          this.$emit('change', {
            selectItems: this.selectItems,
            conditionList: this.conditionConfig.conditionList
          })
        }, 100),
        deep: true,
        immediate: false
      }
    }
  };
</script>
<style lang="less" scoped>
  .filtered-search-container {
    /*padding: 0 10px;*/
    display: flex;

    .filtered-search-box {
      flex: 1;
    }

    /deep/ .label-select input.el-input__inner {
      width: 100%;
      padding-right: 10px;
    }
  }

  /* 聚焦样式 */
  .filtered-search-box.focus {
    border-color: #73afea;
    box-shadow: 0 0 4px rgba(115, 175, 234, 0.4);
  }

  .filtered-search-box {
    position: relative;
    display: flex;
    width: 100%;
    min-width: 0;
    border: 1px solid #e5e5e5;
    background-color: #fff;
    border-radius: 4px 0 0 4px;
    /*padding: 2px 0;*/
  }

  .divider {
    height: auto !important;
    margin: 0 !important;
  }

  .list-container {
    list-style: none;
    display: flex;
    position: relative;
    margin-bottom: 0;
    width: auto;
    padding-left: 8px;
    box-sizing: border-box;
  }

  .scroll-container {
    flex: auto;
    overflow-y: auto;
  }

  .clear-icon {
    line-height: 24px;
    padding: 0 10px;
    cursor: pointer;
  }

  /deep/ .el-input--mini .el-input__inner {
    height: 24px;
    line-height: 24px;
    border: none;
    border-radius: unset;
  }

  .label-select {
    flex: auto;
  }

  /deep/ .label-select .el-input__inner {
    padding-left: 0 !important;
    min-width: 180px;
  }

  .list-container {
    white-space: nowrap;
    width: 100%;
  }

  .search-icon {
    line-height: 26px;
    padding: 0 10px;
    cursor: pointer;
    border-radius: 0 4px 4px 0;

    text-align: center;
    background: #31739C;
    color: #ffffff;
  }

  .search-icon:hover {
    background: #2d4b6f;
    color: #fff;
  }

  /deep/ input {
    outline: none;
    box-shadow: none !important;
  }


</style>


