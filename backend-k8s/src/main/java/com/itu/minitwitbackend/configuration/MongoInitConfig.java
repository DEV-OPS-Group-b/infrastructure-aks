package com.itu.minitwitbackend.configuration;

import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.config.AbstractMongoClientConfiguration;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

import com.itu.minitwitbackend.repository.UserRepository;
import com.mongodb.ConnectionString;
import com.mongodb.MongoClientSettings;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;

@Configuration
@EnableMongoRepositories(basePackageClasses = UserRepository.class)
public class MongoInitConfig extends AbstractMongoClientConfiguration {

    private final AzureCosmosConfigProperties cosmosConfigProperties;

    @Autowired
    public MongoInitConfig(AzureCosmosConfigProperties cosmosConfigProperties) {
        this.cosmosConfigProperties = cosmosConfigProperties;
    }

    @Override
    protected String getDatabaseName() {
        return cosmosConfigProperties.getDatabase();
    }

    @Override
    public MongoClient mongoClient() {

        final ConnectionString connectionString = new ConnectionString(cosmosConfigProperties.getUri());
        final MongoClientSettings mongoClientSettings = MongoClientSettings.builder()
                .applyConnectionString(connectionString)
                .build();
        return MongoClients.create(mongoClientSettings);
    }
}
