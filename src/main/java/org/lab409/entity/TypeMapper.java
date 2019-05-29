package org.lab409.entity;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@Data
public class TypeMapper {
    Map<Integer,Integer> mapper=new HashMap<>();

    public TypeMapper() {
        mapper.put(6,1);
        mapper.put(7,2);
        mapper.put(8,2);
        mapper.put(9,1);
        mapper.put(10,3);
        mapper.put(11,1);
        mapper.put(12,1);
        mapper.put(13,1);
        mapper.put(14,1);
        mapper.put(15,1);
        mapper.put(16,3);
        mapper.put(17,1);
        mapper.put(18,1);
        mapper.put(19,1);
        mapper.put(20,1);
        mapper.put(21,1);
        mapper.put(22,2);
        mapper.put(23,3);
    }
}
