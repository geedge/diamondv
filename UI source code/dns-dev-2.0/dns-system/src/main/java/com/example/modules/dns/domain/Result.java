package com.example.modules.dns.domain;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
public class Result implements Serializable {

    private Long id;
    private String ip;

    private String protocolType;
    private String ipType;

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

    //（预留）ipv4，ipv6，dnssec，tcp，udp等
    private Integer scanType;

    private Date time;

    private Integer epoch;

    private Integer rounds;


    private Integer dnsType;

    private String uuid;

    private List<String> pathList;

    private List<String> componentList;

    private List<IpCert> ipCert;

    private List<Vulnerability> vulnerability;

    private List<String> tags;

    private IpInformation ipInformation;

    private List<? extends Object> banner;

    private List<? extends Object> httpContent;

}
