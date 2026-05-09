# Maintenance Network - Laptop (Ubuntu)

This script configures an ethernet interface in **Shared to other computers** mode. This allows a Raspberry Pi connected via cable to access the internet through your laptop's WiFi or other active connection.

## Details
- **IP Address:** `10.42.0.1/24` (Gateway for the RPi)
- **Mechanism:** NetworkManager `shared` mode.
- **NAT:** Automatically configured by NetworkManager (masquerade + ip_forward).

## Usage

### Shell Script
The script will attempt to auto-detect your ethernet interface if not provided.

```bash
# Auto-detect and apply
sudo ./setup_laptop.sh

# Manual interface selection
sudo ./setup_laptop.sh enp0s31f6
```

### Ansible
```bash
ansible-playbook setup_laptop.yml -K
```

### Makefile
The Makefile contains a `INTERFACE` variable at the top. Edit it before running if you want to override auto-detection.

```bash
make apply          # Runs the shell script
make ansible        # Runs the ansible playbook
```
