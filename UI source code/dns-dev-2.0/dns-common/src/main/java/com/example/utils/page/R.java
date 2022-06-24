package com.example.utils.page;

import cn.hutool.core.date.DateUtil;

import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class R extends HashMap<String, Object> {
    private static final long serialVersionUID = 1L;

    public R() {
        put("status", 200);
        put("message", "success");
        put("timestamp", new Date());
    }

    public static R ok(String message) {
        R r = new R();
        r.put("message", message);
        r.put("timestamp", new Date());
        return r;
    }

    public static R ok() {
        return new R();
    }

    public static R ok(Object data) {
        R r = new R();
        r.put("data", data);
        r.put("timestamp", new Date());
        return r;
    }


}


