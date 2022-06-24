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
package com.example.utils;

import java.util.Arrays;
import java.util.List;

/**
 * 常用静态常量
 *
 *
 *  2018-12-26
 */
public class ElAdminConstant {

    private ElAdminConstant() {
        throw new IllegalStateException("Utility class");
    }

    /**
     * 用于IP定位转换
     */
    public static final String REGION = "内网IP|内网IP";
    /**
     * win 系统
     */
    public static final String WIN = "win";

    /**
     * mac 系统
     */
    public static final String MAC = "mac";

    public static final List<String> openRdnsLabels = Arrays.asList("DNS", "DNS-Do53", "open-rdns");

    public static final List<String> forwarderLabels = Arrays.asList("DNS", "DNS-Do53", "forwarder");

    public static final List<String> fwdRdnsLabels = Arrays.asList("DNS", "DNS-Do53", "fwd/rdns");

    public static final List<String> egressDnsLabels = Arrays.asList("DNS", "DNS-Do53", "egress-dns");

    public static final List<String> nonstandardLabels = Arrays.asList("DNS", "DNS-Do53", "nonstandard");

    public static final List<String> dnsLabels = Arrays.asList("DNS");

    public static final List<String> dohLabels = Arrays.asList("DNS","DNS-DoH");

    public static final List<String> do53Labels = Arrays.asList(new String[]{"DNS","DNS-Do53"});

    /**
     * 常用接口
     */
    public static class Url {
        // IP归属地查询
        public static final String IP_URL = "http://whois.pconline.com.cn/ipJson.jsp?ip=%s&json=true";
    }
}
