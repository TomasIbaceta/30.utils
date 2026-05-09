# Configuration
INTERFACE=enx00e04c6804b9

.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  apply    Run the local shell script to setup sharing"
	@echo "  ansible  Run the ansible playbook locally"
	@echo "  clean    Remove the configuration and revert changes"

.PHONY: apply
apply:
	sudo ./setup_laptop.sh $(INTERFACE)

.PHONY: ansible
ansible:
	ansible-playbook setup_laptop.yml -e "interface_name=$(INTERFACE)" -K

.PHONY: clean
clean:
	sudo rm -f /etc/netplan/99-maintenance-link.yaml
	sudo netplan apply
