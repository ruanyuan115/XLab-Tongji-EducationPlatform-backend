package org.lab409;

import com.spring4all.mongodb.EnableMongoPlus;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@EnableMongoPlus
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
