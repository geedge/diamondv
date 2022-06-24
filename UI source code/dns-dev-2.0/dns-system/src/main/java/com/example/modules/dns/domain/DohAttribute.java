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

@Data
@TableName("doh_attribute")
public class DohAttribute implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String ip;
    private Integer port;
    private String host;
    private String path;
    private String method;
    private Integer connectType;
    private Integer statusCode;
    private String repHeader;
    private String repBody;
    private Date timestamp;

    private String component;

    private int rounds;

    @TableField(exist = false)
    private List<String> pathList;

    @TableField(exist = false)
    private List<String> componentList;

    @TableField(exist = false)
    private List<IpCert> ipCert;

    @TableField(exist = false)
    private List<IpInformation> ipInformation;

    @TableField(exist = false)
    private List<List<Vulnerability>> vulnerability;
    @TableField(exist = false)
    private List<String> tags;


}
