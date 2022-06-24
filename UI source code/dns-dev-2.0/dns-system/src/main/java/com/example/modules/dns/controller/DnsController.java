package com.example.modules.dns.controller;

import com.example.modules.dns.service.DnsService;
import com.example.utils.page.PageUtils;
import com.example.utils.page.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.text.DecimalFormat;
import java.util.Map;

@RestController
@RequestMapping("/dns")
public class DnsController {
    @Autowired
    private DnsService dnsService;

    @GetMapping
    public R queryPage(@RequestParam Map<String, Object> params) {
        long startTime = System.currentTimeMillis();
        PageUtils page =dnsService.queryPage(params);
        long endTime = System.currentTimeMillis();
        DecimalFormat df = new DecimalFormat("0.000");
        String totalTime = df.format((float) (endTime - startTime) / 1000);
        page.setTotalTime(Double.parseDouble(totalTime));
        return R.ok(page);
    }


    //区域数据统计
    @GetMapping("/dataCount")
    public R dataCount(@RequestParam Map<String, Object> params) {
        return R.ok(dnsService.dataCount(params));
    }

    //区域数据统计
    @GetMapping("/mapData")
    public R mapData() {
        return R.ok(dnsService.mapData());
    }




}
