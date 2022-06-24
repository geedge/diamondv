package com.example.modules.dns.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.modules.dns.domain.ScanResult;
import com.example.modules.dns.mapper.DnsDo53Dao;
import com.example.modules.dns.service.ScanResultService;
import com.example.utils.Constant;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Lihe
 * @version 1
 * @description
 * @date 2022/6/8
 */
@Service
public class ScanResultServiceImpl extends ServiceImpl<DnsDo53Dao, ScanResult> implements ScanResultService {


	@Override
	public Map<String, Object> queryDo53DataCountByDnsType(Map<String, Object> params, Integer dnsType) {

		Map<String, Object> resultMap = new HashMap(8);
		List<Map<String, Object>> portList = new ArrayList<>();

		List<Map<String, Object>> serviceCategoryList = new ArrayList<>();
		//端口
		Map<String, Object> portMap = new HashMap<>();
		int count = this.baseMapper.getCountByDnsType(dnsType,params);
		portMap.put("port", Constant.PORT53);
		portMap.put("count", count);
		portList.add(portMap);
		resultMap.put("portList", portList);

		//地域
		resultMap.put("regionList", this.baseMapper.getDo53ProvinceCountByDnsType(dnsType,params));

		//运营商
		resultMap.put("providerList", this.baseMapper.getDo53ProviderCountByDnsType(dnsType,params));

		//服务组件
		resultMap.put("componentList", this.baseMapper.getDo53ComponentCountByDnsType(dnsType,params));

		//服务类别
		Integer serviceCount = this.baseMapper.getDo53SrvCategoryCountByDnsType(dnsType,params);
		Map<String,Object> dnsTypeMap = new HashMap<>(2);
		dnsTypeMap.put("key",DnsQueryEnum.getDnsType(dnsType));
		dnsTypeMap.put("count",serviceCount);
		serviceCategoryList.add(dnsTypeMap);
		Map<String,Object> do53ServiceMap = new HashMap<>(2);
		do53ServiceMap.put("key",Constant.DO53TAG);
		do53ServiceMap.put("count",serviceCount);
		serviceCategoryList.add(do53ServiceMap);
		resultMap.put("serviceCategoryList", serviceCategoryList);

		//漏洞威胁
		resultMap.put("vulnerabilityCountList", this.baseMapper.getDo53VulnerabCountByDnsType(dnsType,params));

		return resultMap;
	}
}
