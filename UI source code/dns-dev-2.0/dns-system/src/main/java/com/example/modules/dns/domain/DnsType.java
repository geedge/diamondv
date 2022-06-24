
package com.example.modules.dns.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.io.Serializable;


@Data
@TableName("dns_type")
public class DnsType implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String ip;

    private String type;

    private int epoch;

}
