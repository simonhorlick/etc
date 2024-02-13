#!/bin/bash

ip=$(ip addr show dev eno1 | grep inet6 | grep global | grep -v deprecated | awk '{print $2}' | cut -d/ -f1 | head -1)
ip4=$(curl -4 ifconfig.co)

ZONEID=76b10176465605f0ab28c1802de715e9 # from the main overview screen
TOKEN=xGRXL7FummliMEBYQqjz46IH6GiQiGTmK-nw8eo5 # generated from https://dash.cloudflare.com/profile/api-tokens

# curl -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" \
#      -H "Authorization: Bearer $TOKEN" \
#      -H "Content-Type:application/json"

# The RID is from this request:
#curl --request GET \
#  --url https://api.cloudflare.com/client/v4/zones/$ZONEID/dns_records \
#  --header 'Content-Type: application/json' \
#  --header "Authorization: Bearer $TOKEN"
RID=f7ea9d51942dd4c696dbd93432cc3d8d # kl.horlick.me AAAA

curl -vvv --request PUT \
  --url https://api.cloudflare.com/client/v4/zones/$ZONEID/dns_records/$RID \
  --header 'Content-Type: application/json' \
  --header "Authorization: Bearer $TOKEN" \
  --data "{\"content\":\"$ip\",\"name\":\"kl.horlick.me\",\"type\":\"AAAA\"}"


ZONEID_JUSI=c31459017fe654392d87c13d9a5d44c9
# The RID is from this request:
#curl --request GET \
#  --url https://api.cloudflare.com/client/v4/zones/$ZONEID_JUSI/dns_records \
#  --header 'Content-Type: application/json' \
#  --header "Authorization: Bearer $TOKEN"
RID=09831fab8d01e7d7b470611d4e38d344

curl -vvv --request PUT \
  --url https://api.cloudflare.com/client/v4/zones/$ZONEID_JUSI/dns_records/$RID \
  --header 'Content-Type: application/json' \
  --header "Authorization: Bearer $TOKEN" \
  --data "{\"content\":\"$ip\",\"name\":\"kl.jusi.house\",\"type\":\"AAAA\"}"

RID=ee243215dd51125f2ff667d92d37159c
curl -vvv --request PUT \
  --url https://api.cloudflare.com/client/v4/zones/$ZONEID_JUSI/dns_records/$RID \
  --header 'Content-Type: application/json' \
  --header "Authorization: Bearer $TOKEN" \
  --data "{\"content\":\"$ip4\",\"name\":\"router.jusi.house\",\"type\":\"A\"}"

