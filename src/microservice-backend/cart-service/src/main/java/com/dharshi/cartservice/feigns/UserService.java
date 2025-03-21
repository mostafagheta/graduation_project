package com.dharshi.cartservice.feigns;

import com.dharshi.cartservice.dtos.ApiResponseDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name = "api-gateway", url = "http://api-gateway:8080", contextId = "userServiceFeignClient1")
public interface UserService {

    @GetMapping("/user-service/user/exists/byId")
    ResponseEntity<ApiResponseDto<Boolean>> existsUserById(@RequestParam String userId);

}
