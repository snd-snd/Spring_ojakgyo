package com.ojakgyo.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ojakgyo.domain.LoginVO;
import com.ojakgyo.service.ItemService;

public class LoginHandler extends HandlerInterceptorAdapter {

	@Autowired
	ItemService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		LoginVO login = (LoginVO) session.getAttribute("login");
		
		if (login == null) {		
			response.sendRedirect("/account/needLogin");
			return false;
		}
		
		String uri = request.getRequestURI().substring(1);
		List<String> codes = login.getMember().getGroupCodes();
		int admin = login.getMember().getAdmin();
		
		if (uri.contains("board")) {
			boolean result = false;
			if (uri.startsWith("GN"));{
			
				String code = uri.substring(0, uri.indexOf("/"));
				
				if (service.check_item(code)) {
					response.sendRedirect("/notGroupMember");
					return false;				
				}

				result = codes.stream().anyMatch(s -> s.equals(code));

				if (!result && admin == 0) {
					response.sendRedirect("/notGroupMember");
					return false;
				}		

			}			
		}
	
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		
	}	
}
