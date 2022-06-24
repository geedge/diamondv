package com.example.modules.dns.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.modules.dns.domain.*;
import com.example.modules.dns.mapper.*;
import com.example.modules.dns.service.DnsService;
import com.example.modules.dns.service.ScanResultService;
import com.example.utils.Constant;
import com.example.utils.page.PageUtils;
import com.example.utils.page.Query;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Method;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class DnsServiceImpl extends ServiceImpl<DnsDohDao, DohAttribute> implements DnsService {
	@Autowired
	private DnsDohDao dnsDohDao;

	@Autowired
	private DnsDo53Dao dnsDo53Dao;

	@Autowired
	private IpCertDao ipCertDao;

	@Autowired
	private IpInformationDao ipInformationDao;

	@Autowired
	private NonstandardDnsDao nonstandardDnsDao;

	@Autowired
	private ScanResultService scanResultService;


	/**
	 * 添加新service查询逻辑时：
	 *  1. 在本类中实现该service的查询逻辑
	 *  2. DnsQueryEnum 添加该查询逻辑的枚举，包括serviceName,方法名，标签和dnsType可根据需要设置
	 *  and 查询逻辑需要单独实现
	 * @param params
	 * @return
	 */
	@Override
	public PageUtils queryPage(Map<String, Object> params) {
		String service = (String) params.get(Constant.SERVICE);
		String port = (String) params.get(Constant.PORT);
		String ip = (String) params.get(Constant.IP);
		IPage page = new Query(IpInformation.class).getPage(params);
		params.put("n", (page.getCurrent() - 1) * page.getSize());   //用作doh查询的分页
		params.put("m", page.getSize());  //用作doh查询的分页
		if(StringUtils.isBlank(service) && StringUtils.isBlank(ip) && StringUtils.isBlank(port)){
			return new PageUtils(page);
		}
		if(StringUtils.isNotBlank(port)){
			if(Constant.PORT53.equals(port)){
				service = Constant.DO53;
			}else if(Constant.PORT443.equals(port) || Constant.PORT8443.equals(port)){
				service = Constant.DOH;
			}
		}
		if(StringUtils.isBlank(port) && StringUtils.isBlank(service) && StringUtils.isNotBlank(ip)){
			service = Constant.IP;
		}
		if(StringUtils.isNotBlank(service)) {
			if(service.toLowerCase().contains("and")){
				return queryDohAndDo53Info(page,params);
			}else {
				// DnsQueryEnum 枚举类获取service对应的方法名，并通过反射调用
				DnsQueryEnum serviceEnum = DnsQueryEnum.getQueryInfo(service.toLowerCase());
				Class<? extends DnsServiceImpl> aClass = this.getClass();
				try {
					Method method = aClass.getDeclaredMethod(serviceEnum.getMethodName(), IPage.class, Map.class);
					return (PageUtils) method.invoke(this, page, params);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return new PageUtils(page);
	}

	@Override
	public Map<String, Object> dataCount(Map<String, Object> params) {
		String service = (String) params.get(Constant.SERVICE);
		String port = (String) params.get(Constant.PORT);
		String ip = (String) params.get(Constant.IP);
		Map<String, Object> resultMap = new HashMap(8);
		if(StringUtils.isBlank(service) && StringUtils.isBlank(ip) && StringUtils.isBlank(port)){
			return resultMap;
		}
		List<Map<String, Object>> portList = new ArrayList<>();
		List<Map<String, Object>> regionList ;
		List<Map<String, Object>> providerList ;
		List<Map<String, Object>> componentList ;
		List<Map<String, Object>> serviceCategoryList = new ArrayList<>();
		List<Map<String, Object>> do53serviceCategoryList ;
		List<Map<String, Object>> vulnerabilityCountList ;
		if (Constant.DOH.equals(service) || Constant.PORT8443.equals(port) || Constant.PORT443.equals(port)) {
			//端口
			portList = dnsDohDao.dohPortCount(params);
			//地域
			regionList = dnsDohDao.dohProvinceCount(params);
			//运营商
			providerList = dnsDohDao.dohProviderCount(params);
			//服务组件
			componentList = dnsDohDao.dohComponentCount(params);
			//服务类别
			Map<String, Object> map = dnsDohDao.dohServiceCategoryCount(params);
			map.put("key", Constant.DOHTAG);
			serviceCategoryList.add(map);
			//漏洞威胁
			vulnerabilityCountList = dnsDohDao.dohVulnerabilityCount(params);

		} else if (Constant.DO53.equals(service) || Constant.PORT53.equals(port)) {
			//端口
			Map<String, Object> portMap = new HashMap<>();
			int do53PortCount = dnsDo53Dao.do53IpCount(params);
			portMap.put("port", Constant.PORT53);
			portMap.put("count", do53PortCount);
			portList.add(portMap);
			//地域
			regionList = dnsDo53Dao.do53ProvinceCount(params);
			//运营商
			providerList = dnsDo53Dao.do53ProviderCount(params);
			//服务组件
			componentList = dnsDo53Dao.do53ComponentCount(params);
			//服务类别
			do53serviceCategoryList = dnsDo53Dao.do53ServiceCategoryCount(params);
			serviceCategoryList = transformDo53serviceCategory(do53serviceCategoryList);
			//漏洞威胁
			vulnerabilityCountList = dnsDo53Dao.do53VulnerabilityCount(params);

		}else if ("dns".equalsIgnoreCase(service) || StringUtils.isNotBlank(ip)) {
			//端口
			portList = dnsDohDao.dohPortCount(params);
			Map<String, Object> portMap = new HashMap<>();
			Integer do53PortCount = dnsDo53Dao.do53IpCount(params);
			portMap.put("port", Constant.PORT53);
			portMap.put("count", do53PortCount);
			portList.add(portMap);
			//地域
			regionList = dnsDohDao.dohAndDo53ProvinceCount(params);
			//运营商
			providerList = dnsDohDao.dohAndDo53ProviderCount(params);
			//服务组件
			componentList = dnsDohDao.dohAndDo53ComponentCount(params);
			//服务类别
			do53serviceCategoryList = dnsDo53Dao.do53ServiceCategoryCount(params);
			serviceCategoryList = transformDo53serviceCategory(do53serviceCategoryList);
			Map<String, Object> map = dnsDohDao.dohServiceCategoryCount(params);
			map.put("key", Constant.DOHTAG);
			serviceCategoryList.add(map);
			//漏洞威胁
			vulnerabilityCountList = dnsDohDao.dohAndDo53VulnerabilityCount(params);
		}else if(service.toLowerCase().contains("and")){
			// 目前只有 doh AND do53其余条件未实现
			//端口
			portList = dnsDohDao.countDohPortUnion(params);

			//地域
			regionList = dnsDohDao.getDohAndDo53ProvinceCount(params);
			//运营商
			providerList = dnsDohDao.getDohAndDo53ProviderCount(params);
			//服务组件
			componentList = dnsDohDao.getDohAndDo53ComponentCount(params);
			//服务类别
			do53serviceCategoryList = dnsDo53Dao.getDohAndDo53SrvCategoryCount(params);
			serviceCategoryList = transformDo53serviceCategory(do53serviceCategoryList);
			Map<String, Object> map = dnsDohDao.getDohServiceCategoryCount(params);
			map.put("key", Constant.DOHTAG);
			map.put("count", dnsDo53Dao.selectScanResultCountByUnion(params));
			serviceCategoryList.add(map);
			//漏洞威胁
			vulnerabilityCountList = dnsDohDao.getDohAndDo53VulnerabilityCount(params);
		}else{
			// dn53下5种 dns_type 统计
			return scanResultService.queryDo53DataCountByDnsType(params,DnsQueryEnum.getDnsType(service));
		}
		resultMap.put("portList", portList);
		resultMap.put("regionList", regionList);
		resultMap.put("providerList", providerList);
		resultMap.put("componentList", componentList);
		resultMap.put("serviceCategoryList", serviceCategoryList);
		resultMap.put("vulnerabilityCountList", vulnerabilityCountList);
		return resultMap;
	}

	@Override
	public Map<String, List<Map<String, Object>>> mapData() {
		Map<String, List<Map<String, Object>>> resultMap = new HashMap<>();
		List<Map<String, Object>> dohChinaMapList ;
		List<Map<String, Object>> dohWorldMapDataList ;
		List<Map<String, Object>> do53CountryMapCountList ;
		List<Map<String, Object>> do53OpenRdnsList = new ArrayList<>();
		List<Map<String, Object>> do53ForwarderList = new ArrayList<>();
		List<Map<String, Object>> do53FwdRdnsList = new ArrayList<>();
		List<Map<String, Object>> do53EgressDnsList = new ArrayList<>();
		List<Map<String, Object>> do53NonstandardList = new ArrayList<>();
		List<Map<String, Object>> do53WorldMapList ;
		List<Map<String, Object>> do53ChinaMapList ;
		dohChinaMapList = dnsDohDao.dohChinaMapCount();
		dohWorldMapDataList = dnsDohDao.dohCountryCount();
		do53WorldMapList = dnsDo53Dao.do53WorldMapCount();
		do53ChinaMapList = dnsDo53Dao.do53ChinaMapCount();
		do53CountryMapCountList = dnsDo53Dao.do53CountryMapCount();
		for (Map<String, Object> map : do53CountryMapCountList) {
			if (Constant.OPENRDNS == map.get("type")) {
				do53OpenRdnsList.add(map);
			} else if (Constant.FORWARDER == map.get("type")) {
				do53ForwarderList.add(map);
			} else if (Constant.FWDRDNS == map.get("type")) {
				do53FwdRdnsList.add(map);
			} else if (Constant.EGRESSRDNS == map.get("type")) {
				do53EgressDnsList.add(map);
			} else if (Constant.NONSTANDARD == map.get("type")) {
				do53NonstandardList.add(map);
			}
		}
		resultMap.put("dohChinaMapList", dohChinaMapList);
		resultMap.put("dohWorldMapDataList", dohWorldMapDataList);
		resultMap.put("do53WorldMapDataList", do53WorldMapList);
		resultMap.put("do53ChinaMapList", do53ChinaMapList);
		resultMap.put("do53OpenRdnsList", do53OpenRdnsList);
		resultMap.put("do53ForwarderList", do53ForwarderList);
		resultMap.put("do53FwdRdnsList", do53FwdRdnsList);
		resultMap.put("do53EgressDnsList", do53EgressDnsList);
		resultMap.put("do53NonstandardList", do53NonstandardList);
		return resultMap;
	}

	public List<Map<String, Object>> transformDo53serviceCategory(List<Map<String, Object>> do53serviceCategoryList) {
		List<Map<String, Object>> serviceCategoryList = new ArrayList<>();
		long do53Count = 0;
		for (Map<String, Object> map : do53serviceCategoryList) {
			Map<String, Object> do53ServiceMap = new HashMap<>();
			long count = (long) map.get("count");
			int dnsType = (int) map.get("type");
			if (Constant.FORWARDER == dnsType) {  //2
				do53ServiceMap.put("key", Constant.FORWARDERTAG);
				do53ServiceMap.put("count", count);
			} else if (Constant.FWDRDNS == dnsType) {//3
				do53ServiceMap.put("key", Constant.FWDRDNSTAG);
				do53ServiceMap.put("count", count);
			} else if (Constant.EGRESSRDNS == dnsType) {    //4
				do53ServiceMap.put("key", Constant.EGRESSRDNSTAG);
				do53ServiceMap.put("count", count);
			} else if (Constant.NONSTANDARD == dnsType) {   //5
				do53ServiceMap.put("key", Constant.NONSTANDARDTAG);
				do53ServiceMap.put("count", count);
			} else if (Constant.OPENRDNS == dnsType) { //1
				do53ServiceMap.put("key", Constant.OPENRDNSTAG);
				do53ServiceMap.put("count", count);
			}
			do53Count += count;
			serviceCategoryList.add(do53ServiceMap);
		}
		HashMap<String, Object> do53Map = new HashMap<>();
		do53Map.put("key", Constant.DO53TAG);
		do53Map.put("count", do53Count);
		serviceCategoryList.add(do53Map);
		return serviceCategoryList;

	}

	/**
	 * 设置doh属性
	 * @param dohAttributes
	 */
	public void setDohData(List<Result> dohAttributes) {
		for (Result dohAttribute : dohAttributes) {
			String uuid = UUID.randomUUID().toString().trim().replaceAll("-", "");
			dohAttribute.setUuid(uuid);
			String dohIp = dohAttribute.getIp();
			Integer port = dohAttribute.getPort();
			String component = dohAttribute.getComponent();
			String path = dohAttribute.getPath();
			dohAttribute.setProtocolType(Constant.PROTOC_TCP);
			dohAttribute.setIpType(getIpType(dohIp));
			if (component != null)
				dohAttribute.setComponentList(new ArrayList<>(Arrays.stream(component.split(",")).collect(Collectors.toSet())));
			if (path != null)
				dohAttribute.setPathList(new ArrayList<>(Arrays.stream(path.split(",")).collect(Collectors.toSet())));
			ArrayList<String> tagList = new ArrayList<>();  //添加服务类别标签
			tagList.add(Constant.DOHTAG);
			List<Object> banner = new ArrayList<>();
			List<Object> httpHeader = new ArrayList<>();
			// 根据ip,port,host，rounds查询doh_attribute rep_body repHeader信息
			List<Result> repList = this.baseMapper.getDohRepBody(dohIp, port, dohAttribute.getHost(), dohAttribute.getRounds());
			for (int i = 0; i < repList.size(); i++) {
				Result result = repList.get(i);
				if (StringUtils.isNotBlank(result.getRepBody())) {
					banner.add(result.getRepBody());
				}
				if (StringUtils.isNotBlank(result.getRepHeader())) {
					httpHeader.add(result.getRepHeader());
				}
			}
			dohAttribute.setBanner(banner);
			dohAttribute.setHttpContent(httpHeader);
			//根据ip和端口查询证书库，获取证书数据
			List<IpCert> ipCertList = ipCertDao.selectList(new LambdaQueryWrapper<IpCert>().eq(IpCert::getIp, dohIp).eq(IpCert::getPort, port));
			dohAttribute.setIpCert(ipCertList);
			dohAttribute.setTags(tagList);
		}
	}

	/**
	 * 设置do53标签，根据dnsType设置banner
	 *  type = 1 banner list.get(0)为rep
	 *  type = 2,3 banner中的 list.get(0)为 query_rep,列表其余数据为ip信息
	 *  type = 5 banner list.get(0)为rep，其余为NonstandardDns列表
	 * @param scanResultList
	 */
	public void setdo53Data(List<Result> scanResultList) {
		for (Result scanResult : scanResultList) {
			String uuid = UUID.randomUUID().toString().trim().replaceAll("-", "");
			scanResult.setUuid(uuid);
			String do53Ip = scanResult.getIp();
			Integer epoch = scanResult.getEpoch();
			Integer dnsType = scanResult.getDnsType();
			ArrayList<String> tagList = new ArrayList<>();  //添加服务类别标签
			tagList.add(Constant.DO53TAG);
			scanResult.setIpType(getIpType(do53Ip));
			scanResult.setProtocolType(getProtocolType(scanResult.getScanType()));
			List<Object> bannerList = new ArrayList<>();
			if (Constant.FORWARDER.equals(dnsType) || Constant.FWDRDNS.equals(dnsType)) {  //2、3
				if (Constant.FWDRDNS.equals(dnsType)) {       //3
					tagList.add(Constant.FORWARDERTAG);
				} else {
					tagList.add(Constant.FWDRDNSTAG);
				}
				bannerList.add(scanResult.getQueryResponse());
				List<IpInformation> forwardDnsList = ipInformationDao.getIpInfoByFwd(do53Ip, epoch);
				bannerList.addAll(forwardDnsList);
			} else if (Constant.EGRESSRDNS.equals(dnsType)) {    //4
				tagList.add(Constant.EGRESSRDNSTAG);

			} else if (Constant.NONSTANDARD.equals(dnsType)) {   //5
				bannerList.add(scanResult.getQueryResponse());
				tagList.add(Constant.NONSTANDARDTAG);
				List<NonstandardDns> nonstandardDnsList = nonstandardDnsDao.selectList(new LambdaQueryWrapper<NonstandardDns>().eq(NonstandardDns::getIp, do53Ip).eq(NonstandardDns::getEpoch, epoch));
				bannerList.addAll((List<JSONObject>) JSONObject.toJSON(nonstandardDnsList));
			} else if (Constant.OPENRDNS.equals(dnsType)) { //1
				tagList.add(Constant.OPENRDNSTAG);
				if(StringUtils.isNotBlank(scanResult.getQueryResponse())){
					bannerList.add(scanResult.getQueryResponse());
				}
			}
			scanResult.setBanner(bannerList);
			scanResult.setTags(tagList);
		}
	}

	/**
	 * @param dataList    目标list
	 * @param pageSize    当前页大小
	 * @param currentPage 当前页
	 * @return 返回当前页的数据集
	 * @deprecated 对list进行分页
	 */
	public List<Result> getPage(List<Result> dataList, int pageSize, int currentPage) {
		List<Result> currentPageList = new ArrayList<>();
		if (!dataList.isEmpty()) {
			int currIdx = (currentPage > 1 ? (currentPage - 1) * pageSize : 0);
			for (int i = 0; i < pageSize && i < dataList.size() - currIdx; i++) {
				Result data = dataList.get(currIdx + i);
				currentPageList.add(data);
			}
		}
		return currentPageList;
	}


	/**
	 * 查询dns信息，dnh和do53（scan_result）结果并集
	 *
	 * @param page
	 * @param params
	 * @return
	 */
	private PageUtils queryDnsInfo(IPage page, Map<String, Object> params) {
		Map<String, Object> indepentIpMap = new HashMap<>(4);
		int resultTotal = 0;
		long pageSize = page.getSize();
		params.put("n", 0);   //用作doh查询的分页偏移量
		params.put("m", page.getCurrent() * page.getSize());  //用作查询的分页大小
		// 查询doh信息
		//同一轮次，相同ip合并path和component，漏洞信息
		List<Result> dohAttributes = dnsDohDao.queryDohPage(null, params);
		setDohData(dohAttributes);
		int dohResultTotal = dnsDohDao.dohResultTotalCount(params);
		indepentIpMap.put("dns-doh", dnsDohDao.dohIpCount(params));
		// 查询do53信息
		List<Result> scanResultList = dnsDo53Dao.queryDo53Page(null, params);
		setdo53Data(scanResultList);
		indepentIpMap.put("dns-do53", dnsDo53Dao.do53IpCount(params));
		int do53ResultTotal = dnsDo53Dao.pageCount(params);

		List<Result> resultList = new ArrayList<>();
		resultList.addAll(dohAttributes);
		resultList.addAll(scanResultList);
		List<Result> collect = resultList.stream().sorted(Comparator.comparing(Result::getTimestamp).reversed()).collect(Collectors.toList());

		page.setTotal(do53ResultTotal + dohResultTotal);
		page.setRecords(getPage(collect, (int) pageSize, (int) page.getCurrent()));

		return buildResult(page,indepentIpMap,(do53ResultTotal + dohResultTotal));
	}

	/**
	 * 查询 do53信息
	 * @param page
	 * @param params
	 * @return
	 */
	private PageUtils queryDo53Info(IPage page, Map<String, Object> params){
		// 根据 service=dns-do53， port为53查询 scan_result表 参数：ip,port
		List<Result> scanResultList = dnsDo53Dao.queryDo53Page(null, params);
		setdo53Data(scanResultList);

		int independentIpNum = dnsDo53Dao.do53IpCount(params);
		int resultTotal = dnsDo53Dao.pageCount(params);
		page.setRecords(scanResultList);
		return buildResult(page,independentIpNum,resultTotal);
	}

	/**
	 * 查询doh信息
	 * @param page
	 * @param params
	 * @return
	 */
	private PageUtils queryDohInfo(IPage page, Map<String, Object> params){
		// 根据 service=dns-do53， port为53查询 scan_result表 参数：ip,port
		List<Result> scanResultList = dnsDohDao.queryDohPage(null, params);
		setDohData(scanResultList);

		int independentIpNum = dnsDohDao.dohIpCount(params);
		int resultTotal = dnsDohDao.dohResultTotalCount(params);
		page.setRecords(scanResultList);
		return buildResult(page,independentIpNum,resultTotal);
	}

	/**
	 * 只根据ip查询
	 * @param page
	 * @param params
	 * @return
	 */
	private PageUtils queryPageByIp(IPage page, Map<String, Object> params){
		// 只根据ip查询
		int independentIpNum = 0;
		params.put("n", 0);   //用作doh查询的分页
		params.put("m", page.getCurrent() * page.getSize());   //用作doh查询的分页
		long pageSize = page.getSize();
		List<Result> dohAttributesList = dnsDohDao.queryDohPage(null, params);
		setDohData(dohAttributesList);
		List<Result> scanResultList = dnsDo53Dao.queryDo53Page(null, params);
		setdo53Data(scanResultList);
		List<Result> resultList = new ArrayList<>();
		resultList.addAll(dohAttributesList);
		resultList.addAll(scanResultList);
		int resultTotal = resultList.size();
		List<Result> collect = resultList.stream().sorted(Comparator.comparing(Result::getTimestamp).reversed()).collect(Collectors.toList());
		if (!collect.isEmpty()) {
			independentIpNum = 1;
		}
		page.setTotal(collect.size());
		page.setRecords(getPage(collect, (int) pageSize, (int) page.getCurrent()));
		return buildResult(page,independentIpNum,resultTotal);
	}

	/**
	 * 查询 dnh和do53（scan_result）结果交集 service = dns-doh AND dns-do53
	 *
	 * @param page
	 * @param params
	 * @return
	 */
	private PageUtils queryDohAndDo53Info(IPage page, Map<String, Object> params) {
		params.put("offset", 0);   //用作doh查询的分页偏移量
		params.put("limit", page.getCurrent() * page.getSize());  //用作查询的分页大小
		Map<String, Object> indepentIpMap = new HashMap<>(4);

		// 查询doh信息
		List<Result> dohAttributes = dnsDohDao.selectDohInfoByUnion(params);
		Integer dohCount = dnsDohDao.selectDohCountByUnion(params);
		setDohData(dohAttributes);
		// 查询do53(scan_result)信息
		List<Result> do53Infos = dnsDo53Dao.selectScanResultByUnion(null,params);
		Integer do53Count = dnsDo53Dao.selectScanResultCountByUnion(params);
		setdo53Data(do53Infos);
		do53Infos.addAll(dohAttributes);

		page.setTotal(dohCount + do53Count);
		page.setRecords(getPage(do53Infos, (int) page.getSize(), (int) page.getCurrent()));
		indepentIpMap.put("dns-doh",do53Count);
		indepentIpMap.put("dns-do53",do53Count);

		return buildResult(page,indepentIpMap,(dohCount + do53Count));

	}

	private String getIpType(String ip){
		if(ip.contains(Constant.POINT)){
			return Constant.IP_IPV4;
		}
		return Constant.IP_IPV6;
	}

	private String getProtocolType(Integer scanType){
		// dnsType 为2为udp,1或者空为tcp
		if(scanType == null || scanType < 2){
			return Constant.PROTOC_TCP;
		}
		return Constant.PROTOC_UDP;
	}

	private PageUtils buildResult(IPage page,Object independentIpNum,Integer resultTotal ){
		PageUtils pageUtils = new PageUtils(page);
		// 添加独立IP个数
		pageUtils.setIndependentIpNum(independentIpNum);
		pageUtils.setResultTotal(resultTotal);
		return pageUtils;
	}


	private PageUtils openRdns(IPage page, Map<String, Object> params) {
		List<Result> results = dnsDo53Dao.queryOpenRdns(params);
		int totalCount = dnsDo53Dao.getCountByDnsType(Constant.OPENRDNS, params);
		setDo53Label(results, Constant.OPENRDNSTAG);
		page.setRecords(results);
		// 添加独立IP个数
		Integer independentIpNum = dnsDo53Dao.getIndependentIpNum(Constant.OPENRDNS, params);

		return buildResult(page,independentIpNum,totalCount);
	}

	private PageUtils forwarder(IPage page, Map<String, Object> params) {
		int totalCount = dnsDo53Dao.getCountByDnsType(Constant.FORWARDER, params);
		List<Result> results = dnsDo53Dao.queryOpenRdns(params);
		for (Result result : results) {
			List<IpInformation> ipInfos = ipInformationDao.getIpInfoByFwd(result.getIp(),null);
			result.setBanner(ipInfos);
			result.setProtocolType(getProtocolType(result.getScanType()));
			result.setIpType(getIpType(result.getIp()));
			addLabels(result, Constant.FORWARDERTAG);
		}

		page.setRecords(results);
		// 添加独立IP个数
		Integer independentIpNum = dnsDo53Dao.getIndependentIpNum(Constant.FORWARDER, params);

		return buildResult(page,independentIpNum,totalCount);
	}

	private PageUtils fwdRdns(IPage page, Map<String, Object> params) {
		int totalCount = dnsDo53Dao.getCountByDnsType(Constant.FWDRDNS, params);
		List<Result> results = dnsDo53Dao.queryOpenRdns(params);
		for (Result result : results) {
			List<IpInformation> ipInfos = ipInformationDao.getIpInfoByFwd(result.getIp(),null);
			result.setBanner(ipInfos);
			result.setProtocolType(getProtocolType(result.getScanType()));
			result.setIpType(getIpType(result.getIp()));
			addLabels(result, Constant.FWDRDNSTAG);
		}
		page.setRecords(results);
		// 添加独立IP个数
		Integer independentIpNum = dnsDo53Dao.getIndependentIpNum(Constant.FWDRDNS, params);

		return buildResult(page,independentIpNum,totalCount);
	}

	private PageUtils egressDns(IPage page, Map<String, Object> params) {
		int totalCount = dnsDo53Dao.getCountByDnsType(Constant.EGRESSRDNS, params);
		List<Result> results = dnsDo53Dao.queryOpenRdns(params);
		setDo53Label(results, Constant.EGRESSRDNSTAG);
		page.setRecords(results);
		// 添加独立IP个数
		Integer independentIpNum = dnsDo53Dao.getIndependentIpNum(Constant.EGRESSRDNS, params);

		return buildResult(page,independentIpNum,totalCount);
	}

	private PageUtils nonstandard(IPage page, Map<String, Object> params) {
		int totalCount = dnsDo53Dao.getCountByDnsType(Constant.NONSTANDARD, params);
		List<Result> results = dnsDo53Dao.queryOpenRdns(params);
		for (Result result : results) {
			List<IpInformation> ipInfos = ipInformationDao.getIpInfoByFwd(result.getIp(),null);
			result.setBanner(ipInfos);
			result.setProtocolType(getProtocolType(result.getScanType()));
			result.setIpType(getIpType(result.getIp()));
			addLabels(result, Constant.NONSTANDARDTAG);
		}

		page.setRecords(results);
		// 添加独立IP个数
		Integer independentIpNum = dnsDo53Dao.getIndependentIpNum(Constant.NONSTANDARD, params);

		return buildResult(page,independentIpNum,totalCount);
	}



	private void setDo53Label(List<Result> results, String serviceType) {
		List<String> labels = DnsQueryEnum.getLabels(serviceType);
		for (Result result : results) {
			//	result.setBanner(result.getQueryResponse());
			result.setProtocolType(getProtocolType(result.getScanType()));
			result.setIpType(getIpType(result.getIp()));
			result.setTags(labels);
		}
	}

	private void addLabels(Result result, String serviceType) {
		List<String> labels = DnsQueryEnum.getLabels(serviceType);
		result.setTags(labels);
	}

}



