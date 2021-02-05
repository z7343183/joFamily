package jo.main.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;
public class FileDownloadView extends AbstractView {

 

    public FileDownloadView() {

        // 객체가 생성될 때 Content Type을 다음과 같이 변경 

        setContentType("application/download; charset=utf-8");

    }

 

    @Override

    protected void renderMergedOutputModel(Map<String, Object> model,HttpServletRequest request,HttpServletResponse response) throws Exception {
    	
    	String name = (String)model.get("name");
        File file = new File(name);
        response.setContentType(getContentType());
        response.setContentLength((int) file.length());
        String userAgent = request.getHeader("User-Agent");
        boolean ie = userAgent.indexOf("MSIE") > -1;
        ie =userAgent.indexOf("like Gecko") > -1;
        String fileName = null;
        String nameArr[] ={};
		if(ie){
			name = name.replace("\\","/"); 
		}	
    	nameArr = name.split("/");    		
        String thisName = nameArr[nameArr.length-1]; 
        if(ie) {        	
            fileName = URLEncoder.encode(thisName, "utf-8").replace("+", "%20");;            
        } else {
            fileName = new String(thisName.getBytes("utf-8"), "iso-8859-1");
        }

        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        OutputStream out = response.getOutputStream();
        FileInputStream fis = null;

 

        try {

            fis = new FileInputStream(file);

            FileCopyUtils.copy(fis, out);

        } finally {

            if(fis != null)

                try {

                    fis.close();

                } catch(IOException ex) {

                }

        }

        out.flush();

    }

}

