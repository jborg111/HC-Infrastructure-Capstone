# HealthConnect Infrastructure Capstone

## Project Overview

This project demonstrates the modernization of a fictional healthcare and telemedicine organization's cloud infrastructure.

The solution uses Google Cloud Platform (GCP), Terraform, and Ansible to provision and manage a segmented cloud network, secure administrative access, and automated server configuration.

The project emphasizes infrastructure as code, identity-based access control, network security, configuration management, and cloud audit logging.


## Project Status

 Implementation, deployment, validation, and final cloud resource cleanup completed. All 10 Terraform-managed GCP resources were successfully destroyed after testing to prevent ongoing cloud costs.

The project includes Terraform infrastructure-as-code, Ansible configuration management, IAM and OS Login controls, IAP-based SSH access, and Cloud Audit Logging validation.
## Architecture

The infrastructure includes:

- **Custom VPC:** A manually configured Google Cloud virtual private cloud.
- **Network segmentation:** Three subnets separating public, application, and data tiers.
- **Cloud Router and Cloud NAT:** Controlled outbound connectivity for private resources.
- **Firewall rules:** Restricted administrative access through Google's IAP TCP forwarding range.
- **Private virtual machine:** Debian 12 test VM without an external IP address.
- **Identity-Aware Proxy (IAP):** Secure administrative SSH access.
- **OS Login:** Centralized identity-based Linux authentication.

## Configuration Management

Ansible automates server configuration through two playbooks:

- `ansible/site.yml` — Installs baseline utilities and creates and verifies a configuration proof file.
- `ansible/web_setup.yml` — Installs and configures Nginx and deploys a demonstration HealthConnect homepage.

Both playbooks were tested for idempotence. Subsequent executions completed with zero configuration changes.

The Ansible inventory is maintained locally and excluded from Git.

## Audit Logging

Cloud Audit Logs were examined to validate administrative and identity-related activity.

Testing included:

- Compute Admin Activity events generated through a VM metadata update.
- OS Login Data Access events, including login-profile and policy-check operations.

These tests demonstrate how cloud administrative activity can be examined through centralized logging.

## Technology Stack

- Google Cloud Platform (GCP)
- Terraform
- Ansible
- Debian 12
- Nginx
- Google Cloud SDK
- Identity-Aware Proxy (IAP)
- OS Login
- Cloud Audit Logs
- Git and GitHub
- WSL Ubuntu / Git Bash

## Repository Structure

```text
HC-Infrastructure-Capstone/
├── ansible/
│   ├── site.yml
│   └── web_setup.yml
├── documentation/
│   ├── implementation/
│   │   └── sprint-2-identity-audit-orchestration.md
│   ├── testing/
│   │   └── sprint-2-validation-results.md
│   └── screenshots/
├── terraform/
│   ├── network.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── .terraform.lock.hcl
├── .gitignore
└── README.md
```

Local Terraform state, variable files, credentials, SSH keys, and Ansible inventory files are excluded from version control.

## Validation and Testing

The implementation was validated through:

1. Terraform configuration validation and planning.
2. Deployment and verification of Google Cloud network resources.
3. Confirmation that the test VM has no external IP address.
4. Successful SSH access through IAP and OS Login.
5. Successful Ansible connectivity testing.
6. Baseline configuration deployment and idempotence testing.
7. Nginx deployment and local homepage verification.
8. Nginx playbook idempotence testing.
9. Retrieval of Compute Admin Activity and OS Login audit events.

Detailed implementation and test results are available in the `documentation/` directory.

## Security Considerations

The project demonstrates foundational cloud security practices:

- No public IP address on the test VM.
- Administrative SSH restricted to IAP.
- Centralized identity management through OS Login and IAM.
- Segmented network architecture.
- Controlled outbound connectivity through Cloud NAT.
- Automated configuration management.
- Centralized audit logging.
- Exclusion of sensitive local configuration files from Git.

This is an academic demonstration, not a production-ready healthcare environment. It does not process real patient information or establish HIPAA compliance.

## Cost Management

Cloud resources were deployed temporarily for implementation and testing. Final cleanup will be performed after validation to minimize ongoing cloud costs.

## Disclaimer

HealthConnect is a fictional organization created for academic purposes. This project is an educational cloud infrastructure demonstration and is not intended for production healthcare workloads.
