#!/bin/bash
# Raspberry Pi Maintenance Network Setup (10.42.0.2 with Gateway)
set -e

INTERFACE=$1

if [ -z "$INTERFACE" ]; then
    echo "Searching for ethernet interfaces..."
    INTERFACE=$(nmcli -t -f DEVICE,TYPE device status | grep ":ethernet$" | cut -d: -f1 | head -n 1)
fi

if [ -z "$INTERFACE" ]; then
    echo "Error: No ethernet interface found via nmcli."
    exit 1
fi

echo "Configuring $INTERFACE..."

# Clean up existing connection if it exists
sudo nmcli connection delete maintenance-link 2>/dev/null || true

# Add new connection with Gateway and DNS for Internet Access
sudo nmcli connection add type ethernet con-name maintenance-link ifname "$INTERFACE" \
    ipv4.method manual \
    ipv4.addresses 10.42.0.2/24 \
    ipv4.gateway 10.42.0.1 \
    ipv4.dns "10.42.0.1,8.8.8.8" \
    connection.autoconnect yes

sudo nmcli connection up maintenance-link

echo "Done. RPi IP: 10.42.0.2"
echo "Testing connectivity to laptop (10.42.0.1)..."
ping -c 3 10.42.0.1
echo "Testing internet access (8.8.8.8)..."
ping -c 3 8.8.8.8 || echo "Internet check failed. Ensure laptop is sharing correctly."
