package com.example.modules.dns.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.modules.dns.domain.ScanResult;

import java.util.Map;

public interface ScanResultService extends IService<ScanResult> {


	Map<String, Object> queryDo53DataCountByDnsType(Map<String,Object> params,Integer dnsType);

}
