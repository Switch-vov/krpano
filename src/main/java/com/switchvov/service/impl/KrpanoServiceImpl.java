package com.switchvov.service.impl;

import com.switchvov.service.KrpanoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Krpano Service 实现类
 * Created by Switch on 2017/6/6.
 */
@Service
public class KrpanoServiceImpl implements KrpanoService {
    private static final Logger LOGGER = LoggerFactory.getLogger(KrpanoServiceImpl.class);

    @Value("${krpano_tool}")
    private String KRPANO_TOOL;

    @Value("${makepano}")
    private String MAKEPANO;

    @Value("${config_key}")
    private String CONFIG_KEY;

    @Value("${config}")
    private String CONFIG;

    @Value("${upload_image_base_path}")
    private String UPLOAD_IMAGE_BASE_PATH;

    @Override
    public void makePano(String uid, String cate) throws Exception {
        String dirPath = UPLOAD_IMAGE_BASE_PATH + File.separator + uid + File.separator + cate;
        File dirFile = new File(dirPath);
        String[] imageList = dirFile.list();
        StringBuilder builder = new StringBuilder(KRPANO_TOOL + " " + MAKEPANO + " " + CONFIG_KEY + CONFIG);
        for (String image : imageList) {
            builder.append(" " + dirPath + File.separator + image);
        }
        final String cmd = builder.toString();
        LOGGER.info(cmd);
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    Process pro = Runtime.getRuntime().exec(cmd);
                    BufferedReader br = new BufferedReader(new InputStreamReader(pro.getInputStream()));
                    StringBuffer sb = new StringBuffer();
                    String line;
                    while ((line = br.readLine()) != null) {
                        sb.append(line).append("\n");
                    }
                    String result = sb.toString();
                    LOGGER.info(result);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }
}
