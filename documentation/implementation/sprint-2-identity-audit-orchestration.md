\# Sprint 2 – Identity, Audit, and Configuration Orchestration



\## 1. Overview



Sprint 2 extends the HealthConnect cloud infrastructure project by implementing identity-based administrative access, centralized audit logging, and automated server configuration.



The goal was to demonstrate how a private cloud virtual machine can be securely administered and configured without requiring a publicly accessible SSH endpoint or manual server setup.



The implementation uses Google Cloud Platform (GCP), Identity-Aware Proxy (IAP), OS Login, Terraform, and Ansible.



\## 2. Identity and Access Management



The project uses Google Cloud IAM to control administrative access.



The following roles were configured for the administrative account:



\- \*\*IAP-Secured Tunnel User\*\* (`roles/iap.tunnelResourceAccessor`): Allows access through IAP TCP forwarding.

\- \*\*Compute OS Admin Login\*\* (`roles/compute.osAdminLogin`): Allows administrative Linux login through OS Login.

\- \*\*Logs Viewer\*\* (`roles/logging.viewer`): Provides access to view relevant Cloud Logging entries.



OS Login was enabled at the project level through Google Cloud project metadata.



This replaces manually managed SSH account access with centralized identity and permission management.



\## 3. Secure Administrative Connectivity



The test virtual machine, `hc-test-vm`, was deployed in the private application subnet.



Security controls include:



\- No external IP address assigned to the VM.

\- SSH ingress restricted to Google's IAP TCP forwarding range (`35.235.240.0/20`).

\- OS Login used for identity-based SSH authentication.

\- Administrative access established through an IAP tunnel.



Connectivity was validated using Google Cloud CLI from the local WSL environment.



\## 4. Ansible Configuration Management



Ansible was used to automate baseline server configuration and web server deployment.



The project contains two playbooks:



\### Baseline configuration – `site.yml`



The baseline playbook performs the following tasks:



\- Installs `curl`, `jq`, and `unzip`.

\- Creates a proof file at `/etc/hc\_sprint2\_proof.txt`.

\- Verifies the proof file contents.

\- Displays the verification result.



\### Web server deployment – `web\_setup.yml`



The web deployment playbook:



\- Installs Nginx.

\- Ensures the Nginx service is running and enabled.

\- Deploys a demonstration HealthConnect portal homepage.



The Ansible inventory contains local connection information and is excluded from Git through `.gitignore`.



\## 5. Audit Logging and Monitoring



Cloud Audit Logs were examined to verify administrative activity.



Two categories of activity were validated:



\*\*Compute Admin Activity\*\*



A temporary VM metadata update was performed to generate a recognizable Compute API audit event.



The resulting logs identified:



\- The authenticated administrative account.

\- The Compute API method `v1.compute.instances.setMetadata`.

\- The affected VM resource, `hc-test-vm`.



\*\*OS Login Data Access\*\*



OS Login logs were queried to identify authentication and login-policy activity.



Observed methods included:



\- `ListLoginProfiles`

\- `CheckPolicy`



These records demonstrate that identity-related access activity can be examined through Cloud Audit Logs.



\## 6. Security Considerations



The implementation demonstrates several foundational security practices:



\- Centralized identity and access management.

\- Private virtual machine deployment without a public IP.

\- Restricted administrative access through IAP.

\- Automated configuration management.

\- Centralized audit logging.

\- Separation of local connection details from publicly published project files.



This project is an academic demonstration. It does not process real patient information and does not establish HIPAA compliance or production readiness.



\## 7. Outcome



Sprint 2 successfully demonstrated identity-based access, private administrative connectivity, automated server configuration, and audit-log validation.



The resulting infrastructure provides a foundation for repeatable cloud deployment and configuration while reducing reliance on manual server administration.



