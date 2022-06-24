<template>
  <div class="count">
    <ul class="count_list">
      <!-- 时间轴 -->
      <li>
        <Time />
      </li>
      <!-- DNS-DoH世界分布 -->
      <li>
        <div class="nav">
          <p>DoH世界分布</p>
        </div>
        <div class="charts">
          <!-- 右侧图表 -->
          <div class="DOHSJ">
            <DOHSJ
              v-if="maplist.dohWorldMapDataList != undefined"
              :dohsj="maplist.dohWorldMapDataList"
            />
          </div>
          <div class="solid">
            <ul>
              <!-- 左侧排序 -->
              <li
                v-for="(item, index) in demolist(maplist.dohWorldMapDataList,8)"
                :key="index"
              >
                <div class="first_column">{{ item.country }}</div>
                <div class="second_column">
                  <el-progress
                    id="text"
                    :percentage="getPercentage(item.count,maplist.dohWorldMapDataList[0].count)"
                    :stroke-width="12"
                  />
                </div>
                <div class="third_column">{{ item.count }}</div>
              </li>
            </ul>
          </div>
        </div>
      </li>
      <!-- DoH中国分布 -->
      <li>
        <div class="nav">
          <p>DoH中国分布</p>
        </div>
        <div class="charts">
          <!-- 左侧图表 -->
          <div class="DOHSJ">
            <DOHZG
              v-if="maplist.dohChinaMapList != undefined"
              :dohzg="maplist.dohChinaMapList"
            />
          </div>
          <!-- 右侧排序 -->
          <div class="solid">
            <ul>
              <li
                v-for="(item, index) in demolist(maplist.dohChinaMapList, 8)"
                :key="index"
              >
                <div class="first_column">{{ item.province }}</div>
                <div class="second_column">
                  <el-progress
                    id="text"
                    :percentage="
                      getPercentage(
                        item.count,
                        maplist.dohChinaMapList[0].count
                      )
                    "
                    :stroke-width="12"
                  />
                </div>
                <div class="third_column">{{ item.count }}</div>
                <br>
              </li>
            </ul>
          </div>
        </div>
      </li>
      <!-- DNS-Do53世界分布 -->
      <li>
        <div class="nav">
          <p>DNS-Do53世界分布</p>
        </div>
        <div class="charts">
          <div class="DOHSJ">
            <DO53SJ
              v-if="maplist.do53WorldMapDataList != undefined"
              :do53sj="maplist.do53WorldMapDataList"
            />
          </div>
          <div class="solid">
            <ul>
              <li
                v-for="(item, id) in demolist(maplist.do53WorldMapDataList, 8)"
                :key="id"
              >
                <div class="first_column">{{ item.country }}</div>
                <div class="second_column">
                  <el-progress
                    id="text"
                    :percentage="
                      getPercentage(
                        item.count,
                        maplist.do53WorldMapDataList[0].count
                      )
                    "
                    :stroke-width="12"
                  />
                </div>
                <div class="third_column">{{ item.count }}</div>
              </li>
            </ul>
          </div>
        </div>
      </li>
      <!-- DNS-Do53中国分布 -->
      <li>
        <div class="nav">
          <p>Do53中国分布</p>
        </div>
        <div class="charts">
          <!-- 左侧图表 -->
          <div class="DOHSJ">
            <DO53ZG
              v-if="maplist.do53ChinaMapList != undefined"
              :do53zg="maplist.do53ChinaMapList"
            />
          </div>
          <!-- 右侧排序 -->
          <div class="solid">
            <ul>
              <li
                v-for="(item, id) in demolist(maplist.do53ChinaMapList, 8)"
                :key="id"
              >
                <div class="first_column">{{ item.province }}</div>
                <div class="second_column">
                  <el-progress
                    id="text"
                    :percentage="
                      getPercentage(
                        item.count,
                        maplist.do53ChinaMapList[0].count
                      )
                    "
                    :stroke-width="12"
                  />
                </div>
                <div class="third_column">{{ item.count }}</div>
              </li>
            </ul>
          </div>
        </div>
      </li>
      <!-- Do53Forwarder世界分布 -->
      <li>
        <div class="nav">
          <p>Do53Forwarder世界分布</p>
        </div>
        <div class="charts">
          <!-- 右侧图表 -->
          <div class="DOHSJ">
            <Do53Forwarder
              v-if="maplist.do53ForwarderList != undefined"
              :do53forwarder="maplist.do53ForwarderList"
            />
          </div>
          <div class="solid">
            <ul>
              <!-- 左侧排序 -->
              <li
                v-for="(item, id) in demolist(maplist.do53ForwarderList, 8)"
                :key="id"
              >
                <div class="first_column">{{ item.country }}</div>
                <div class="second_column">
                  <el-progress
                    id="text"
                    :percentage="
                      getPercentage(
                        item.count,
                        maplist.do53ForwarderList[0].count
                      )
                    "
                    :stroke-width="12"
                  />
                </div>
                <div class="third_column">{{ item.count }}</div>
              </li>
            </ul>
          </div>
        </div>
      </li>
      <!-- egress-dns世界分布 -->
      <li>
        <div class="nav">
          <p>egress-dns世界分布</p>
        </div>
        <div class="charts">
          <!-- 右侧图表 -->
          <div class="DOHSJ">
            <Do53Egressdns
              v-if="maplist.do53EgressDnsList != undefined"
              :do53egressdns="maplist.do53EgressDnsList"
            />
          </div>
          <div class="solid">
            <ul>
              <!-- 左侧排序 -->
              <li
                v-for="(item, id) in demolist(maplist.do53EgressDnsList, 8)"
                :key="id"
              >
                <div class="first_column">{{ item.country }}</div>
                <div class="second_column">
                  <el-progress
                    id="text"
                    :percentage="
                      getPercentage(
                        item.count,
                        maplist.do53EgressDnsList[0].count
                      )
                    "
                    :stroke-width="12"
                  />
                </div>
                <div class="third_column">{{ item.count }}</div>
              </li>
            </ul>
          </div>
        </div>
      </li>
      <!-- fwd/rdns世界分布 -->
      <li>
        <div class="nav">
          <p>fwd/rdns世界分布</p>
        </div>
        <div class="charts">
          <!-- 右侧图表 -->
          <div class="DOHSJ">
            <Do53Fwdrdns
              v-if="maplist.do53FwdRdnsList != undefined"
              :do53fwdrdns="maplist.do53FwdRdnsList"
            />
          </div>
          <div class="solid">
            <ul>
              <!-- 左侧排序 -->
              <li
                v-for="(item, id) in demolist(maplist.do53FwdRdnsList, 8)"
                :key="id"
              >
                <div class="first_column">{{ item.country }}</div>
                <div class="second_column">
                  <el-progress
                    id="text"
                    :percentage="
                      getPercentage(
                        item.count,
                        maplist.do53FwdRdnsList[0].count
                      )
                    "
                    :stroke-width="12"
                  />
                </div>
                <div class="third_column">{{ item.count }}</div>
              </li>
            </ul>
          </div>
        </div>
      </li>
      <!-- open-rdns世界分布 -->
      <li>
        <div class="nav">
          <p>open-rdns世界分布</p>
        </div>
        <div class="charts">
          <!-- 右侧图表 -->
          <div class="DOHSJ">
            <Do53Opendns
              v-if="maplist.do53OpenRdnsList != undefined"
              :do53opendns="maplist.do53OpenRdnsList"
            />
          </div>
          <div class="solid">
            <ul>
              <!-- 左侧排序 -->
              <li
                v-for="(item, id) in demolist(maplist.do53OpenRdnsList, 8)"
                :key="id"
              >
                <div class="first_column">{{ item.country }}</div>
                <div class="second_column">
                  <el-progress
                    id="text"
                    :percentage="
                      getPercentage(
                        item.count,
                        maplist.do53OpenRdnsList[0].count
                      )
                    "
                    :stroke-width="12"
                  />
                </div>
                <div class="third_column">{{ item.count }}</div>
              </li>
            </ul>
          </div>
        </div>
      </li>
      <!-- nonstandard世界分布 -->
      <li>
        <div class="nav">
          <p>nonstandard世界分布</p>
        </div>
        <div class="charts">
          <!-- 右侧图表 -->
          <div class="DOHSJ">
            <Do53Nonstandard
              v-if="maplist.do53NonstandardList != undefined"
              :do53nonstandard="maplist.do53NonstandardList"
            />
          </div>
          <div class="solid">
            <ul>
              <!-- 左侧排序 -->
              <li
                v-for="(item, id) in demolist(maplist.do53NonstandardList, 8)"
                :key="id"
              >
                <div class="first_column">{{ item.country }}</div>
                <div class="second_column">
                  <el-progress
                    id="text"
                    :percentage="
                      getPercentage(
                        item.count,
                        maplist.do53NonstandardList[0].count
                      )
                    "
                    :stroke-width="12"
                  />
                </div>
                <div class="third_column">{{ item.count }}</div>
              </li>
            </ul>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
import Time from '../../components/Echarts/Time.vue'
import DOHSJ from '../../components/Echarts/Dohsj.vue'
import DOHZG from '../../components/Echarts/Dohzg.vue'
import DO53SJ from '../../components/Echarts/Do53sj.vue'
import DO53ZG from '../../components/Echarts/Do53zg.vue'
import Do53Forwarder from '../../components/Echarts/Do53Forwarder.vue'
import Do53Egressdns from '../../components/Echarts/Do53Egressdns.vue'
import Do53Fwdrdns from '../../components/Echarts/Do53Fwdrdns.vue'
import Do53Opendns from '../../components/Echarts/Do53Openrdns.vue'
import Do53Nonstandard from '../../components/Echarts/Do53Nonstandard.vue'
import { mapActions, mapGetters } from 'vuex'
export default {
  components: {
    Time,
    DOHSJ,
    DOHZG,
    DO53SJ,
    DO53ZG,
    Do53Forwarder,
    Do53Egressdns,
    Do53Fwdrdns,
    Do53Opendns,
    Do53Nonstandard
  },
  data() {
    return {}
  },
  computed: {
    ...mapGetters({
      maplist: 'searchlist/maplist'
    })
  },
  // created(){
  //   this.cmap()
  // },

  methods: {
    ...mapActions({
      maplistActions: 'searchlist/maplistActions'
    }),
    demolist(data, number) {
      if (data != undefined) {
        var newData = data.filter((item, i) => {
          return i < number
        })
        return newData
      }
    },
    getPercentage(value, maxValue) {
      return (value / this.ceilNumber(maxValue)) * 100
    },
    ceilNumber(number) {
      let bite = 0
      if (number < 10) {
        return 10
      }
      if (number < 100) {
        return Math.ceil(number) * Math.pow(10, 1)
      }
      while (number >= 100) {
        number /= 10
        bite += 1
      }
      return Math.ceil(number) * Math.pow(10, bite)
    }
  },
  mounted() {
    this.maplistActions()
  }
}
</script>

<style lang="scss" scoped>
.count {
  width: 100%;
  .count_list {
    width: 100%;
    padding: 0;
    margin: 0;
    li {
      width: 100%;
      list-style: none;
      .nav {
        width: 100%;
        background-color: white;
        border-bottom: 1px solid #dcdcdc;
        height: 50px;
        line-height: 50px;
        padding: 0px 20px;
        font-weight: bolder;
      }
      .charts {
        background-color: white;
        display: flex;
        // width: 100%;
        justify-content: space-evenly;
        align-items: center;
        .DOHSJ {
          width: 500px;
          height: 300px;
        }
        .solid {
          width: 50%;
        }
        .solid ul {
          padding-left: 0px;
        }
        .solid ul li {
          // width:50%;
          // background-color: yellow;
          line-height: 30px;
          display: flex;
          justify-content: flex-end;
          align-items: center;
          .first_column {
            padding-right: 10px;
          }
          .second_column {
            width: 360px;
          }
          @media only screen and (min-width: 768px) and (max-width: 1370px) {
            .second_column {
            width: 320px;
          }
          }
          // @media only screen and (min-width: 1371px) and (max-width: 2400px) {
          //   .dashboard-container .text >>> .massage {
          //     width: 63%;
          //   }
          // }
        }
      }
    }
  }
}
#text >>> .el-progress-bar {
  width: 360px !important;
  .el-progress-bar__inner {
    background-color: #4608ad;
  }
}
#text >>> .el-progress__text {
  display: none !important;
}
</style>
