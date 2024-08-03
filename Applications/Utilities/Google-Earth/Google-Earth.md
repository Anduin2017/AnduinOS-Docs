# Google Earth

Google Earth is a virtual globe, map, and geographical information program that was originally called EarthViewer 3D. It was created by Keyhole, Inc, a Central Intelligence Agency (CIA) funded company acquired by Google in 2004. It maps the Earth by superimposing satellite images, aerial photography, and GIS data onto a 3D globe, allowing users to see cities and landscapes from various angles.

To install Google Earth on AnduinOS, you can run:

```bash
wget -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/earth.gpg > /dev/null 2>&1
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/earth/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt update
sudo apt install google-earth-pro-stable -y
```
