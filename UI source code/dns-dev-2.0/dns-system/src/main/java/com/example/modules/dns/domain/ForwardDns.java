
package com.example.modules.dns.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.io.Serializable;


@Data
@TableName("forward_dns")
public class ForwardDns implements Serializable {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String forwarder;

    private String upstream;

    private int epoch;

}
