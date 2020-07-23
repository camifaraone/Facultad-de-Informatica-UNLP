package ar.edu.unlp.info.bd2.config;

import ar.edu.unlp.info.bd2.utils.DBInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DBInitializerConfig {

    @Bean
    public DBInitializer createDBInitializer() {
        return new DBInitializer();
    }

}
