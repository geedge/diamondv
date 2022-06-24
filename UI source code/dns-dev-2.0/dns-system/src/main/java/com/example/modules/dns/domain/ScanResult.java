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
 * 2018-11-22
 */
@Data
@TableName("scan_result")
public class ScanResult implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;

    private String ip;

    private Integer flags;

    private Integer opcode;

    private Integer qr;
    //权威标志位
    private Integer aa;
    //递归标志位
    private Integer ra;

    private Integer rcode;

    private String queryName;

    private String queryResponse;

    private String component;

    private int epoch;

    private List<String> componentList;
    //（预留）ipv4，ipv6，dnssec，tcp，udp等
    private Integer scanType;

    private Date time;
    @TableField(exist = false)
    private IpInformation IpInformation;
    @TableField(exist = false)
    private List<IpInformation> forwarderBanner;
    @TableField(exist = false)
    private Integer dnsType;
    @TableField(exist = false)
    private List<NonstandardDns> nonstandardBanner;

    @TableField(exist = false)
    private List<String> tags;
}
