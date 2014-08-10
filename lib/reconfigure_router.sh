#!/usr/bin/expect

set USERNAME [lindex $argv 0]
set PASSWORD [lindex $argv 1]

if {[regexp {^$} $USERNAME] || [regexp {^$} $PASSWORD]} {
	puts "Missing arguments! You must provide username AND password for this script to work:"
	puts "Usage: ./reconfigure_router.sh username password"
	exit
}

spawn telnet 192.168.1.1
expect "Username :"
send "$USERNAME\r"
expect "Password :"
send "$PASSWORD\r"
expect "=>"
send ":dns server forward list\r"
expect "=>"
send ":dns server forward flush\r"
expect "=>"
send ":dns server forward rule add idx=20 set=100 domain=iptv.oitv qtype=A\r"
expect "=>"
send ":dns server forward rule add idx=30 set=100 domain=iptv.microsoft.com qtype=A\r"
expect "=>"
send ":dns server forward rule add idx=50 set=200\r"
expect "=>"
send ":dns server forward dnsset add set=100 dns=172.17.5.9 metric=20 label=toVideoNet intf=Video-Voz\r"
expect "=>"
send ":dns server forward dnsset add set=100 dns=172.17.5.10 metric=20 label=toVideoNet intf=Video-Voz\r"
expect "=>"
send ":dns server forward dnsset add set=200 dns=208.122.23.23 metric=10 intf=Internet\r"
expect "=>"
send ":dns server forward dnsset add set=200 dns=208.122.23.22 metric=10 intf=Internet\r"
expect "=>"
send ":saveall\r"
expect "=>"
send ":exit\r"
exit