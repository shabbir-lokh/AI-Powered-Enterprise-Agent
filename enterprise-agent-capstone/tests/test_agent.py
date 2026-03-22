"""
Tests for the Enterprise Agent
"""

import pytest
import sys
from pathlib import Path

# Add src to path
sys.path.insert(0, str(Path(__file__).parent.parent / "src"))

from agent import EnterpriseAgent, AgentConfig


class TestAgentConfig:
    """Test AgentConfig class"""
    
    def test_config_creation(self):
        """Test basic config creation"""
        config = AgentConfig(
            api_key="test_key",
            model="gpt-4",
            temperature=0.7,
            max_tokens=2000
        )
        
        assert config.api_key == "test_key"
        assert config.model == "gpt-4"
        assert config.temperature == 0.7
        assert config.max_tokens == 2000


class TestEnterpriseAgent:
    """Test EnterpriseAgent class"""
    
    @pytest.fixture
    def agent(self):
        """Create a test agent instance"""
        config = AgentConfig(
            api_key="test_key",
            model="gpt-4"
        )
        return EnterpriseAgent(config)
    
    def test_agent_initialization(self, agent):
        """Test agent initializes correctly"""
        assert agent.config.api_key == "test_key"
        assert agent.tools == []
        assert agent.conversation_history == []
    
    def test_add_tool(self, agent):
        """Test adding tools to agent"""
        class MockTool:
            pass
        
        tool = MockTool()
        agent.add_tool(tool)
        
        assert len(agent.tools) == 1
        assert agent.tools[0] == tool
    
    def test_process_basic(self, agent):
        """Test basic processing"""
        result = agent.process("test input")
        
        assert result["status"] == "success"
        assert result["input"] == "test input"
        assert "response" in result
