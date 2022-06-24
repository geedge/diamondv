package com.example.modules.dns.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.modules.dns.domain.ForwardDns;
import com.example.modules.dns.domain.NonstandardDns;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface NonstandardDnsDao extends BaseMapper<NonstandardDns> {



}
