package com.project.foodsite.common;

import lombok.Data;

@Data
public class Paging {
    
    private int page, size, totalcount, totalpage, startpage, endpage, offset;

    private int blocksize =5;

    private boolean prev, next;

    public Paging(int page, int size, int totalcount){
        this.page = page;
        this.size = size;
        this.totalcount = totalcount;
        
        pagingcal();        

    }

    public void pagingcal(){
        page= page <= 0 ? 1: page;
        size = size <=0 ? 10 : size;
        totalcount = totalcount < 0 ? 0 : totalcount;

        
        totalpage = (int)Math.ceil((double)totalcount / size);

        if(totalpage == 0 ){
           totalpage = 1;
        }

        if (page > totalpage){
            page = totalpage;
        }

        offset = (page-1) * size;
        
        startpage = ((page-1) / blocksize )* blocksize +1;
        endpage = Math.min(startpage+blocksize -1,totalpage);

        prev = startpage > 1;
        next = endpage < totalpage;  

    }

    
}
