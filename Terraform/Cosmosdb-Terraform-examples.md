Cosmosdb - Terraform 
=====================

* Sample to enable Diagnostic setting for cosmosdb using LogAnalytics
```
resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "example"
  target_resource_id = azurerm_cosmosdb_account.db.id
  log_analytics_workspace_id =  var.log_analytics_workspace_id

  log {
    category = "PartitionKeyStatistics"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  log {
    category = "DataPlaneRequests"
    enabled  = true
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

```

* Diagnostic settings to Eventhub example 
```
data "azurerm_eventhub_namespace_authorization_rule" "example" {
  name                = "cosmossendonly"
  namespace_name      = var.eventhubnamespace
  resource_group_name = var.myresourcegroupname
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name                            = "example"
  target_resource_id              = azurerm_cosmosdb_account.db.id
  eventhub_authorization_rule_id  = data.azurerm_eventhub_namespace_authorization_rule.example.id  
  eventhub_name                   = var.eventhubname
  log_analytics_destination_type  = "AzureDiagnostics"

  log {
    category = "PartitionKeyStatistics"
    enabled  = true
    retention_policy {
      enabled = false
      days    = 0
    }
  }

  log {
    category = "DataPlaneRequests"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = false
    }
  }

log {
    category = "CassandraRequests" 
    enabled  = false 

    retention_policy {
        days    = 0 
        enabled = false 
      }
  }
log {
    category = "ControlPlaneRequests" 
    enabled  = false 

    retention_policy {
        days    = 0 
        enabled = false 
      }
  }
log {
    category = "GremlinRequests" 
    enabled  = false 

    retention_policy {
        days    = 0 
        enabled = false 
      }
  }
log {
    category = "MongoRequests" 
    enabled  = false 

    retention_policy {
        days    = 0 
        enabled = false 
      }
  }
log {
    category = "PartitionKeyRUConsumption" 
    enabled  = false 

    retention_policy {
        days    = 0 
        enabled = false 
      }
  }
log {
    category = "PartitionKeyStatistics" 
    enabled  = true 

    retention_policy {
        days    = 0 
        enabled = false 
      }
  }
log {
    category = "QueryRuntimeStatistics" 
    enabled  = false 

    retention_policy {
        days    = 0 
        enabled = false 
      }
  }
log {
    category = "TableApiRequests" 
    enabled  = false 

    retention_policy {
        days    = 0 
        enabled = false 
      }
  }

  metric {
    category = "Requests"
    enabled  = true
    retention_policy {
      enabled = false
      days    = 0
    }
  }
}

```