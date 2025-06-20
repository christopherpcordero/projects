# Network Incident Report Practice   
`06FEB2025`

`By. Christopher P. Cordero`







## Table of Contents
1. [Introduction](#introduction)
2. [Task](#Task)
3. [Background](#background)
4. [Results](#results)
5. [References](#references)


---

## 1. Introduction

Using Malware-Traffic-Analysis.net pcap samples created a analysis report on findings to practice network analysis skills.
---

## 2. Task

For this exercise, answer the following questions for your incident report:

`What is the IP address of the infected Windows client?`

`What is the mac address of the infected Windows client?`

`What is the host name of the infected Windows client?`

`What is the user account name from the infected Windows client?`

`What is the likely domain name for the fake Google Authenticator page?`

`What are the IP addresses used for C2 servers for this infection?`

---


## 3. Background
Information provided by Malwarey-Traffic-Analysis.net :

You work as an analyst at a Security Operation Center (SOC). Someone contacts your team to report a coworker has downloaded a suspicious file after searching for Google Authenticator. The caller provides some information similar to social media posts at:

https://www.linkedin.com/posts/unit42_2025-01-22-wednesday-a-malicious-ad-led-activity-7288213662329192450-ky3V/
https://x.com/Unit42_Intel/status/1882448037030584611
Based on the caller's initial information, you confirm there was an infection.  You retrieve a packet capture (pcap) of the associated traffic.  Reviewing the traffic, you find several indicators matching details from a Github page referenced in the above social media posts.  After confirming an infection happened, you begin writing an incident report.



### Network Details

LAN segment range:  10.1.17[.]0/24   (10.1.17[.]0 through 10.1.17[.]255)

Domain:  bluemoontuesday[.]com

Active Directory (AD) domain controller:  10.1.17[.]2 - WIN-GSH54QLW48D

AD environment name:  BLUEMOONTUESDAY

LAN segment gateway:  10.1.17[.]1

LAN segment broadcast address:  10.1.17[.]255


---

## 4. Results
What is the IP address of the infected Windows client?
`10.1.17.215`

What is the mac address of the infected Windows client?
`00:d0:b7:26:4a:74`

What is the host name of the infected Windows client?
`DESKTOP-L8C5GSJ.bluemooontuesday.com`

What is the user account name from the infected Windows client?
`shutchenson`

What is the likely domain name for the fake Google Authenticator page?
`authenticatoor.org`

What are the IP addresses used for C2 servers for this infection?
`5.252.153.241`

---


## 5. References

- Practice samples: https://malware-traffic-analysis.net/2025/01/22/index.html
- Wireshark User Guide: https://www.wireshark.org/docs/

