#!/bin/bash

echo "viral: ICMP, SMTP, IMAP, HTTP, SSH [Dev cloud]"

ip6tables -t mangle -P INPUT DROP
ip6tables -t mangle -P OUTPUT DROP
iptables -t mangle -F
iptables -t mangle -X
iptables -F
iptables -X

#Reply to ping
iptables -t mangle -A INPUT -p icmp --icmp-type 8 -j ACCEPT
iptables -t mangle -A OUTPUT -p icmp --icmp-type 0 -m state --state ESTABLISHED,RELATED -j ACCEPT


#SSH
iptables -t mangle -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -t mangle -A OUTPUT -p tcp --sport 22 -m state --state=ESTAB,REL -j ACCEPT

#SMTP/SMTPS (check which is running)
iptables -t mangle -A INPUT -p tcp --dport 25 -j ACCEPT
iptables -t mangle -A OUTPUT -p tcp --sport 25 -m state --state=ESTAB,REL -j ACCEPT
iptables -t mangle -A INPUT -p tcp --dport 587 -j ACCEPT
iptables -t mangle -A OUTPUT -p tcp --sport 587 -m state --state=ESTAB,REL -j ACCEPT

#IMAP/IMAPS (check which is running)
iptables -t mangle -A INPUT -p tcp --dport 143 -j ACCEPT
iptables -t mangle -A OUTPUT -p tcp --sport 143 -m state --state=ESTAB,REL -j ACCEPT
iptables -t mangle -A INPUT -p tcp --dport 993 -j ACCEPT
iptables -t mangle -A OUTPUT -p tcp --sport 993 -m state --state=ESTAB,REL -j ACCEPT

#HTTP
iptables -t mangle -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t mangle -A OUTPUT -p tcp --sport 80 -m state --state=ESTAB,REL -j ACCEPT

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