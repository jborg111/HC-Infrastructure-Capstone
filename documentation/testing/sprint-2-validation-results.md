\# Sprint 2 – Validation and Testing Results



\## 1. Testing Overview



This document records the validation performed during Sprint 2 of the HealthConnect Infrastructure Capstone.



Testing focused on identity-based access, private VM connectivity, Ansible automation, configuration idempotence, and Cloud Audit Logs.



All tests were performed against the deployed Google Cloud test environment.



\## 2. IAM and OS Login Validation



| Test | Expected Result | Result |

|---|---|---|

| IAM role assignments | Required administrative roles configured | Passed |

| OS Login project metadata | `enable-oslogin=TRUE` | Passed |

| IAP SSH connectivity | Successful login through IAP | Passed |

| External VM IP | No external IP assigned | Passed |



The VM was accessed using Google Cloud CLI with IAP tunneling and OS Login authentication.



\## 3. Ansible Connectivity Validation



Command:



```bash

ansible webservers -i inventory.ini -m ping

```



Expected result:



```text

hc-test-vm | SUCCESS => {

&#x20;   "changed": false,

&#x20;   "ping": "pong"

}

```



\*\*Result: Passed\*\*



Ansible successfully connected to the private VM through the IAP tunnel.



\## 4. Baseline Configuration Validation



Playbook:



```bash

ansible-playbook -i inventory.ini site.yml

```



The baseline playbook installed the required utilities, created the proof file, and verified its contents.



First execution:



```text

PLAY RECAP

hc-test-vm : ok=5 changed=2 unreachable=0 failed=0

```



The proof file contained:



```text

Sprint2 baseline applied by Ansible

```



Second execution:



```text

PLAY RECAP

hc-test-vm : ok=5 changed=0 unreachable=0 failed=0

```



\*\*Result: Passed\*\*



The second execution reported zero changes, demonstrating idempotent configuration management.



\## 5. Nginx Deployment Validation



Playbook:



```bash

ansible-playbook -i inventory.ini web\_setup.yml

```



First execution:



```text

PLAY RECAP

hc-test-vm : ok=4 changed=2 unreachable=0 failed=0

```



Nginx was installed, started, enabled, and configured with a demonstration HealthConnect homepage.



The homepage was verified locally on the VM using:



```bash

ansible webservers -i inventory.ini -m command -a "curl -s http://localhost"

```



The returned HTML included the title:



```text

HealthConnect Secure Portal

```



Second execution:



```text

PLAY RECAP

hc-test-vm : ok=4 changed=0 unreachable=0 failed=0

```



\*\*Result: Passed\*\*



The deployment succeeded, the homepage was served locally, and the second execution made no configuration changes.



\## 6. Cloud Audit Logs Validation



\### Compute Admin Activity



A temporary VM metadata update generated a Compute API administrative event.



The log query identified:



\- Authenticated administrative account.

\- `v1.compute.instances.setMetadata` method.

\- Affected resource: `hc-test-vm`.



\*\*Result: Passed\*\*



\### OS Login Data Access



Cloud Audit Logs were queried for:



```text

protoPayload.serviceName="oslogin.googleapis.com"

```



The results included:



\- `ListLoginProfiles`

\- `CheckPolicy`



The records demonstrated that OS Login identity and policy activity was available for examination.



\*\*Result: Passed\*\*



\## 7. Terraform Validation



Terraform configuration validation and planning were performed.



The final reviewed plan reported:



```text

Plan: 0 to add, 1 to change, 0 to destroy.

```



The single proposed in-place change removes the temporary `hc-audit-test` metadata marker used during audit-log testing.



No infrastructure replacement or destruction was proposed by this plan.



\*\*Result: Passed\*\*



\## 8. Overall Results



| Validation Area | Result |

|---|---|

| IAM configuration | Passed |

| OS Login | Passed |

| IAP connectivity | Passed |

| Ansible connectivity | Passed |

| Baseline configuration | Passed |

| Baseline idempotence | Passed |

| Nginx deployment | Passed |

| Homepage verification | Passed |

| Nginx idempotence | Passed |

| Compute Admin Activity logs | Passed |

| OS Login Data Access logs | Passed |

| Terraform plan review | Passed |



\## 9. Limitations



Testing was performed using a limited academic cloud environment and a single demonstration virtual machine.



The Nginx homepage was verified locally on the VM; public internet access to the portal was not demonstrated.



No real patient information was used. The project is not a production healthcare deployment and does not establish HIPAA compliance.



\## 10. Conclusion



Sprint 2 successfully demonstrated centralized identity management, secure administrative access to a private virtual machine, automated server configuration, repeatable deployments, and audit-log validation.



The test results support the effectiveness of the implemented configuration and provide evidence of successful infrastructure and automation workflows.



