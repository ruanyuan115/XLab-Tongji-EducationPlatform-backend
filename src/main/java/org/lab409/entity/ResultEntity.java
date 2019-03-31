package org.lab409.entity;

import lombok.Data;

@Data
public class ResultEntity
{
    private String message;
    private Integer state;
    private Object data;
}
