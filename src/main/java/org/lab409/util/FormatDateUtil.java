package org.lab409.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class FormatDateUtil {
    public static String formatDate(String formatString, Date date) {
        SimpleDateFormat ft = new SimpleDateFormat(formatString);
        return ft.format(date);
    }

    public static String formatDate(Date date) {
        return FormatDateUtil.formatDate("yyyy-MM-dd hh:mm:ss", date);
    }
}
