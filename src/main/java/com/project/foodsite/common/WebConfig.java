package com.project.foodsite.common;

import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${file.upload.path}")
    private String uploadPath;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry)    {

       String path = Paths.get(uploadPath).toUri().toString(); 
       System.out.println("업로드 접근 경로 = " + path);
        registry.addResourceHandler("/upload/**")
                 //.addResourceLocations("file:///Users/shinyeyoung/upload/");
                .addResourceLocations(path); //윈도우
    
    }
}
