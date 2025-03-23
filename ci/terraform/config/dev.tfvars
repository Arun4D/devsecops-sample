config = {
  location = "East US",

  resource_group = {
    app1 = "kpiVisualization-rg"
  }

  vnet = {
    vnet_name     = "kpiVisualizationVNet",
    address_space = ["10.0.0.0/16"],
    subnet       = {
      subnet_name     = "kpiVisualizationSubnet",
      address_prefix  = ["10.0.2.0/24"]
    }
  }
  environment_tags = {
    environment = "dev",
    cost_center = "1564",
    owner       = "AdM"
  }
}

