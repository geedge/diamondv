package com.example.modules.dns.service.impl;

import com.example.utils.Constant;
import com.example.utils.ElAdminConstant;

import java.util.List;

/**
 * @author Lihe
 * @version 1
 * @description 查询分类
 * @date 2022/6/22
 */
public enum DnsQueryEnum {

	OPEN_RDNS(Constant.OPENRDNSTAG, ElAdminConstant.openRdnsLabels, "openRdns", 1),

	FORWARDER(Constant.FORWARDERTAG, ElAdminConstant.forwarderLabels, "forwarder", 2),

	FWD_RDNS(Constant.FWDRDNSTAG, ElAdminConstant.fwdRdnsLabels, "fwdRdns", 3),

	EGRESS_DNS(Constant.EGRESSRDNSTAG, ElAdminConstant.egressDnsLabels,  "egressDns", 4),

	NON_STANDARD(Constant.NONSTANDARDTAG, ElAdminConstant.nonstandardLabels, "nonstandard", 5),

	DNS(Constant.DNSTAG, ElAdminConstant.dnsLabels,  "queryDnsInfo", 0),

	DOH(Constant.DOH, ElAdminConstant.dohLabels,  "queryDohInfo", 0),

	DO53(Constant.DO53, ElAdminConstant.do53Labels, "queryDo53Info", 0),

	DOH_AND_DO53("dohAndDo53", null,  "queryDohAndDo53Info", 0),

	IP(Constant.IP, null, "queryPageByIp", 0),
	;

	private final String service;

	private final List<String> labels;

	private final String methodName;

	private final Integer dnsType;

	public static DnsQueryEnum getQueryInfo(String serviceName) {
		for (DnsQueryEnum value : DnsQueryEnum.values()) {
			if (value.getService().equals(serviceName)) {
				return value;
			}
		}
		return null;
	}


	public String getMethodName() {
		return methodName;
	}

	public String getService() {
		return service;
	}

	public List<String> getLabels() {
		return labels;
	}

	public Integer getDnsType() {
		return dnsType;
	}

	DnsQueryEnum(String service, List<String> labels, String methodName, Integer dnsType) {
		this.service = service;
		this.labels = labels;
		this.methodName = methodName;
		this.dnsType = dnsType;
	}

	public static List<String> getLabels(String key) {
		for (DnsQueryEnum value : DnsQueryEnum.values()) {
			if (value.getService().equals(key)) {
				return value.getLabels();
			}
		}
		return null;
	}

	public static Integer getDnsType(String key) {
		for (DnsQueryEnum value : DnsQueryEnum.values()) {
			if (value.getService().equals(key)) {
				return value.getDnsType();
			}
		}
		return null;
	}

	public static String getDnsType(Integer type) {
		for (DnsQueryEnum value : DnsQueryEnum.values()) {
			if (value.getDnsType().equals(type)) {
				return value.getService();
			}
		}
		return null;
	}

}



