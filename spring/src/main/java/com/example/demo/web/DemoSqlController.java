package com.example.demo.web;

import com.example.demo.domain.Greeting;
import com.example.demo.repository.GreetingRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoSqlController {

    private GreetingRepository greetingRepository;

    public DemoSqlController(GreetingRepository greetingRepository){
        this.greetingRepository = greetingRepository;
    }

    @GetMapping("/greeting-sql/{id}")
    public Greeting greetingSql(@PathVariable Long id) {
        return greetingRepository.findById(id).orElseThrow();
    }

}
