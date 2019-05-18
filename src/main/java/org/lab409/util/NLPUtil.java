package org.lab409.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class NLPUtil {
    public static String getCommentNLPRate(String str)throws Exception
    {
        //设置命令行传入的参数
        String[] arg = new String[]{"python", "NLP_test/nlpTest.py",str};
        Process pr = Runtime.getRuntime().exec(arg);
        BufferedReader in = new BufferedReader(new InputStreamReader(pr.getInputStream()));
        String line=in.readLine();
        in.close();
        pr.waitFor();
        return line;
    }
}
