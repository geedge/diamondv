<template>
  <!-- <div id="Time" class="Time"  :style="{height:height,width:width}" /> -->
 <div class="wrapper">
    <div id="Time" class="chart" />
  </div>
</template>

<script>
import echarts from 'echarts'
export default {
 
  data() {
    return {
      
    }
  },
  mounted() {
    // this.initChart()
    var myChartContainer = document.getElementById('Time')
    
    // 获取自适应的高度和宽度
    var resizeMyChartContainer = function() {
      // myChartContainer.style.height = window.innerHeight * 0.65 + 'px';
      // myChartContainer.style.width = window.innerWidth * 0.75 + 'px';
      myChartContainer.style.height = 100 + 'px'
      myChartContainer.style.width = 1182+'px'
       if (window.innerWidth > 768 && window.innerWidth < 1370) {
        myChartContainer.style.width = 945 + 'px'
      }
    }
    // 设置容器高和宽
    resizeMyChartContainer()
    var myChart = echarts.init(myChartContainer)
    const option = {}
    myChart.setOption(option)
    this.initChart()
  },
  methods: {
    initChart() {
    //   this.chart = echarts.init(this.$el, 'macarons')
    const chart = echarts.init(document.getElementById('Time'))
      // 监听屏幕变化自动缩放图表
      window.addEventListener('resize', function() {
        chart.resize()
      })
    

      
      chart.setOption({
        baseOption: {
          timeline: {
            axisType: 'category',
            autoPlay: true,
            playInterval: 1000,
            data: [
              '2002-01-01', '2003-01-01', '2004-01-01',
              {
                value: '2005-01-01',
                tooltip: {
                  formatter: '{b} GDP达到一个高度'
                },
                symbol: 'diamond',
                symbolSize: 16
              },
              '2006-01-01', '2007-01-01', '2008-01-01', '2009-01-01', '2010-01-01',
              {
                value: '2011-01-01',
                tooltip: {
                  formatter: function(params) {
                    return params.name + 'GDP达到又一个高度'
                  }
                },
                symbol: 'diamond',
                symbolSize: 18
              }
            ],
            label: {
              formatter: function(s) {
                return (new Date(s)).getFullYear()
              }
            }
          },
         
          calculable: true,
     
        
          series: [
            
          ]
        },
        options: [
         
          
        ]
      })
    }
  }
}
</script>
<style scoped>
.wrapper {
  width: 100%;
}
</style>