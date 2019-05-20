package org.lab409.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.lab409.entity.ResultEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import javax.servlet.http.HttpServletRequest;

import java.util.Enumeration;

@ControllerAdvice
public class GlobalExceptionHandler
{
    private static Logger logger = LogManager.getLogger(GlobalExceptionHandler.class.getName());
    @ExceptionHandler(value = MethodArgumentTypeMismatchException.class)
    @ResponseBody
    public ResultEntity MethodArgumentTypeMismatchHandler(HttpServletRequest request, Exception e)
    {
        ResultEntity commonMessage = new ResultEntity();
        commonMessage.setMessage("参数匹配错误！");
        commonMessage.setState(0);
        log(e, request);
        return commonMessage;
    }
    @ExceptionHandler(value = NullPointerException.class)
    @ResponseBody
    public ResultEntity NullPointerHandler(HttpServletRequest request, Exception e)
    {
        ResultEntity commonMessage = new ResultEntity();
        commonMessage.setMessage("空指针异常！");
        commonMessage.setState(0);
        log(e, request);
        return commonMessage;
    }
    @ExceptionHandler(value = Exception.class)
    @ResponseBody
    public ResultEntity CommonExceptionHandler(HttpServletRequest request, Exception e)
    {
        ResultEntity commonMessage = new ResultEntity();
        commonMessage.setMessage("异常信息："+e);
        commonMessage.setState(0);
        log(e, request);
        return commonMessage;
    }
    private void log(Exception ex, HttpServletRequest request)
    {
        logger.error("************************异常开始*******************************");
        logger.error(ex);
        logger.error("请求地址：" + request.getRequestURL());
        Enumeration enumeration = request.getParameterNames();
        logger.error("请求参数");
        while (enumeration.hasMoreElements()) {
            String name = enumeration.nextElement().toString();
            logger.error(name + "---" + request.getParameter(name));
        }

        StackTraceElement[] error = ex.getStackTrace();
        for (StackTraceElement stackTraceElement : error) {
            logger.error(stackTraceElement.toString());
        }
        logger.error("************************异常结束*******************************");
    }
}
