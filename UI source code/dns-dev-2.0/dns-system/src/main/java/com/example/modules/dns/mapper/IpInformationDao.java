package com.example.modules.dns.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.modules.dns.domain.IpInformation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface IpInformationDao extends BaseMapper<IpInformation> {


    List<IpInformation> queryIpPage(IPage page, @Param("params") Map<String, Object> params);

	/**
	 * 根据 forward_dns中的 forwarder查询ip信息
	 * @param ip
	 * @return
	 */
	List<IpInformation> getIpInfoByFwd(@Param("ip")String ip,@Param("epoch")Integer epoch);

}
