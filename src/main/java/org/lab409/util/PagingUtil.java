package org.lab409.util;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.util.List;

public class PagingUtil {
    public static<T> PageInfo doPaging(int pageID, int pageSize, List<T> entityList) {
        PageHelper.startPage(pageID, pageSize);
        return new PageInfo<>(entityList);
    }
}
