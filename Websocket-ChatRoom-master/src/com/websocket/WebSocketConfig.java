package com.websocket;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

/**
 * ����websocket��ڣ�������ʵ���ע��Handler��SockJs֧�ֺ�������
 */
@Configuration  //������  
@EnableWebSocket  //����֧��websocket  
public class WebSocketConfig implements WebSocketConfigurer{  
  
    @Override  
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {  
    	//String[] allowsOrigins={"http://localhost:8080"};
    	//addHandlerע���·�ɵĹ��ܣ����ͻ��˷���websocket���ӣ���/path������Ӧ��handler��������ʵ�־����ҵ���߼����������Ϊ�ռ�������ַ����ġ�
    	//setAllowedOrigins(String[] domains),����ָ����������IP(���˿ں�)���������ӣ�Ĭ��ֻ�б��ء��������ʱʹ��"*"�ţ����ָ���������������Ҫ��http��https��ͷ��
    	//addInterceptors������˼�����Ϊhandler����������������ڵ���handlerǰ������Զ�����߼����롣
        registry.addHandler(ChatRoom(), "/chat.sc").setAllowedOrigins("*").addInterceptors(handshakeInterceptor()); 
        //����ͻ���ʹ��SockJS  
        //SockJS ��һ������������е� JavaScript �⣬����������֧�� WebSocket���ÿ����ģ��� WebSocket ��֧�֡�
        registry.addHandler(ChatRoom(), "/sockjs/chat.sc").addInterceptors(handshakeInterceptor()).withSockJS();  
    }  

  
    @Bean  
    public HandshakeInterceptor handshakeInterceptor(){  
        return new HandshakeInterceptor();  
    }  
    
    @Bean  
    public ChatRoom ChatRoom(){  
        return new ChatRoom();  
    }
  
}  