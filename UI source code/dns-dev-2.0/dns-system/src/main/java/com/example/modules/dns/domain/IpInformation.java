/*
 *  Copyright 2019-2020 Zheng Jie
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package com.example.modules.dns.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 *
 *  2018-11-22
 */
@Data
@TableName("ip_information")
public class IpInformation implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;

    private String ip;

    private String country;

    private String province;

    private String city;
    private String district;
    private String provider;
    private String isp;
    private Integer asnumber;
    private Date timestamp;
    private String zipcode;
    private String timezone;

    @TableField(exist = false)
    private List<IpCert> ipCert;

    @TableField(exist = false)
    private List<NonstandardDns> nonstandardDns;


    @TableField(exist = false)
    private DnsType dnsType;

    @TableField(exist = false)
    private List<DohAttribute> dohAttribute;

    @TableField(exist = false)
    private List<ForwardDns> forwardDns;

    @TableField(exist = false)
    private ScanResult scanResult;

    @TableField(exist = false)
    private Integer dnsTypeValue;

}
