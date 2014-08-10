#!/usr/bin/env ruby
require './lib/unblockus'
require './lib/basiclog'
require './lib/settings'

log = BasicLog.new()
settings = Settings.new("./settings.yml").get

unblock_email = settings["email"]
router_username = settings["username"]
router_password = settings["password"]

unblockus = Unblockus.new(unblock_email)

log.logger("----------------------------------")
log.logger("Waking up for new check...")

if !unblockus.is_our_dns
  log.logger("Ops! Wrong DNS found, reconfiguring...")
  exec = `./lib/reconfigure_router.sh #{router_username} #{router_password}`
  log.logger("Finishing reconfiguration. Resuming normal operation.")
else
  log.logger("Everything looks good! Nothing else to do, back to sleep.")
end