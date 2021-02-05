package jo.main.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;



import java.io.InputStream;
import java.net.ContentHandler;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.TimeZone;

import org.apache.tika.parser.ParseContext;
import org.apache.tika.parser.mp4.MP4Parser;
import org.apache.tika.sax.BodyContentHandler;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.Tag;
import com.drew.metadata.exif.ExifIFD0Directory;
import com.drew.metadata.exif.ExifSubIFDDirectory;
import com.drew.metadata.jpeg.JpegDirectory;
import com.ibatis.common.jdbc.SimpleDataSource;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGDecodeParam;
import com.sun.image.codec.jpeg.JPEGImageDecoder;



public class ImageUtil {

	

	/**

	 * Gets the orientation of an image (usually photo).

	 * Outputs:

	 * 6: rotate 90,

	 * 1: original (no change)

	 * 3: rotate 180,

	 * 8: rotate 270,

	 * others: original (no change)

	 * 

	 * @param in a File object to check

	 * @return orientation value

	 * @throws IOException

	 */

	public static int getOrientation(File in) throws IOException {

		int orientation = 1;

		Metadata metadata;

		Directory directory;

		try {

			metadata = ImageMetadataReader.readMetadata(in);

			directory = metadata.getFirstDirectoryOfType(ExifIFD0Directory.class);

			

			if(directory != null){

				orientation = directory.getInt(ExifIFD0Directory.TAG_ORIENTATION);

			}

		} catch (ImageProcessingException e) {

			//System.err.println("[ImgUtil] could not process image");

			//e.printStackTrace();

		} catch (MetadataException e) {

			//System.err.println("[ImgUtil] could not get orientation from image");

			//e.printStackTrace();

		}

		

		return getDegreeForOrientation(orientation);

	}

	

	public static int getDegreeForOrientation(int orientation){

		int degree = 0;

		

		switch(orientation){

		case 6:

			degree = 90; break;

		case 1:

			degree = 0; break;

		case 3:

			degree = 180; break;

		case 8:

			degree = 270; break;

		default:

			degree = 0; break;

		}

		return degree;

	}
	
	
	/**
	 * 사진 날짜를 가져오는 함수
	 * @param file
	 * @return
	 * @throws JpegProcessingException
	 * @throws IOException
	 */
	public static String getFileDate(File file) throws JpegProcessingException, IOException{
		 String rtn = "";			  
			  
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");  	  
		  String fileName = file.getName();
		  String ext = fileName.substring(fileName.lastIndexOf(".")+1);		  		  
		  try{
			  String fnm = fileName.replace("_","").replace("."+ext, "");
			  if(fnm.length() > 14){
				  fnm.substring(0,14);
			  }
			  Date d = sdf.parse(fnm);
			  if(d.getYear()<2000) throw new Exception();  
			  if(d.getMonth()>12) throw new Exception();
			  if(d.getDate()>31) throw new Exception();
			  rtn = fileName.replace("_","").replace("."+ext, "");
			  
		  }catch(Exception e){
			  	try{
				    if(ext.equals("mp4")){
						rtn = getMp4Date(file);				  
					}else{
						rtn =  getImgDate(file).replace("_","").replace("."+ext, "");
					}		
				}catch(Exception e2){				
					rtn =  file.getName().replace("_","").replace("."+ext, "");
				}
				  
		  }
	  
	  return rtn+"."+ext;
		   
	}
	
	
	/**
	 * 사진 날짜를 가져오는 함수
	 * @param file
	 * @return
	 * @throws JpegProcessingException
	 * @throws IOException
	 */
	public static String getImgDate(File file) throws JpegProcessingException, IOException{
		String fileName = file.getName();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");  
		String rtn = "";	
		  try{
				  
			  Metadata metadata = ImageMetadataReader.readMetadata(file);
			  for (Directory directory : metadata.getDirectories()) {
			      for (Tag tag : directory.getTags()) {
			          if(tag.getTagName().startsWith("Date/Time")){
			        	  rtn = tag.getDescription().replace(":", "").replace(" ", "");
			        	  break;
			          }			    	  			    	  			           
			      }
			  }
			  
			  if(rtn==null||rtn.equals("")) throw new Exception();
	  }catch(Exception e){
		  rtn =  fileName;		  
	  }
		return rtn;
	}
	/**
	 * 사진 날짜를 가져오는 함수
	 * @param file
	 * @return
	 * @throws JpegProcessingException
	 * @throws IOException
	 */
	public static String getMp4Date(File file) throws JpegProcessingException, IOException{
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddHHmmss");  
		String rtn = "";	
		  try{
			  BodyContentHandler handler = new BodyContentHandler();
		      org.apache.tika.metadata.Metadata metadata = new org.apache.tika.metadata.Metadata();
		      InputStream inputstream = new FileInputStream(file);
		      ParseContext pcontext = new ParseContext();
		      org.apache.tika.parser.mp4.MP4Parser MP4Parser = new MP4Parser();	   
		      MP4Parser.parse(inputstream, handler, metadata);		      
		      String[] metadataNames = metadata.names();		      
		      for(String name : metadataNames) {
		    	  if(name.equals("date")){
		        	 sdf1.setTimeZone(TimeZone.getTimeZone("UTC"));
		        	 Date d = sdf1.parse(metadata.get(name));
		        	 sdf2.setTimeZone(TimeZone.getTimeZone("Asia/Seoul" ));
		        	 rtn = sdf2.format(d);
		        	 if(rtn.startsWith("19040101")){
		        		 rtn = sdf2.format(file.lastModified());
		        	 }
		        	 
		        	 break;
		         }
		      }
		      if(rtn==null||rtn.equals("")) throw new Exception();
	  }catch(Exception e){
		  rtn = sdf2.format(file.lastModified());	
	  }
		return rtn;
	}
	
	
}
	
