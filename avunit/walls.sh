#!/bin/bash

echo "avunit: XMPP, SSH [Tor network]"

ip6tables -t mangle -P INPUT DROP
ip6tables -t mangle -P OUTPUT DROP
iptables -t mangle -F
iptables -t mangle -X
iptables -F
iptables -X

#SSH
iptables -t mangle -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -t mangle -A OUTPUT -p tcp --sport 22 -m state --state=ESTAB,REL -j ACCEPT

#XMPP
iptables -t mangle -A INPUT -p tcp --dport 5222 -j ACCEPT
iptables -t mangle -A OUTPUT -p tcp --sport 5222 -m state --state=ESTAB,REL -j ACCEPT

#allow syslog out if needed
#iptables -t mangle -A OUTPUT -p udp --dport 514 -j ACCEPT
#iptables -t mangle -A INPUT -p udp --sport 514 -m state --state=ESTAB,REL -j ACCEPT

iptables -t mangle -A INPUT -j DROP
iptables -t mangle -A OUTPUT -j DROP

#very important on this remote box
sleep 5
iptables -t mangle -F
iptables -t mangle -X
iptables -F
iptables -X