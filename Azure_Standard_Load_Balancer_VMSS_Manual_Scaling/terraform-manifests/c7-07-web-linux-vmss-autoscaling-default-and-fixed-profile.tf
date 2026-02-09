resource "azurerm_monitor_autoscale_setting" "web_vmss" {
  name = "${local.resource_name_prefix}-web-vmss-autoscale-profile"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  target_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id

  # Notification block
notification {
    email {
      send_to_subscription_administrator    = true
      send_to_subscription_co_administrator = true
      custom_emails                         = ["karuppaswamiks@gmail.com"]
    }
  }
# Autoscale by Recurrence Profile based on week days
profile {
    name = "profile-2-weekdays"
    capacity {
      default = 4
      maximum = 8
      minimum = 4
    }
    # Fixed Block for a specific day
    fixed_date {
      timezone = "Central European Time"
      start = "2026-02-15T00:00:00Z"
      end = "2026-02-15T00:00:00Z"
    }
    # Rule to increase the VM count depend on CPU
    rule {
      scale_action {
        direction = "Increase"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M" # 5 minute Cooling time
      }
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        time_grain         = "PT1M"  # Every 1 min 
        statistic          = "Average"
        time_window        = "PT5M"  # Every 5 min time interval
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }
    }
# Rule to decrease the VM count depend on CPU
   rule {
      scale_action {
        direction = "Decrease"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M" # 5 minute Cooling time
      }
      metric_trigger {
        metric_name        = "Available Memory Bite"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        time_grain         = "PT1M"  # Every 1 min 
        statistic          = "Average"
        time_window        = "PT5M"  # Every 5 min time interval
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }
    }
# Rule to increase the VM count depend on Memory
    rule {
      scale_action {
        direction = "Increase"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M" # 5 minute Cooling time
      }
      metric_trigger {
        metric_name        = "Available Memory Bite"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        time_grain         = "PT1M"  # Every 1 min 
        statistic          = "Average"
        time_window        = "PT5M"  # Every 5 min time interval
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 1073741824  # Increase the VM when Memory In Bytes 
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }
    }
# Rule to decrease the VM count depend on CPU
    rule {
      scale_action {
        direction = "Decrease"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M" # 5 minute Cooling time
      }
      metric_trigger {
        metric_name        = "Available Memory Bite"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        time_grain         = "PT1M"  # Every 1 min 
        statistic          = "Average"
        time_window        = "PT5M"  # Every 5 min time interval
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 2147483648
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }
    }
# LB SYN Count Metrix Rule 
# Increase 
    rule {
      scale_action {
        direction = "Increase"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M" # 5 minute Cooling time
      }
      metric_trigger {
        metric_name        = "SYNCount"
        metric_resource_id = azurerm_lb.web_lb.id
        time_grain         = "PT1M"  # Every 1 min 
        statistic          = "Average"
        time_window        = "PT5M"  # Every 5 min time interval
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 10
        metric_namespace   = "Microsoft.Network/loadBalancers"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }
    }
# Decrease 
    rule {
      scale_action {
        direction = "Decrease"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M" # 5 minute Cooling time
      }
      metric_trigger {
        metric_name        = "SYNCount"
        metric_resource_id = azurerm_lb.web_lb.id
        time_grain         = "PT1M"  # Every 1 min 
        statistic          = "Average"
        time_window        = "PT5M"  # Every 5 min time interval
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 10
        metric_namespace   = "Microsoft.Network/loadBalancers"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }
    }
  }
# Autoscale by Recurrence Profile based on weekend days
profile {
    name = "profile-2-weekend"
    capacity {
      default = 2
      maximum = 4
      minimum = 2
    }
    # Recurrence Block for week days (5 Days)
    recurrence {
      timezone = "Central European Time"
      days = [ "Sunday","Saturday"]
      hours = [ 0 ]
      minutes = [ 0 ]
    }
    # Rule to increase the VM count depend on CPU
    rule {
      scale_action {
        direction = "Increase"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M" # 5 minute Cooling time
      }
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        time_grain         = "PT1M"  # Every 1 min 
        statistic          = "Average"
        time_window        = "PT5M"  # Every 5 min time interval
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }
    }
# Rule to decrease the VM count depend on CPU
   rule {
      scale_action {
        direction = "Decrease"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M" # 5 minute Cooling time
      }
      metric_trigger {
        metric_name        = "Available Memory Bite"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        time_grain         = "PT1M"  # Every 1 min 
        statistic          = "Average"
        time_window        = "PT5M"  # Every 5 min time interval
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }
    }
# Rule to increase the VM count depend on Memory
    rule {
      scale_action {
        direction = "Increase"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M" # 5 minute Cooling time
      }
      metric_trigger {
        metric_name        = "Available Memory Bite"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        time_grain         = "PT1M"  # Every 1 min 
        statistic          = "Average"
        time_window        = "PT5M"  # Every 5 min time interval
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 1073741824  # Increase the VM when Memory In Bytes 
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }
    }
# Rule to decrease the VM count depend on CPU
    rule {
      scale_action {
        direction = "Decrease"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M" # 5 minute Cooling time
      }
      metric_trigger {
        metric_name        = "Available Memory Bite"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
        time_grain         = "PT1M"  # Every 1 min 
        statistic          = "Average"
        time_window        = "PT5M"  # Every 5 min time interval
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 2147483648
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }
    }
# LB SYN Count Metrix Rule 
# Increase 
    rule {
      scale_action {
        direction = "Increase"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M" # 5 minute Cooling time
      }
      metric_trigger {
        metric_name        = "SYNCount"
        metric_resource_id = azurerm_lb.web_lb.id
        time_grain         = "PT1M"  # Every 1 min 
        statistic          = "Average"
        time_window        = "PT5M"  # Every 5 min time interval
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 10
        metric_namespace   = "Microsoft.Network/loadBalancers"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }
    }
# Decrease 
    rule {
      scale_action {
        direction = "Decrease"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M" # 5 minute Cooling time
      }
      metric_trigger {
        metric_name        = "SYNCount"
        metric_resource_id = azurerm_lb.web_lb.id
        time_grain         = "PT1M"  # Every 1 min 
        statistic          = "Average"
        time_window        = "PT5M"  # Every 5 min time interval
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 10
        metric_namespace   = "Microsoft.Network/loadBalancers"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }
    }
  }
}