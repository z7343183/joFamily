package jo.main.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jo.main.service.MainService;

import org.springframework.stereotype.Component;

/**
 * Servlet Filter implementation class sessionFilter
 */
@Component("sessionFilter")
public class SessionFilter implements Filter {

    /**
     * Default constructor. 
     */
    public SessionFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	@Resource(name = "mainService")
	private MainService mainService;
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpReq = (HttpServletRequest)request;
        String url = httpReq.getRequestURL().toString().trim();
        HttpSession session = httpReq.getSession();
        
        Object login = session.getAttribute("loginInfo");
        HttpServletRequest req = (HttpServletRequest) request;
        
    	Cookie[] cookies = (req).getCookies();            // 요청정보로부터 쿠키를 가져온다.				
        boolean loginCheck = false;
        if(login!=null||url.contains("login")||url.contains("logout")){
                loginCheck = true;
        }
        
        if(!loginCheck){
        	Map map = new HashMap();
        	if(null!=cookies ){
	        	for(int i = 0 ; i<cookies.length; i++){         // 쿠키 배열을 반복문으로 돌린다.			
	    			map.put(cookies[i].getName(), cookies[i].getValue());
	    		}	
        	}
        	if(null!=map.get("id")&&!("").equals(map.get("id"))){        		        		
        		try {
					mainService.loginChk(map, req);
					if(null!=session.getAttribute("loginInfo")){
						loginCheck = true;
					};
				} catch (Exception e) {
					//e.printStackTrace();
				}
        	}
        }
        if(loginCheck){ //로그인O일 때
        	if(null!=cookies)
        	for( int i = 0 ; i<cookies.length; i++){         // 쿠키 배열을 반복문으로 돌린다.			
        		cookies[i].setMaxAge(365*24*60*60);
    		} 	
            chain.doFilter(request, response); //이걸 써야 목적지로 이동
              
        }else{          //로그인X일 때
            RequestDispatcher dispatcher = request.getRequestDispatcher("/login.do");
            dispatcher.forward(request, response);
        }     
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
