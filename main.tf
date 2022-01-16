module "winccoaSystem-1" {
  source = "./modules/winccoaSystem"
  winccoaSystemName = "firstSystem"
  winccoaSystemIdx = "1"
}

module "winccoaSystem-2" {
  source = "./modules/winccoaSystem"
  winccoaSystemName = "secondSystem"
  winccoaSystemIdx = "2"
}

output "winccoaSystem-1-url" {
  value = "${module.winccoaSystem-1.winccoa-master-url}"
}

output "winccoaSystem-2-url" {
  value = "${module.winccoaSystem-2.winccoa-master-url}"
}
