package jo.main.util;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.net.URLEncoder;
import java.util.Map;

 




import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

 




import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.view.AbstractView;

import com.github.sardine.Sardine;
import com.github.sardine.SardineFactory;


@Component("webdavView")

public class WebdavView extends AbstractView {

     

    Logger log = Logger.getLogger(this.getClass());

 

    @Override

    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,

       HttpServletResponse response) throws Exception {
         //대상 동영상 파일명
        String fileName = (String)model.get("name");
    	Sardine sardine = SardineFactory.begin("jj", "jung0315");
		response.setContentType("application/octet-stream");
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.setHeader("Content-Disposition", "attachment;fileName=\"" + fileName + "\";");
        InputStream is = sardine.get(("http://192.168.0.14/webdav/사진/"+ fileName).replaceAll(" ","%20"));		  
		OutputStream outStream = response.getOutputStream();
		byte[] buffer = new byte[8 * 1024];
		int bytesRead;
		while ((bytesRead = is.read(buffer)) != -1) {
			outStream.write(buffer, 0, bytesRead);
		}
		is.close();
		outStream.flush();
		outStream.close();        

    }


}

