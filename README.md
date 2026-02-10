Azure Infrastructure Automation (Terraform)
Project Overview
This repository contains a progressive series of projects demonstrating the use of HashiCorp Terraform to deploy standardized, scalable, and secure Azure architectures. By moving from foundational networking to complex, auto-scaling environments, this project aligns with Infrastructure as Code (IaC) and Site Reliability Engineering (SRE) principles to ensure consistent environment provisioning.

Infrastructure Specifications
The projects define a series of production-ready environments including:

1. Compute Resources
Virtual Machines (Linux): Specialized deployments using SSH keys and automated provisioning via custom_data.

Virtual Machine Scale Sets (VMSS): High-availability compute clusters with both manual and dynamic metric-based scaling.

2. Networking Architecture
4-Tier VNET Design: Dedicated address spaces for Web, App, DB, and Bastion subnets for strict traffic isolation.

Connectivity Services: Implementation of Azure Bastion for secure management and Standard Load Balancers for high-traffic distribution.

3. Security & Governance
Network Security Groups (NSG): Granular traffic control via priority-based rules, reflecting my experience in Banking GRC and BaFin compliance.

Public IPs & Interfaces: Precise mapping of network components to compute resources.

Technical Highlights
Meta-Arguments & Logic: Implementation of count, for_each, depends_on, and locals for advanced resource orchestration.

Dynamic Provisioning: Use of filebase64 for bootstrap scripting and automated web server (Apache) installation.

Auto-Scaling Intelligence: Multi-profile scaling logic based on CPU/Memory metrics, recurrence schedules (weekly/weekend), and fixed time windows.

Modular Variables: Systematic use of input variables for environment flexibility and output variables for secure data extraction.

Project-Specific Details
**Project 1: Azure_vnet_4Tier**
Scope: Creation of a foundational Virtual Network and segmented subnets.

Implementation: All subnets (Web, App, DB, Bastion) are deployed within a single Resource Group to ensure simplified management and shared security policies.

Logic: Uses a modular approach where the VNET configuration is decoupled from the specific subnet variables.

Deployment Instructions
To ensure operational integrity and safety, follow the standardized Terraform workflow.

⚠️ Operational Safety Policy
Development/Test Environments: The -auto-approve flag may be used for rapid iteration if the resources are well-understood.

Pre-Production/Production: The -auto-approve flag is strictly prohibited. A manual review of the terraform plan output is required to ensure compliance with high-security banking standards and to prevent accidental resource destruction.

**Project 2: Azure_Linux_VM_Vnet_Web_Subnet**
**Project Overview**
This project demonstrates the use of Terraform to deploy a functional web server infrastructure within a multi-tier network. By automating the provisioning of Linux Virtual Machines and their networking dependencies, this repository ensures a "ready-to-use" environment, aligning with Infrastructure as Code (IaC) and automated bootstrapping principles.

Infrastructure Specifications
The configuration defines a production-ready web tier including:

Compute Resources:
Linux Virtual Machine: Provisioned with high-performance SKUs, utilizing SSH keys for secure authentication and specialized OS disk configurations.

Automated Bootstrapping: Integration of custom_data to automatically install the Apache web server and render a base HTML landing page upon resource creation.

Network Security & Connectivity:
Segmented Networking: Deployment of a 4-tier VNET (App, DB, Web, Bastion subnets) in a single Resource Group.

Public Connectivity: Automated assignment of Public IPs and Network Interfaces (NIC).

Network Security Group (NSG): Granular rules to permit web traffic while maintaining restricted access to backend resources.

Technical Highlights
Advanced Logic Functions: Utilization of locals for resource naming consistency and filebase64/basedecode64 for secure script injection.

Dynamic Referencing: Implementation of Source Image References to ensure standardized OS versions across deployments.

Variable Modularization: Comprehensive use of Input Variables for customization and Output Variables to capture critical infrastructure metadata.

**Project 3: Azure_Bastion_Host**
**Project Overview**
This project enhances infrastructure security by introducing a Zero Trust administrative access layer. It builds upon the Linux Web Server architecture to implement Azure Bastion, providing secure, browser-based RDP and SSH access without exposing backend Virtual Machines to the public internet.

Infrastructure Specifications
The templates define a high-security management environment including:

Management & Security:
Azure Bastion Service: A fully managed PaaS service deployed within a dedicated AzureBastionSubnet.

Secure Access Layer: Designed to facilitate administrative connections to internal VMs using both Bastion and Load Balancer pathways.

Network Security & Connectivity:
Hardened NSG Rules: Specialized rules implemented to ensure the Web Subnet only accepts traffic from valid Load Balancer probes and Bastion service IPs.

Unified Resource Management: All networking components (4-tier subnets) and compute resources (Linux VM, NIC, Public IP) are managed within a synchronized lifecycle.

Technical Highlights
Multi-Factor Connectivity: Validation of secure connection strings using Bastion in tandem with Standard Load Balancers.

Declarative Security Concepts: Direct implementation of the "Least Privilege" access model, reflecting my experience in Banking GRC and BaFin compliance.

State-Based Deployment: Leverages advanced output variables to track Bastion Host status and connectivity endpoints.


**Project 4: Azure_Standard_Load_Balancer**
**Project Overview**
This project demonstrates the implementation of a High Availability (HA) architecture using an Azure Standard Load Balancer. It builds upon a secure, multi-tier network to distribute incoming web traffic across backend Linux Virtual Machines, ensuring system resilience and optimized performance for enterprise-scale applications.

Infrastructure Specifications
The templates define a production-ready, load-balanced environment including:

Compute & Availability:
Linux Virtual Machine Tier: Deployed within a dedicated Web Subnet, featuring automated bootstrapping (Apache/HTML) via custom_data.

Standard Load Balancer: Configured with a Frontend IP, Backend Address Pools, and Health Probes to monitor VM status.

Network Security & Connectivity:
Azure Bastion Integration: Utilized as a secure "jump server" to validate backend connectivity without exposing direct SSH ports to the internet.

Network Security Group (NSG): Implemented with specific rules to allow traffic from the Load Balancer and Bastion service while maintaining a "Deny-All" default for unauthenticated traffic.

4-Tier VNET Segmentation: Complete isolation of Web, App, DB, and Bastion subnets within a unified Resource Group.

Technical Highlights
Traffic Distribution Logic: Successful configuration of Load Balancing rules to map frontend requests to backend pools.

Advanced Provisioning: Use of locals for naming conventions and filebase64 / basedecode64 for secure injection of web server configurations.

Data Integrity: Extensive use of Input Variables for environment customization and Output Variables to retrieve Load Balancer DNS/IP information.

Security Compliance: Reflects Banking GRC standards by ensuring that web servers are only accessible via the Load Balancer or the secure Bastion gateway.

Deployment Instructions
⚠️ Operational Safety & Compliance Policy
Consistent with professional IT Operations (e.g., NORD/LB):

Development/Testing: The -auto-approve flag may be utilized for rapid iteration when resource behaviors are well-understood.

Pre-Production/Production: Use of the -auto-approve flag is strictly prohibited. A formal manual review of the terraform plan is required to mitigate risks and ensure no unintended resource destruction occurs.

Execution Workflow:
To provision this load-balanced infrastructure, execute the following commands:

Bash
# 1. Initialize Terraform and the Azure Provider
terraform init

# 2. Validate the syntactic and structural integrity of the code
terraform validate

# 3. Generate a detailed execution plan for review
terraform plan

# 4. Apply the configuration (Manual confirmation required for Production)
terraform apply -auto-approve


**Project 5: Azure_Standard_Load_Balancer_Meta_Arguments
Project Overview**
This project demonstrates advanced Terraform Orchestration and lifecycle management using Meta-Arguments. By integrating complex logic such as resource looping, dependency mapping, and post-deployment configuration via provisioners, this repository showcases a sophisticated approach to automating large-scale Azure infrastructures.

Infrastructure Specifications
The deployment defines a highly automated, load-balanced environment including:

Compute & Advanced Logic:
Linux Virtual Machine Cluster: Managed via advanced HCL logic, including SSH key integration and OS disk optimization.

Standard Load Balancer: Targeted specifically at the Web Subnet and Linux VM backend pools to ensure high availability.

Meta-Argument Implementation: Extensive use of count, for_each, and depends_on to manage multiple resource instances dynamically.

Network Security & Connectivity:
Hybrid Access Management: Secure connectivity verified through Azure Bastion Service and the Standard Load Balancer.

4-Tier Network Topology: Segmented subnets (Web, App, DB, Bastion) deployed within a unified Resource Group for centralized governance.

Technical Highlights
Resource Randomization: Implementation of the random provider to ensure unique naming conventions for global resources like Storage Accounts or Public IPs.

Custom Provisioning: Utilization of null_resource and various Provisioners (local-exec, remote-exec) to execute operational commands immediately after resource creation.

Data Transformation: Use of locals for code DRYness (Don't Repeat Yourself) and filebase64/basedecode64 for secure custom_data bootstrapping of Apache web servers.

Input/Output Mapping: Strategic use of variables to ensure the configuration remains modular and portable across different Azure subscriptions.

Deployment Instructions
⚠️ Operational Safety & GRC Policy
Reflecting the strict standards of the banking sector (BaFin/GRC):

Development/Test: The -auto-approve flag is used only when resources and their impact are fully understood and documented.

Pre-Production/Production: Use of the -auto-approve flag is strictly prohibited. A detailed manual review of the terraform plan is required to prevent unauthorized infrastructure drift or data loss.

Execution Workflow:
Bash
# 1. Initialize the working directory and plugins
terraform init

# 2. Check the configuration for syntactic correctness
terraform validate

# 3. Create an execution plan and verify resource changes
terraform plan

# 4. Apply the infrastructure changes (Manual approval required for Production)
terraform apply -auto-approve


**Project 6: Azure_Standard_Load_Balancer_VMSS_Auto_Scaling
Project Overview**
This project demonstrates the implementation of a highly elastic and self-healing infrastructure using Azure Virtual Machine Scale Sets (VMSS) and Automated Scaling Profiles. By integrating a Standard Load Balancer with dynamic scaling logic, this repository ensures that infrastructure capacity automatically aligns with real-time demand, optimizing both performance and cost.

Infrastructure Specifications
The configuration defines a sophisticated, auto-scaling web tier including:

Compute & Elasticity:
Linux VM Scale Set (VMSS): A dynamic cluster of web servers bootstrapped with Apache via custom_data (using filebase64/basedecode64).

Advanced Auto-Scaling Engine: Implementation of three distinct scaling behaviors:

Normal Profile: Metric-based triggers (CPU utilization, Memory, SYNCount) to handle sudden spikes.

Recurrence Profile: Schedule-based scaling for predictable patterns (e.g., higher capacity during business hours, lower on weekends).

Fixed Profile: Time-specific settings for known events or maintenance windows.

Notification System: Integrated Mail Notifications to alert administrators of scaling events and health status.

Network & Management:
Standard Load Balancer: Integrated with VMSS backend pools to distribute traffic seamlessly across scaled instances.

Security Layer: 4-Tier VNET design with Azure Bastion for secure, private management of the scale set instances.

Technical Highlights
Complex Scaling Logic: Orchestration of metric triggers, recurrence time-zones, and scale actions within Terraform.

Orchestration Meta-Arguments: Use of random for unique naming and null_resource with Provisioners for post-deployment verification.

Infrastructure as Code (IaC) Best Practices: Extensive use of locals, ssh_keys, and standardized source_image_reference for repeatable deployments.

Output-Driven Design: Captures real-time scaling metrics and frontend IP details for visibility.

Deployment Instructions
⚠️ Operational Safety & SRE Policy
Aligned with Site Reliability Engineering (SRE) and Banking GRC standards:

Development/Sandbox: -auto-approve is permitted only for iterative testing of scaling rules.

Pre-Production/Production: The -auto-approve flag is strictly prohibited. A detailed manual review of the terraform plan is mandatory to ensure scaling thresholds and budget constraints are correctly configured.

Execution Workflow:
Bash
# Initialize Terraform environment
terraform init

# Validate the complex scaling profiles and syntax
terraform validate

# Review the execution plan and metric triggers
terraform plan

# Apply the auto-scaling infrastructure (Manual approval for Prod)
terraform apply -auto-approve


**Project 7: Azure_Standard_Load_Balancer_VMSS_Manual_Scaling
Project Overview**
This project focuses on the precise control and iterative management of Azure resources using Terraform Meta-Arguments. By deploying a Virtual Machine Scale Set (VMSS) with Manual Scaling and dynamic security rule generation, this repository demonstrates how to manage enterprise-grade infrastructure that requires explicit capacity control and granular security configurations.

Infrastructure Specifications
The templates define a controlled, highly-secure web tier including:

Compute & Scaling Logic:
Linux VM Scale Set (VMSS): Configured for Manual Scaling, allowing for intentional capacity adjustments based on business requirements.

Automated Provisioning: Utilizes custom_data (via filebase64 and basedecode64) to automatically bootstrap the Apache web server and deliver standardized HTML content.

Orchestration: Implementation of locals, SSH keys, and optimized OS disk settings to ensure a standardized compute environment.

Network Security & Connectivity:
Dynamic NSG Rules: Specialized use of for_each logic to iterate through security rules, automatically assigning priorities and managing complex access lists.

Standard Load Balancer: Dedicated frontend for the Web Subnet, facilitating efficient traffic distribution to the VMSS backend pool.

Azure Bastion Service: Integrated to provide a secure "Jump-Host" for administrative validation of the VMSS instances and Load Balancer connectivity.

Technical Highlights
Iterative Resource Logic: Use of for_each and count to manage multiple security rules and scale-set instances without code duplication (DRY principle).

Advanced Providers: Integration of the random provider for unique resource naming and the null provider for triggering operational commands via Provisioners.

Global Variables: Comprehensive mapping of Input Variables for multi-region support and Output Variables for automated extraction of connectivity endpoints.

Regulatory Alignment: Designed to meet Banking GRC and BaFin requirements through explicit security rule prioritization and visibility.

Deployment Instructions
⚠️ Operational Safety & Governance Policy
In adherence to the high-security standards of the financial sector (e.g., NORD/LB):

Test/Sandbox: The -auto-approve flag is acceptable for rapid validation of security rule iterations.

Pre-Production/Production: The -auto-approve flag is strictly prohibited. A manual review of the terraform plan is required to verify that every security rule and scale action is authorized.

Execution Workflow:
To provision this infrastructure, execute the following commands:

Bash
# 1. Initialize the Terraform environment and providers
terraform init

# 2. Validate the iterative logic and rule syntax
terraform validate

# 3. Review the execution plan and rule priorities
terraform plan

# 4. Apply the configuration (Manual confirmation required for Production)
terraform apply -auto-approve

About the Author
Karuppaswami Kannan

Azure Certified Administrator (AZ-104)

Technical Experience: 4+ years in Capital Markets IT (NORD/LB environments).

Specialization: Infrastructure as Code (IaC), Advanced HCL Logic, and Security Hardening.

Summary of  GitHub Project Section
By having these 7 projects documented this way, you show a complete "learning journey" on your resume:

Project 1: Networking basics.

Projects 2-3: Compute & Security.

Project 4: High Availability.

Project 5: Advanced Automation (Meta-Arguments).

Projects 6-7: Enterprise Scaling (VMSS).
