package com.example.demo.web;

import com.example.demo.domain.Greeting;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.atomic.AtomicLong;

@RestController
public class DemoController {

    @Value("${app.hello}")
    private  String template = "Hello, %s!";

    private final AtomicLong counter = new AtomicLong();

    @GetMapping(value = { "/", "/greeting4" })
    public Greeting greeting(@RequestParam(value = "name", defaultValue = "World") String name) {
        return new Greeting(counter.incrementAndGet(), String.format(template, name));
    }

}
