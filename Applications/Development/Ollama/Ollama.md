# Ollama

## Install Ollama

Ollama is a tool for getting up and running with Llama 3.3, DeepSeek-R1, Phi-4, Gemma 2, and other large language models.

To install Ollama, you can run the following command:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

## Install Models

After installing Ollama, you may want to install some models like `DeepSeek`.

To install DeepSeek, you can run the following command:

```bash
ollama run deepseek-r1:7b
```

That's it! You're now ready to use Ollama and its models.

For more `DeepSeek` models, please view more details [here](https://ollama.com/library/deepseek-r1:7b).

## Install Web UI

You may also want to deploy a web UI for Ollama. To do this, you can deploy the [Open WebUI](https://github.com/open-webui/open-webui) project.

To deploy the Open WebUI project, you can run the following command:

```bash
#/app/backend/data
sudo mkdir -p /var/data/open-webui/
sudo docker run -it --net=host -v /var/data/open-webui/:/app/backend/data \
    -e OLLAMA_SERVER=http://127.0.0.1:11434 \
    ghcr.io/open-webui/open-webui:main
```

That's it. Now open `http://localhost:8080` in your browser to access the web UI.

You need to add `http://127.0.0.1:11434` as a custom Ollama server in the web UI.

## Install Mcpo

Mcpo is a simple proxy that takes an MCP server command and makes it accessible via standard RESTful OpenAPI, so your tools "just work" with LLM agents and apps expecting OpenAPI servers.

It is suggested to run Mcpo with Docker. To do this, you can run the following commands:

```bash
sudo mkdir -p /var/data/mcpo/
sudo touch /var/data/mcpo/config.json # Add your own configuration here.
sudo docker run -it --net=host -v /var/data/mcpo/:/data ghcr.io/open-webui/mcpo:main mcpo --config /data/config.json
```

And you can setup your `config.json` file with the following content:

```json
{
    "mcpServers": {
        "sequential-thinking": {
            "command": "npx",
            "args": [
                "-y",
                "@modelcontextprotocol/server-sequential-thinking"
            ]
        },
        "fetch": {
            "command": "uvx",
            "args": [
                "mcp-server-fetch"
            ]
        },
        "time": {
            "command": "uvx",
            "args": [
                "mcp-server-time",
                "--local-timezone=America/New_York"
            ]
        }
    }
}
```

You need to add `http://localhost:8000` as a custom mcpo server in the web UI.
