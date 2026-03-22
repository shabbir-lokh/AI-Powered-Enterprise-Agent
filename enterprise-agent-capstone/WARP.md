# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is an Enterprise Agents capstone project focused on building an intelligent agent to solve real-world enterprise challenges. The project uses Python with LangChain for agent orchestration and supports multiple LLM providers (OpenAI, Anthropic).

## Development Commands

### Environment Setup
```powershell
# Create virtual environment
python -m venv venv

# Activate virtual environment (Windows PowerShell)
.\venv\Scripts\Activate.ps1

# Install dependencies
pip install -r requirements.txt

# Set up environment variables
Copy-Item .env.example .env
# Then edit .env with actual API keys
```

### Running the Agent
```powershell
# Run the main agent in interactive mode
python src/agent.py
```

### Testing
```powershell
# Run all tests
pytest tests/

# Run with coverage report
pytest tests/ --cov=src --cov-report=html

# Run a specific test file
pytest tests/test_agent.py

# Run a specific test function
pytest tests/test_agent.py::TestEnterpriseAgent::test_agent_initialization

# Run tests in verbose mode
pytest tests/ -v
```

### Code Quality
```powershell
# Format code with Black
black src/ tests/

# Check code formatting (without making changes)
black --check src/ tests/

# Lint with Flake8
flake8 src/ tests/

# Type checking with MyPy
mypy src/
```

## Architecture Overview

### Core Components

**EnterpriseAgent (`src/agent.py`)**
- Main agent class that orchestrates all functionality
- Supports tool integration through `add_tool()` method
- Manages conversation history for context-aware interactions
- Can run in interactive mode via `run()` method or process single inputs via `process()`

**AgentConfig (`src/agent.py`)**
- Configuration dataclass that manages agent settings
- Loads from environment variables via `from_env()` class method
- Controls LLM parameters: model, temperature, max_tokens

### Configuration Strategy

The project uses a dual configuration approach:
1. **Environment Variables** (`.env` file): For API keys and runtime configuration
2. **YAML Configuration** (`config/agent_config.yaml`): For agent behavior and tool definitions

When modifying agent configuration:
- API keys and secrets → `.env`
- Agent behavior, tools, logging → `config/agent_config.yaml`

### Testing Structure

Tests follow pytest conventions:
- Test classes prefixed with `Test`
- Test methods prefixed with `test_`
- Fixtures used for common setup (see `@pytest.fixture` decorator)
- Path manipulation in `test_agent.py` adds `src/` to sys.path for imports

### Project Dependencies

**Agent Frameworks:**
- LangChain (primary) - used for agent orchestration
- LlamaIndex (optional alternative, commented out in requirements.txt)

**LLM Providers:**
- OpenAI via `langchain-openai`
- Anthropic via `anthropic`

**Development Tools:**
- pytest for testing (with async and coverage support)
- black for code formatting
- flake8 for linting
- mypy for type checking

## Working with This Codebase

### Adding New Tools
Tools should be added to the agent via the `add_tool()` method. The agent's `tools` list is a simple array that stores tool instances. Update `config/agent_config.yaml` to register tools in the configuration.

### Implementing Agent Logic
The `EnterpriseAgent.process()` method is the main entry point for agent logic. This is where LLM calls, tool orchestration, and response generation should be implemented.

### Environment Variables
Always use environment variables for sensitive data. The `AgentConfig.from_env()` pattern should be followed for any new configuration parameters.

### Logging
The project uses Python's standard logging module configured in `agent.py`. Log level is controlled via the `LOG_LEVEL` environment variable and can be set to DEBUG, INFO, WARNING, or ERROR.

## Windows-Specific Notes

This project is currently being developed on Windows with PowerShell. Commands are provided in PowerShell syntax:
- Virtual environment activation: `.\venv\Scripts\Activate.ps1`
- Path separators use backslashes: `src\agent.py`
- File operations should account for Windows path handling
