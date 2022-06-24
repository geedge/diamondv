package com.example.modules.dns.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.modules.dns.domain.DnsType;
import com.example.modules.dns.mapper.DnsTypeDao;
import com.example.modules.dns.service.DnsTypeService;
import org.springframework.stereotype.Service;

@Service
public class DnsTypeServiceImpl extends ServiceImpl<DnsTypeDao, DnsType> implements DnsTypeService {

}



