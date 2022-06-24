package com.example.modules.dns.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.modules.dns.domain.DohAttribute;
import com.example.modules.dns.domain.IpCert;
import com.example.modules.dns.domain.ScanResult;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface IpCertDao extends BaseMapper<IpCert> {

    List<DohAttribute> queryDohPage(IPage page, @Param("params") Map<String, Object> params);

    //    国家数据统计
    List<Map<String, Object>> countryCount();

    //省份数据统计
    List<Map<String, Object>> provinceCount();

    // 城市数据统计
    List<Map<String, Object>> cityCount();


    List<ScanResult> queryDo53Page(IPage page, @Param("params") Map<String, Object> params);
}
