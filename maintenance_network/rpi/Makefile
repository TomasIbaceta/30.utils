# Configuration
HOST=100.98.253.61
USER=myrpi
INTERFACE=eth0

.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  apply    Run the local shell script to setup the interface"
	@echo "  ansible  Run the ansible playbook locally"
	@echo "  deploy   Provision a remote RPi using HOST and USER variables"
	@echo "  clean    Remove the connection"

# Local execution
.PHONY: apply
apply:
	sudo ./setup_rpi.sh $(INTERFACE)

# Local ansible execution
.PHONY: ansible
ansible:
	ansible-playbook setup_rpi.yml -e "interface_name=$(INTERFACE)" -K

# Remote ansible execution
.PHONY: deploy
deploy:
	ansible-playbook -i $(HOST), setup_rpi.yml -u $(USER) -e "interface_name=$(INTERFACE)" -K

.PHONY: clean
clean:
	sudo nmcli connection delete maintenance-link
