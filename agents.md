# Agent Instructions: Creating New Utils

This document serves as a guide for AI agents contributing to the `30.utils` repository. It defines the workflow, structure, and style conventions to ensure consistency across the toolbox.

## Workflow

When a user requests a new tool:
1.  **Clarify:** Ask targeted questions to understand the OS, target environment, and specific technical requirements.
2.  **Draft:** Propose a plan that includes both Shell and Ansible implementations.
3.  **Execute:** Once approved, implement the tool following the standards below.

## Project Structure

Each tool should be contained within its own directory at the root.

```text
30.utils/
└── tool_name/
    ├── platform_a/
    │   ├── setup_script.sh
    │   ├── setup_playbook.yml
    │   ├── Makefile
    │   └── README.md
    └── platform_b/
        └── ...
```

## Technical Standards

### Implementation Pairs
Every tool must provide:
-   A **Shell Script (`.sh`)**: For quick, zero-dependency local execution.
-   An **Ansible Playbook (`.yml`)**: For idempotent configuration and remote provisioning.

### Network Standards
-   **Service:** Prefer `NetworkManager` (`nmcli`) for generic Linux/RPi and `Netplan` (with NetworkManager renderer) for Ubuntu.
-   **Static IPs:** For direct maintenance links, use the `10.42.0.x` subnet.
-   **Internet Sharing:** For NAT/Sharing, use NetworkManager's `shared` mode on the host (laptop) and configure the client (RPi) with the host as the gateway.

### Makefile Style
-   **Variables:** Place configuration variables (IPs, interfaces, users) at the very top.
-   **PHONY Targets:** Use a separate `.PHONY` declaration for each target immediately above its definition.
-   **Standard Targets:**
    -   `apply`: Run the local shell script.
    -   `ansible`: Run the playbook locally.
    -   `deploy`: Run the playbook against a remote host (using `HOST` and `USER` variables).
    -   `clean`: Revert changes if applicable.
    -   `help`: Display help information for all targets.


### Documentation (README.md)
Every subdirectory must include a `README.md` that covers:
-   The purpose of the tool.
-   Technical details (IPs, files modified).
-   Usage examples for Shell, Ansible, and Makefile.

## Style Conventions
-   **Shell:** Use `#!/bin/bash`, `set -e`, and handle optional arguments for interface names.
-   **Ansible:** Use `become: yes` for system changes and parameterize variables so they can be overridden via `Makefile` or CLI.
-   **Tone:** Keep it professional, engineering-focused, and concise.
