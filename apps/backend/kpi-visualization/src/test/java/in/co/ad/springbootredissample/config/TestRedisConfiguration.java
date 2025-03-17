package in.co.ad.springbootredissample.config;

import java.io.IOException;

import org.springframework.boot.test.context.TestConfiguration;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import redis.embedded.RedisServer;

@TestConfiguration
public class TestRedisConfiguration {

    private static RedisServer redisServer;

    static {
        redisServer = new RedisServer();     
    }

    public TestRedisConfiguration() throws IOException {

    }

    @PostConstruct
    public static void postConstruct() {
        if (!redisServer.isActive())
            redisServer.start();
    }

    @PreDestroy
    public static void preDestory() {
        if (redisServer.isActive())
            redisServer.stop();

    }
}
