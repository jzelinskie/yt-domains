#!/bin/sh

# This script aggregates various resources to compile a list of YouTube tracking and advertising domains.
#
# For more info, see the following:
# https://gist.github.com/ErikFontanel/4ee1ab393b119690a293ba558976b113
# https://discourse.pi-hole.net/t/how-do-i-block-ads-on-youtube/253/136

HACKER_TARGET_DOMAINS=$(curl 'https://api.hackertarget.com/hostsearch/?q=googlevideo.com' | awk -F, 'NR>1{print $1}' | grep -vE "redirector|manifest")
HACKER_TARGET_DOMAINS_WITH_DASHES=$(echo $DOMAINS | sed -r -E 's#(r[0-9]+)\.sn-([A-Za-z]+)#\1---sn-\2#g')

SUNSHINE_DOMAINS=$(curl https://www.sunshine.it/blacklist.txt | sed 's/$//' | grep 'googlevideo.com')

printf "%s\n" $SUNSHINE_DOMAINS $HACKER_TARGET_DOMAINS $HACKER_TARGET_DOMAINS_WITH_DASHES | sort | uniq
