# Software Requirements

All software needed to develop and run the Enterprise Agent Capstone project.

---

## 1. Core Runtime

| Software | Version | Download Link |
|---|---|---|
| **Python** | 3.11+ | https://www.python.org/downloads/ |
| **Git** | Latest | https://git-scm.com/download/win |

---

## 2. Package Manager (comes with Python)

| Tool | Purpose |
|---|---|
| `pip` | Install Python packages (bundled with Python 3.11+) |
| `venv` | Create isolated virtual environments (bundled with Python 3.11+) |

---

## 3. Code Editor / IDE

| Software | Version | Download Link |
|---|---|---|
| **Visual Studio Code** | Latest | https://code.visualstudio.com/ |

### Recommended VS Code Extensions

| Extension | Install Link |
|---|---|
| Python (Microsoft) | https://marketplace.visualstudio.com/items?itemName=ms-python.python |
| Pylance | https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance |
| Jupyter | https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter |
| GitLens | https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens |

---

## 4. Python Libraries (installed via pip — see `requirements.txt`)

| Library | Purpose | PyPI Link |
|---|---|---|
| `langchain` | AI agent orchestration framework | https://pypi.org/project/langchain/ |
| `langchain-openai` | LangChain OpenAI integration | https://pypi.org/project/langchain-openai/ |
| `langchain-community` | Community tools and integrations | https://pypi.org/project/langchain-community/ |
| `openai` | OpenAI API client (GPT-4, embeddings, etc.) | https://pypi.org/project/openai/ |
| `fastapi` | REST API framework for the agent interface layer | https://pypi.org/project/fastapi/ |
| `uvicorn` | ASGI server to serve FastAPI | https://pypi.org/project/uvicorn/ |
| `python-dotenv` | Load environment variables from `.env` files | https://pypi.org/project/python-dotenv/ |
| `pydantic` | Data validation and settings management | https://pypi.org/project/pydantic/ |
| `httpx` | Async HTTP client for tool/API integrations | https://pypi.org/project/httpx/ |
| `tiktoken` | Token counting for OpenAI models | https://pypi.org/project/tiktoken/ |
| `chromadb` | Local vector store for agent memory/RAG | https://pypi.org/project/chromadb/ |
| `pytest` | Testing framework | https://pypi.org/project/pytest/ |
| `pytest-asyncio` | Async test support | https://pypi.org/project/pytest-asyncio/ |
| `black` | Code formatter | https://pypi.org/project/black/ |
| `ruff` | Fast Python linter | https://pypi.org/project/ruff/ |

---

## 5. Optional / Cloud Services

| Service | Purpose | Link |
|---|---|---|
| **OpenAI Platform** | API key for GPT-4 / embeddings | https://platform.openai.com/ |
| **GitHub** | Host and publish the agent code | https://github.com/ |
| **Docker Desktop** | Containerize the agent for deployment | https://www.docker.com/products/docker-desktop/ |

---

## 6. Installation Order (Windows)

1. Install **Git** → https://git-scm.com/download/win
2. Install **Python 3.11+** → https://www.python.org/downloads/  
   _(Tick "Add Python to PATH" during installation)_
3. Install **VS Code** → https://code.visualstudio.com/
4. Run the bootstrap script:
   ```powershell
   .\setup\bootstrap.ps1
   ```
5. Add your OpenAI API key to the generated `.env` file.
