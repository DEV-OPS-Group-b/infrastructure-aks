package com.itu.minitwitbackend.configuration;

import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@EnableConfigurationProperties(AzureCosmosConfigProperties.class)
@Configuration
public class CosmosConfiguration {

}
