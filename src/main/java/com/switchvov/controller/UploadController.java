package com.switchvov.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.UUID;

/**
 * 上传文件Controller
 * Created by Switch on 2017/6/6.
 */
@Controller
@RequestMapping("upload")
public class UploadController {

    private static final Logger LOGGER = LoggerFactory.getLogger(UploadController.class);

    @Value("${upload_image_base_path}")
    private String UPLOAD_IMAGE_BASE_PATH;

    /**
     * 上传文件界面
     */
    @RequestMapping(method = RequestMethod.GET)
    public String toUpload() {
        return "upload";
    }

    /**
     * 上传
     */
    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity<Void> upload(@RequestParam("file") MultipartFile file, String uid, String cate) {
        try {
            // 文件保存路径
            String dir = UPLOAD_IMAGE_BASE_PATH + File.separator + uid + File.separator + cate + File.separator;
            File dirPath = new File(dir);
            if (!dirPath.exists()) {
                dirPath.mkdirs();
            }
            String originalFilename = file.getOriginalFilename();
            String fileName = UUID.randomUUID().toString().replace("-", "") + originalFilename.substring(originalFilename.lastIndexOf("."));
            String filePath = dir + fileName;
            // 转存文件
            file.transferTo(new File(filePath));
            return ResponseEntity.ok().body(null);
        } catch (Exception e) {
            LOGGER.error("upload image failure.", e);
            // 如果有异常，设置状态码为500
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
}
