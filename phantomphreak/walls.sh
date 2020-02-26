#!/bin/bash

echo "phantomphreak: Tor entry node (TCP 9050), no scored services"

ip6tables -t mangle -P INPUT DROP
ip6tables -t mangle -P OUTPUT DROP
iptables -t mangle -F
iptables -t mangle -X
iptables -F
iptables -X

iptables -t mangle -A INPUT -i lo -j ACCEPT
iptables -t mangle -A OUTPUT -o lo -j ACCEPT

iptables -t mangle -A INPUT -p tcp --dport 9050 -j ACCEPT
iptables -t mangle -A OUTPUT -p tcp --sport 9050 -m state --state=ESTAB,REL -j ACCEPT

#allow syslog out if needed
#iptables -t mangle -A OUTPUT -p udp --dport 514 -j ACCEPT
#iptables -t mangle -A INPUT -p udp --sport 514 -m state --state=ESTAB,REL -j ACCEPT

iptables -t mangle -A INPUT -j DROP
iptables -t mangle -A OUTPUT -j DROP