# Spotify

!!! tip "AnduinOS Verified App"

    Spotify is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

Spotify is a digital music streaming service that gives you access to millions of songs, podcasts and videos from artists all over the world.

## Flatpak install (Recommended)

You can install Spotify via Flatpak by running the following commands in your terminal:

```bash
flatpak install flathub com.spotify.Client
```

## System install

To install Spotify on AnduinOS, you can run:

```bash
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list > /dev/null
sudo apt update
sudo apt install spotify-client
```
