provider "google" {
  project = "sre-testing-363305"
  region  = "asia-east1"
  credentials = "/Users/davindersingh/.ssh/sre-testing-363305-10caebfe813b.json"
}

module "webserver" {
  source = "./webserver"
}

module "dbserver" {
  source = "./dbserver"
}

module "loadbalancer" {
  source        = "./loadbalancer"
  backend_group = module.webserver.instance_group
}
module "firewall" {
  source = "./firewall"
  
}