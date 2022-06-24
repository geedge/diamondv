<template>
  <div class="log">
    <img :src="logo" alt="">
    <p>DiamondV</p>
  </div>
</template>

<script>
import Logo from '@/assets/images/newlogo.png'
export default {
  data() {
    return {
      logo: Logo
    }
  }
}
</script>

<style lang="scss" scoped>

.log{
  width: 13%;
  height: 56px;
  background-color: #4608ad;
  color: white;
  text-align: center;
  display: flex;
  justify-content:center;
  align-items: center;
  font-size: 25px;
  font-weight: 600;
  p{
    font-family:"仿宋";
    font-style:italic;
    font-size: 20px;
  }
  img{
    margin-right: 18px;
    width: 50px;
    height: 55px;
  }
}

</style>
