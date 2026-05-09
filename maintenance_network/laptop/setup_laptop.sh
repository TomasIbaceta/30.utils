#!/bin/bash
# Ubuntu Laptop Maintenance Network Setup (Shared/NAT)
set -e

INTERFACE=$1

if [ -z "$INTERFACE" ]; then
    echo "Searching for ethernet interfaces..."
    INTERFACE=$(ip -o link show | awk -F': ' '{print $2}' | grep -E '^(en|eth)' | head -n 1)
fi

if [ -z "$INTERFACE" ]; then
    echo "Error: No ethernet interface found."
    exit 1
fi

echo "Configuring $INTERFACE for Internet Sharing (Shared to other computers)..."

# Clean up Netplan file if it exists to avoid conflicts
if [ -f /etc/netplan/99-maintenance-link.yaml ]; then
    sudo rm /etc/netplan/99-maintenance-link.yaml
    sudo netplan apply
fi

# Use nmcli to set up 'shared' mode (NAT + DHCP/DNS server)
sudo nmcli connection delete maintenance-link 2>/dev/null || true
sudo nmcli connection add type ethernet con-name maintenance-link ifname "$INTERFACE" \
    ipv4.method shared ipv4.addresses 10.42.0.1/24 \
    connection.autoconnect yes

sudo nmcli connection up maintenance-link
echo "Done. Laptop is now sharing internet on 10.42.0.1"
