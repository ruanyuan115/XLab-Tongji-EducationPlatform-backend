package org.lab409.util;

import org.lab409.dao.StudentChapterDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.BufferedReader;
import java.io.InputStreamReader;

@Component
public class NLPUtil {
    @Autowired
    private StudentChapterDao studentChapterDao;
    private static NLPUtil nlpUtil;
    @PostConstruct
    public void init()
    {
        nlpUtil=this;
        nlpUtil.studentChapterDao=this.studentChapterDao;
    }
    @Async
    public void setCommentNLPRate(String str,Integer chapterID,Integer studentID)throws Exception
    {
        //设置命令行传入的参数
        String[] arg = new String[]{"python", "NLP_test/nlpTest.py",str};
        Process pr = Runtime.getRuntime().exec(arg);
        BufferedReader in = new BufferedReader(new InputStreamReader(pr.getInputStream()));
        String line=in.readLine();
        in.close();
        pr.waitFor();
        line=line!=null?line:"0";
        nlpUtil.studentChapterDao.setNLPRateByChapterIDAndStudentID(line,chapterID,studentID);
    }
}
