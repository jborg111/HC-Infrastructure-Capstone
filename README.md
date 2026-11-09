# HealthConnect Infrastructure Capstone

## Project Overview

This project modernizes the cloud infrastructure of HealthConnect, a fictional healthcare and telemedicine organization.

The solution uses Google Cloud Platform (GCP) and Terraform to provision a segmented cloud network, controlled administrative access, and a private test virtual machine.

The project demonstrates infrastructure as code, cloud networking, access control, and basic infrastructure security validation.

## Project Status

**Implementation and testing completed.**

Infrastructure was deployed, validated, and subsequently destroyed to avoid ongoing cloud resource costs.

## Architecture

The infrastructure includes:

- **Custom VPC:** A manually configured Google Cloud virtual private cloud.
- **Network segmentation:** Three subnets for public, application, and data network tiers.
- **Cloud Router and Cloud NAT:** Outbound connectivity for resources without public IP addresses.
- **Firewall rules:** Controlled ingress for IAP SSH and application traffic.
- **Private test VM:** A Debian 12 virtual machine deployed in the application subnet without an external IP address.
- **Identity-Aware Proxy (IAP):** Controlled administrative SSH access to the private VM.

## Technology Stack

- Google Cloud Platform (GCP)
- Terraform
- Git and GitHub
- Debian 12
- Google Cloud SDK
- PowerShell / Git Bash

## Repository Structure

```text
HC-Infrastructure-Capstone/
├── terraform/
│   ├── compute.tf
│   ├── network.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── .terraform.lock.hcl
├── ansible/
│   └── roles/
├── scripts/
├── documentation/
│   ├── architecture/
│   ├── implementation/
│   └── testing/
├── .gitignore
└── README.md
```

## Validation and Testing

The implementation was validated through the following activities:

1. Terraform configuration formatting and validation.
2. Terraform plan and apply operations.
3. Verification of the deployed network resources and firewall rules.
4. Successful SSH access to the private VM through IAP.
5. Successful outbound connectivity testing using `curl -I https://www.google.com`.
6. Terraform destroy operation and verification that the Terraform state contained no remaining managed resources.

## Security Considerations

The project demonstrates several foundational cloud security practices:

- No external IPv4 address assigned to the test VM.
- Administrative SSH access restricted to Google's IAP TCP forwarding address range.
- Separate network subnets for different infrastructure tiers.
- Firewall rules restricting selected ingress traffic.
- Terraform-managed infrastructure for repeatable deployment.

This is an academic demonstration, not a production-ready healthcare environment. It does not process real patient information or establish HIPAA compliance.

## Cost Management

Cloud resources were deployed temporarily for implementation and testing. They were destroyed after validation to minimize ongoing costs.

## Disclaimer

HealthConnect is a fictional organization created for academic purposes. This project is an educational cloud infrastructure demonstration and is not intended for production healthcare workloads.