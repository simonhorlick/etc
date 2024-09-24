#!/bin/bash

source /etc/cf-dns.env

ip=$(ip addr show dev enp9s0f0 | grep inet6 | grep global | grep -v deprecated | awk '{print $2}' | cut -d/ -f1 | head -1)

# The RID is from this request:
#curl --request GET \
#  --url https://api.cloudflare.com/client/v4/zones/$ZONEID_JUSI/dns_records \
#  --header 'Content-Type: application/json' \
#  --header "Authorization: Bearer $CF_AUTH_TOKEN"

ZONEID_JUSI=c31459017fe654392d87c13d9a5d44c9

RID=09831fab8d01e7d7b470611d4e38d344
curl -vvv --request PUT \
  --url https://api.cloudflare.com/client/v4/zones/$ZONEID_JUSI/dns_records/$RID \
  --header 'Content-Type: application/json' \
  --header "Authorization: Bearer $CF_AUTH_TOKEN" \
  --data "{\"content\":\"$ip\",\"name\":\"kul.jusi.house\",\"type\":\"AAAA\"}"
