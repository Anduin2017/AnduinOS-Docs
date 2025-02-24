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
pipx install open-webui
open-webui serve
```

That's it. Now open `http://localhost:8080` in your browser to access the web UI.
