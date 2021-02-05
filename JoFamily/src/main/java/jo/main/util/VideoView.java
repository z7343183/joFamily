package jo.main.util;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.util.Map;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.Credentials;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.UsernamePasswordCredentials;
import org.apache.commons.httpclient.auth.AuthScope;
import org.apache.jackrabbit.webdav.client.methods.CopyMethod;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.view.AbstractView;

import com.github.sardine.Sardine;
import com.github.sardine.SardineFactory;

 

/**

 * 모바일에서 동영상 스트리밍 지원하는 클래스 

 */

@Component("videoView")

public class VideoView extends AbstractView {

     

    Logger log = Logger.getLogger(this.getClass());

 

    @Override

    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest req,

       HttpServletResponse res) throws Exception {


    	try{
    		String movieDir = ""; 
    		InetAddress inet= InetAddress.getLocalHost();
    		if(inet.getHostName().equals("wk1-PC")){    		
        		movieDir ="z:/사진/" ; 
        	}else{
        		movieDir ="/mnt/hdd/사진/" ;    		
        	}
        	 
            String movieFile = (String)model.get("name");    	    
    	    File getFile = new File(movieDir+movieFile);
    	    
    	    try {
    	      // 미디어 처리
    	      MultipartFileSender
    	        .fromFile(getFile)
    	        .with(req)
    	        .with(res)
    	        .serveResource();
    	      
    	    } catch (Exception e) {
    	      // 사용자 취소 Exception 은 콘솔 출력 제외
    	      if (!e.getClass().getName().equals("org.apache.catalina.connector.ClientAbortException")) e.printStackTrace();
    	    }

    	}
    	catch(Exception ex){
    	    // Handle Exception
    	}
    }


}

