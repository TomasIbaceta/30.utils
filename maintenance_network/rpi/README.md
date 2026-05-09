# Maintenance Network - Raspberry Pi

This script configures a static IP on the Raspberry Pi with a gateway and DNS to allow internet access through a connected laptop.

## Details
- **IP Address:** `10.42.0.2/24`
- **Gateway:** `10.42.0.1` (The Laptop)
- **DNS:** `10.42.0.1` and `8.8.8.8`
- **Mechanism:** NetworkManager (`nmcli`).

## Usage

### Shell Script
The script will attempt to auto-detect the ethernet interface.

```bash
# Auto-detect and apply
sudo ./setup_rpi.sh

# Manual interface selection
sudo ./setup_rpi.sh eth0
```

### Ansible (Local)
```bash
# Run on the RPi itself
ansible-playbook setup_rpi.yml -K
```

### Ansible (Remote Provisioning)
If you have a fresh RPi that is already on your network (e.g., via WiFi), you can provision the static ethernet IP remotely.

```bash
# Using the Makefile
make deploy HOST=192.168.1.50 USER=pi

# Or using ansible directly
ansible-playbook -i 192.168.1.50, setup_rpi.yml -u pi -K
```

### Makefile
The Makefile contains configuration variables at the top. Edit these before running:
- `HOST`: Remote IP of the RPi (for `deploy`).
- `USER`: Username (usually `pi`).
- `INTERFACE`: Target ethernet interface (default `eth0`).

```bash
make apply          # Runs the shell script locally
make ansible        # Runs the ansible playbook locally
make deploy         # Provisions a remote RPi using HOST and USER
```
