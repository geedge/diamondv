package com.example.utils.page;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import java.util.Map;

/**
 * 查询参数
 */
public class Query {

    private Class clz;

    public Class<? extends Object> getClz() {
        return clz;
    }

    public void setClz(Class clz) {
        this.clz = clz;
    }

    public Query(Class clz) {
        this.clz = clz;
    }

    public IPage getPage(Map<String, Object> params) {
        return this.getPage(params, null, false);
    }

    public IPage getPage(Map<String, Object> params, String defaultOrderField, boolean isAsc) {
        //分页参数
        long curPage = 1;
        long limit = 10;

        if(params.get("page") != null && !"".equals(params.get("page"))){
            curPage = Long.parseLong((String)params.get("page"));
        }
        if(params.get("size") != null && !"".equals(params.get("size"))){
            limit = Long.parseLong((String)params.get("size"));
            if(limit == -1){
                limit = Long.MAX_VALUE;
                curPage = 0;
            }
        }

        //分页对象
        Page page = new Page(curPage, limit);

        //分页参数
        params.put("page", page);


        // 默认排序
        if(isAsc) {
            page.setAsc(defaultOrderField);
        }else {
            page.setDesc(defaultOrderField);
        }

        return page;
    }
}
