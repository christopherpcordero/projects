# Local AI 
`By Christopher P. Cordero`

---

## Table of Contents
- [Overview](#overview)
- [Tools](#tools)
- [Setup](#setup)
---



## Tools
| Service | Version |
| --------|---------|
| Ollama  | v0.5.7  |
| Open WebUI  | v0.5.10 |
| docker  | v26.1.3  |
| Ubuntu  | v22.04.1  |
| VM      |  Azure |


---

## Overview
To practice with AI models I wanted to host AI locally. Due to hardware restrictions, I hosted my AI server on Azure. Using Ollama to run my AI locally I pulled LLM llama3.2. I used Open WebUI to host llama3.2 with a UI instead of the CLI. I successfully deployed a self-hosted AI model using Ollama as the backend and Open WebUI as the frontend. This setup allows me to run AI models locally without relying on cloud-based services, ensuring better privacy, control, and performance.
---


## Setup

- Azure VM
  - Created Ubuntu VM hosted in Azure
  - Size:
    - `CPUs: 4`
    - `MEM: 16GB`
    - `Disk: 30GB`  
- Install docker
  - `sudo apt install docker.io`
- Install Ollama to run AI locally
  - `curl -fsFL https:\\ollama.com\install.sh | sh`
- Ollama will run on port 11434 so to verify navigate to localhost:11434
  - picture   
- Pull AI Model, in my iteration I used `llama3.2 1B` 
  - `ollama pull llama3.2`
- Install Open WebUI
  - `pip install open-webui`
- Run Open WebUI via Docker, OpenWebUI will run on 8080
  - `docker run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main`
- 
---


## References 
- Ollama (https://ollama.com/)
- Open WebUI (https://github.com/open-webui/open-webui)
