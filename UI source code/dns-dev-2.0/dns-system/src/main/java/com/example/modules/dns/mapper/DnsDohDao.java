package com.example.modules.dns.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.modules.dns.domain.DohAttribute;
import com.example.modules.dns.domain.IpInformation;
import com.example.modules.dns.domain.Result;
import com.example.modules.dns.domain.ScanResult;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface DnsDohDao extends BaseMapper<DohAttribute> {

    List<Result> queryDohPage(IPage page, @Param("params") Map<String, Object> params);

    //省份数据统计
    List<Map<String, Object>> dohProvinceCount(@Param("params") Map<String, Object> params);

    int dohIpCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> dohPortCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> dohAndDo53ProvinceCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> dohProviderCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> dohAndDo53ProviderCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> dohComponentCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> dohAndDo53ComponentCount(@Param("params") Map<String, Object> params);

    Map<String, Object> dohServiceCategoryCount(@Param("params") Map<String, Object> params);

    int dohResultTotalCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> dohVulnerabilityCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> dohAndDo53VulnerabilityCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> dohCountryCount();

    List<Map<String, Object>> dohChinaMapCount();

    List<Result> getDohRepBody(String ip, Integer port, String host, Integer rounds);

    List<Result> selectDohInfoByUnion(@Param("params") Map<String, Object> params);

    Integer selectDohCountByUnion(@Param("params") Map<String, Object> params);

    /**
     * 查询 doh 和 do53 交集下的port ip数量
     * @param params
     * @return
     */
    List<Map<String, Object>> countDohPortUnion(@Param("params") Map<String, Object> params);

    /**
     * 统计 doh和do53公共ip的省份分布
     * @param params
     * @return
     */
    List<Map<String, Object>> getDohAndDo53ProvinceCount(@Param("params") Map<String, Object> params);

    /**
     * 统计 doh和do53公共ip的运营商分布
     * @param params
     * @return
     */
    List<Map<String, Object>> getDohAndDo53ProviderCount(@Param("params") Map<String, Object> params);

    /**
     * 统计 doh和do53公共ip的组件分布
     * @param params
     * @return
     */
    List<Map<String, Object>> getDohAndDo53ComponentCount(@Param("params") Map<String, Object> params);

    /**
     * 统计 doh 和 do53公共ip 服务类别统计
     * @param params
     * @return
     */
    Map<String, Object> getDohServiceCategoryCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> getDohAndDo53VulnerabilityCount(@Param("params") Map<String, Object> params);
}
