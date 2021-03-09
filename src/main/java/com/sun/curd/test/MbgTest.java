package com.sun.curd.test;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.exception.InvalidConfigurationException;
import org.mybatis.generator.exception.XMLParserException;
import org.mybatis.generator.internal.DefaultShellCallback;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MbgTest {
    public static void main(String[] args) throws InterruptedException, SQLException, IOException, XMLParserException, InvalidConfigurationException {
        /*创建容器*/
        List<String> warnings = new ArrayList<String>();
        /*是否写入*/
        boolean overwrite = true;
        /*加载配置文件*/
        File configFile = new File("MBG.xml");
        /*提示信息*/
        ConfigurationParser cp = new ConfigurationParser(warnings);
        /*解析配置文件*/
        Configuration config = cp.parseConfiguration(configFile);
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        /*mybatis逆向工程的核心*/
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
        myBatisGenerator.generate(null);
    }
}
