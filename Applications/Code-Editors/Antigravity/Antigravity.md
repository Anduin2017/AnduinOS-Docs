# Antigravity

!!! tip "AnduinOS Verified App"

    Antigravity is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

Google Antigravity is an agentic development platform, evolving the IDE into the agent-first era. Antigravity enables developers to operate at a higher, task-oriented level by managing agents across workspaces, while retaining a familiar AI IDE experience at its core. Agents operate across the editor, terminal, and browser, enabling them to autonomously plan and execute complex, end-to-end tasks elevating all aspects of software development.

## System install

To install Antigravity on AnduinOS, you can run:

```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/antigravity-repo-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
  sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null
sudo apt update
sudo apt install antigravity
```