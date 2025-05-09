package com.dharshi.orderservice.feigns;


import com.dharshi.orderservice.dtos.ApiResponseDto;
import com.dharshi.orderservice.dtos.MailRequestDto;
import com.dharshi.orderservice.modals.Order;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name = "api-gateway", url = "http://api-gateway:8080", contextId = "notifyServiceFeignClient1")
public interface NotificationService {

    @PostMapping("/notification-service/notification/send")
    ResponseEntity<ApiResponseDto<?>> sendEmail(@RequestBody MailRequestDto requestDto);
}
