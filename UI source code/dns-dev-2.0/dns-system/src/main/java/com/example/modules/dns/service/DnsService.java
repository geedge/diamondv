package com.example.modules.dns.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.modules.dns.domain.DohAttribute;
import com.example.modules.dns.domain.IpInformation;
import com.example.utils.page.PageUtils;

import java.util.List;
import java.util.Map;

public interface DnsService extends IService<DohAttribute> {


    PageUtils queryPage(Map<String, Object> params);

    Map<String, Object> dataCount(Map<String, Object> params);

    Map<String, List<Map<String, Object>>> mapData();
}
