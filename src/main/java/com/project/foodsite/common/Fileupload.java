package com.project.foodsite.common;

import java.io.File;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;



@Component
public class Fileupload {

    // 업로드 주소 불러오기 
    // 윈도우 경로 C:/Users/사용자명/foodsite
    // 
    @Value("${file.upload.path}")
    private String uploadPath;
    
    // 파일 저장 함수
    public String saveFile(MultipartFile file, String folder) throws Exception{

        if(file == null || file.isEmpty()){
            return null;
        }

        File dir = new File( folder);

        if(!dir.exists()){
            dir.mkdirs();
        }

        String filename = file.getOriginalFilename();
        File saveFile = new File(dir, filename);

        if(saveFile.exists()){
            filename = System.currentTimeMillis() + "_" + filename;
            saveFile = new File(dir, filename);            
        }

        file.transferTo(saveFile);

        return filename;

    }


    //파일 제거 함수
    public void deleteFile(String filename, String folder){
        
        if (filename == null || filename.equals("no_file.png")){
            return;
        }

        File file = new File(uploadPath + "/" + folder, filename);

        if(file.exists()){
            file.delete();
        }

    }


}
