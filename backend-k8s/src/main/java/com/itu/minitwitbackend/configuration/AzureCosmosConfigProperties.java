package com.itu.minitwitbackend.configuration;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@org.springframework.boot.context.properties.ConfigurationProperties(prefix = "azure.cosmos")
@Getter
@Setter
@NoArgsConstructor
public class AzureCosmosConfigProperties {

    private String database;
    private String uri;
}
