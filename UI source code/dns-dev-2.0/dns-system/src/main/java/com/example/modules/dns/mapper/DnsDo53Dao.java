package com.example.modules.dns.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.modules.dns.domain.Result;
import com.example.modules.dns.domain.ScanResult;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface DnsDo53Dao extends BaseMapper<ScanResult> {

    List<Result> queryDo53Page(IPage page, @Param("params") Map<String, Object> params);

    int do53IpCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> do53ServiceCategoryCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> do53ProvinceCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> do53ProviderCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> do53ComponentCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> do53VulnerabilityCount(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> do53CountryCount();

    List<Map<String, Object>> do53CountryMapCount();


    List<Map<String, Object>> do53WorldMapCount();

    List<Map<String, Object>> do53ChinaMapCount();

    int pageCount(@Param("params") Map<String, Object> params);

    List<Result> queryOpenRdns(@Param("params")Map<String, Object> params);

    int getCountByDnsType(@Param("dnsType")Integer dnsType,@Param("params") Map<String, Object> params);

    int getIndependentIpNum(@Param("dnsType")Integer dnsType, @Param("params")Map<String, Object> params);

    List<Result> selectScanResultByUnion(IPage page, @Param("params") Map<String, Object> params);

    Integer selectScanResultCountByUnion(@Param("params") Map<String, Object> params);

    List<Map<String, Object>> getDohAndDo53SrvCategoryCount(@Param("params") Map<String, Object> params);

    /**
     * 根据dnsType和其他参数统计ip省份分布
     * @param dnsType
     * @param params
     * @return
     */
    List<Map<String, Object>> getDo53ProvinceCountByDnsType(@Param("dnsType") Integer dnsType, @Param("params") Map<String, Object> params);

    /**
     * 根据dnsType和其他参数统计ip运营商分布
     * @param dnsType
     * @param params
     * @return
     */
    List<Map<String, Object>> getDo53ProviderCountByDnsType(@Param("dnsType") Integer dnsType, @Param("params") Map<String, Object> params);

    List<Map<String, Object>> getDo53ComponentCountByDnsType(@Param("dnsType") Integer dnsType, Map<String, Object> params);

    Integer getDo53SrvCategoryCountByDnsType(@Param("dnsType") Integer dnsType, @Param("params") Map<String, Object> params);

    List<Map<String, Object>> getDo53VulnerabCountByDnsType(@Param("dnsType") Integer dnsType, @Param("params") Map<String, Object> params);
}
