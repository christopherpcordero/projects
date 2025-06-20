# Azure Lab Environment

## Overview

This repository contains Terraform configurations for deploying a flexible cybersecurity lab environment in Microsoft Azure. Designed for hands-on learning, it enables both offensive and defensive security practice across red team and blue team operations.

The environment includes:
- A **Kali Linux VM** for penetration testing activities
- A **SIEM-enabled Ubuntu VM** for centralized monitoring and log collection
- A **custom virtual network** with segmented subnets and security control points
- Support for manually uploading **VulnHub-based vulnerable VMs** for exploit practice
- IP configurations for secure remote access

## Architecture
   +----------------+       +----------------+      +-----------------------+
   |   Kali VM      |       |   SIEM VM      |      |   VulnHub VM(s)       |
   | (Red Team)     |       | (Blue Team)    |      | (Target machines)     |
   +----------------+       +----------------+      +-----------------------+
           |                        |                          |
+----------+----------+   +--------+---------+     +----------+----------+
| Network Interface 1  |   | Network Interface 2 |   | Manual Config / Upload |
+----------------------+   +---------------------+     +----------------------+
           \                 /                                /
         +------------------------ Virtual Network ------------------------+
                                   |
                              +----------+
                              |  Subnet  |
                              +----------+


## Key Components

### ☁️ Azure Resources
- **Resource Group**: Organizes all lab resources
- **Virtual Network & Subnet**: Provides isolated communication layer
- **Network Interfaces**: One per VM, routed through the subnet
- **Public IPs**: Allow remote access via SSH
- **Network Security Groups (NSGs)**: Control access (e.g. restrict SSH by source IP)

### 🖥️ Virtual Machines
- **Kali Linux VM**:
  - Deployed using the latest Kali image
  - SSH configured using a public key
  - Tagged appropriately for lab management

- **Ubuntu SIEM VM**:
  - Hosts SIEM tooling (e.g., ELK Stack, Wazuh, etc.)
  - Ubuntu 22.04 LTS image
  - SSH access restricted to trusted IPs via NSG

- **VulnHub VMs (Manual)**:
  - These VMs will be added manually via image upload to replicate real-world vulnerable systems
  - Ideal for exploit development, CVE testing, privilege escalation, and lateral movement scenarios
  - Integrated into the existing subnet for in-lab attack simulation
