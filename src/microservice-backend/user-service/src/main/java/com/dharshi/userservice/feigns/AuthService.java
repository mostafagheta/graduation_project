package com.dharshi.userservice.feigns;

import com.dharshi.userservice.dtos.ApiResponseDto;
import com.dharshi.userservice.security.UserDetails;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name = "api-gateway", url = "http://api-gateway:8080", contextId = "authServiceFeignClient11")
public interface AuthService {

    @GetMapping("/auth-service/auth/isValidToken")
    ResponseEntity<ApiResponseDto<UserDetails>> validateToken(@RequestParam String token);

}
