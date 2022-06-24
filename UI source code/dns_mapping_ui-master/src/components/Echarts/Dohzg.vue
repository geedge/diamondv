<template>
  <div id="map" ref="dohzg" :style="{ width: '100%', height: '100%' }" />
</template>
<script>
import chinaGeoCoordMap from '../../utils/chinamap'
import echarts from 'echarts'
export default {
  name: 'Map',
  props: ['dohzg'],
  data() {
    return {}
  },
  mounted() {
    // console.log(this.dohzg,234);
    var myChartContainer = document.getElementById('map')
    // 获取自适应的高度和宽度
    var resizeMyChartContainer = function() {
      myChartContainer.style.height = 300 + 'px'
      myChartContainer.style.width = 600 + 'px'
      if (window.innerWidth > 768 && window.innerWidth < 1370) {
        myChartContainer.style.width = 500 + 'px'
      }
    }
    // 设置容器高和宽
    resizeMyChartContainer()
    var map = echarts.init(myChartContainer)
    const option = {}
    map.setOption(option)
    const dohzglist = this.changeKey(this.dohzg, ['name', 'value'])
    // console.log(dohzglist,234);
    this.initditu(dohzglist, chinaGeoCoordMap.chinaGeoCoordMap)
  },
  methods: {
    changeKey(arr, key) {
      const newArr = []
      arr.forEach((item, index) => {
        const newObj = {}
        for (var i = 0; i < key.length; i++) {
          newObj[key[i]] = item[Object.keys(item)[i]]
        }
        newArr.push(newObj)
      })
      return newArr
    },

    initditu(dataCount, chinaGeoCoordMap) {
      // console.log(dataCount,1111);
      var datasa = dataCount
      // var chinaDatas = this.transmitData;
      // 基于准备好的dom，初始化echarts实例
      const map = this.$echarts.init(document.getElementById('map'))
      // var chinaDatas = transmitData;

      var series = []
      var color = ['#57df1c'];
      [['', this.chinaDatas]].forEach(function(item, i) {
        // console.log(item, 123);
        series.push(
          {
            type: 'lines'
          },
          {
            type: 'effectScatter',
            coordinateSystem: 'geo'
          },
          // 被攻击点
          {
            type: 'effectScatter',
            coordinateSystem: 'geo',
            zlevel: 2
          },
          {
            type: 'map',
            map: 'china',
            geoIndex: 0,
            aspectScale: 0.75, // 长宽比
            showLegendSymbol: false, // 存在legend时显示
            label: {
              normal: {
                show: true
              },
              emphasis: {
                show: false,
                textStyle: {
                  color: '#fff'
                }
              }
            },
            roam: true,
            animation: false,
            data: datasa
          }
        )
      })

      map.setOption({
        tooltip: {
          trigger: 'item',
          formatter: function(val) {
            if (val.data == null) return
            return val.data.name + ': ' + val.data.value
          }
        },
        visualMap: {
          show: true,
          min: 0,
          max: 200,
          left: 'left',
          top: 'bottom',
          text: ['max', 'min'], // 文本，默认为数值文本
          calculable: true,
          seriesIndex: [3],
          inRange: {
            color: ['#d9e4ff', '#4608AD']
          }
        },
        geo: {
          map: 'china',
          roam: true, // 是否允许缩放
          zoom: 1.14,
          label: {
            emphasis: {
              show: true
            }
          },
          itemStyle: {
            normal: {
              show: false,
              color: 'rgba(48,97,186,0)', // 地图背景色
              borderColor: '#000' // 省市边界线
            },
            emphasis: {
              show: false,
              color: '#ff6347' // 悬浮背景
            }
          }
        },
        series: series
      })
    }
  }
}
</script>
<style scoped>
</style>
