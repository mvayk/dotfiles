#!/usr/bin/env bash

# --------- ProtonVPN CLI ---------
PROTON_STATUS=$(protonvpn status 2>/dev/null | grep 'Status:' | awk '{print $2}')
if [ "$PROTON_STATUS" = "Connected" ]; then
    SERVER=$(protonvpn status | grep 'Server:' | awk '{print $2}')
    echo "{\"text\":\"  ProtonVPN ($SERVER)\",\"class\":\"vpn-active\"}"
    exit 0
fi

# --------- OpenVPN ---------
OPENVPN=$(pgrep -a openvpn | awk '{print $2}' | xargs)
if [ -n "$OPENVPN" ]; then
    echo "{\"text\":\"  OpenVPN ($OPENVPN)\",\"class\":\"vpn-active\"}"
    exit 0
fi

# --------- WireGuard ---------
WG=$(pgrep -a wg-quick | awk '{print $2}' | xargs)
if [ -n "$WG" ]; then
    echo "{\"text\":\"  WireGuard ($WG)\",\"class\":\"vpn-active\"}"
    exit 0
fi

# --------- NetworkManager VPNs ---------
NM_VPN=$(nmcli -t -f NAME,TYPE con show --active | grep ':vpn' | cut -d: -f1)
if [ -n "$NM_VPN" ]; then
    echo "{\"text\":\"  $NM_VPN\",\"class\":\"vpn-active\"}"
    exit 0
fi

# --------- No VPN ---------
echo "{\"text\":\"  Off\",\"class\":\"vpn-inactive\"}"

