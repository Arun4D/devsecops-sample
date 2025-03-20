locals {
  config_final      = merge(var.config, var.global_map)
  global_tags_final = merge(local.config_final.global_tags, local.config_final.environment_tags)
}