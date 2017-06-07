package com.switchvov.controller;

import com.switchvov.service.impl.KrpanoServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Krpano Controller
 * Created by Switch on 2017/6/6.
 */
@Controller
@RequestMapping("krpano")
public class KrpanoController {
    private static final Logger LOGGER = LoggerFactory.getLogger(KrpanoController.class);

    @Autowired
    private KrpanoServiceImpl krpanoService;

    /**
     * 创建Pano
     */
    @RequestMapping(value = "makePano", method = {RequestMethod.POST, RequestMethod.GET})
    public ResponseEntity<Void> makePano(String uid, String cate) {
        try {
            krpanoService.makePano(uid, cate);
            return ResponseEntity.ok().body(null);
        } catch (Exception e) {
            LOGGER.error("make pano failure.", e);
            // 如果有异常，设置状态码为500
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    /**
     * 访问Pano
     */
    @RequestMapping("visitPano")
    public String visitPano(String uid, String cate) {
        return "redirect:http://192.168.1.222:6166/" + uid + "/" + cate + "/vtour/tour.html";
    }
}
