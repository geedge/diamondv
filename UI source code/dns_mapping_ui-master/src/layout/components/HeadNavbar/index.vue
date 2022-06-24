<template>
  <!-- <div :class="{'has-logo':showLogo}" > -->
  <div class="menu">
    <!--TODO    文章中删除了logo，有验证了一次，可以不删除-->
    <!-- <logo v-if="showLogo" :collapse="isCollapse"/> -->
    <Logo />
    <el-scrollbar id="navlist" wrap-class="scrollbar-wrapper">
      <!--TODO     将el-menu标签下的mode属性更改为horizontal-->
      <!-- <span>1111</span> -->
      <el-menu
        :default-active="activeMenu"
        :collapse="isCollapse"
        :background-color="variables.menuBg"
        :text-color="variables.menuText"
        :unique-opened="false"
        :active-text-color="variables.menuActiveText"
        :collapse-transition="false"
        mode="horizontal"
      >
        <sidebar-item v-for="route in sidebarRouters" :key="route.path" :item="route" :base-path="route.path" />
      </el-menu>
    </el-scrollbar>
    <navbar />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import SidebarItem from './SidebarItem'
import variables from '@/assets/styles/variables.scss'
import Navbar from '../Navbar.vue'
import Logo from './Logo.vue'

export default {
  // components: {Logo },
  components: { SidebarItem, Navbar, Logo },
  computed: {
    ...mapGetters([
      'sidebarRouters',
      'sidebar'
    ]),
    activeMenu() {
      const route = this.$route
      const { meta, path } = route
      // if set path, the sidebar will highlight the path you set
      if (meta.activeMenu) {
        return meta.activeMenu
      }
      return path
    },
    showLogo() {
      return this.$store.state.settings.sidebarLogo
    },
    variables() {
      return variables
    },
    isCollapse() {
      return !this.sidebar.opened
    }
  }
}
</script>
<style lang="scss" scoped>
.menu{
  display: flex;
}
#navlist {
width: 80% !important;
float: left;
}

  #navlist >>> .el-submenu__title {
    font-weight: 100;
      font-size:18px !important;
      color: white !important;
   }
  #navlist >>> .is-active{
      font-size: 18px !important;
      font-weight: 600 !important;
      background-color: rgb(50, 4, 122) !important;
  }
  #navlist >>> .el-scrollbar__wrap{
    margin-bottom: 0px;
    overflow: hidden;
  }
/* .el-scrollbar__view{
  display: flex;
} */

</style>
