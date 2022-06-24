
package com.example.modules.dns.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.io.Serializable;


/**
 *
 *  直接响DNS表
 */
@Data
    @TableName("nonstandard_dns")
public class NonstandardDns implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;

    private String ip;

    private String record;

    private int epoch;


}
