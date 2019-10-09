package com.websocket;
import java.util.Map;
import java.util.Random;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;
public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor{  
	@Override  
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler handler, Map<String, Object> attributes) throws Exception {  
        //attributes是session里面的所有属性的map表示
        attributes.put("user", getRandomNickName());
        return super.beforeHandshake(request, response, handler, attributes);  
    } 
	
    @Override  
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Exception ex) {  
        super.afterHandshake(request, response, wsHandler, ex);  
    }        
    
    public String getRandomNickName(){
    	Random random=new Random();
		//得到名字的长度大概在4-12位		0-8
		int length = random.nextInt(9)+4;
		char capital,rest;
		String name="";
		for(int i=0;i<length;i++) {
			if(i==0) {
				capital = (char) (random.nextInt(26)+'A');
				name+=capital;
			}
			else {
				rest = (char) (random.nextInt(26)+'a');
				name+=rest;
			}
		}
		return name;
    }
}  
