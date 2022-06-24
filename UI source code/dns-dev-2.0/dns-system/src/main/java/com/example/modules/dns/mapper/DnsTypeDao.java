package com.example.modules.dns.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.modules.dns.domain.DnsType;
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
public interface DnsTypeDao extends BaseMapper<DnsType> {

}
