# Node

Node, also known as Node.js, is a JavaScript runtime built on Chrome's V8 JavaScript engine. It is designed to build scalable network applications. Node.js uses an event-driven, non-blocking I/O model that makes it lightweight and efficient.

To install Node (with npm) on AnduinOS, you can run:

```bash
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg --yes
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update
sudo apt install nodejs
```

The script above installed nodejs with version 20. If you want to install another version, you can change the `NODE_MAJOR` variable to the desired version.

After installing `node` and `npm`, you can use it to install other packages. For example, you can run:

```bash
sudo npm i -g yarn npm npx typescript ts-node marked
```
