# VLC Media Player

VLC Media Player is a free and open-source media player that can play most multimedia files as well as DVDs, audio CDs, VCDs, and various streaming protocols.

To install VLC Media Player on AnduinOS, you can run:

```bash
sudo apt update
sudo apt install vlc
```

## Set VLC Media Player as the default media player

To set VLC Media Player as the default video player on AnduinOS, you can run:

```bash title="Set VLC Media Player as the default video player"
xdg-mime default vlc.desktop video/x-ogm+ogg
xdg-mime default vlc.desktop video/3gp
xdg-mime default vlc.desktop video/3gpp
xdg-mime default vlc.desktop video/3gpp2
xdg-mime default vlc.desktop video/dv
xdg-mime default vlc.desktop video/divx
xdg-mime default vlc.desktop video/fli
xdg-mime default vlc.desktop video/flv
xdg-mime default vlc.desktop video/mp2t
xdg-mime default vlc.desktop video/mp4
xdg-mime default vlc.desktop video/mp4v-es
xdg-mime default vlc.desktop video/mpeg
xdg-mime default vlc.desktop video/mpeg-system
xdg-mime default vlc.desktop video/msvideo
xdg-mime default vlc.desktop video/ogg
xdg-mime default vlc.desktop video/quicktime
xdg-mime default vlc.desktop video/vivo
xdg-mime default vlc.desktop video/vnd.divx
xdg-mime default vlc.desktop video/vnd.mpegurl
xdg-mime default vlc.desktop video/vnd.rn-realvideo
xdg-mime default vlc.desktop video/vnd.vivo
xdg-mime default vlc.desktop video/webm
xdg-mime default vlc.desktop video/x-anim
xdg-mime default vlc.desktop video/x-avi
xdg-mime default vlc.desktop video/x-flc
xdg-mime default vlc.desktop video/x-fli
xdg-mime default vlc.desktop video/x-flic
xdg-mime default vlc.desktop video/x-flv
xdg-mime default vlc.desktop video/x-m4v
xdg-mime default vlc.desktop video/x-matroska
xdg-mime default vlc.desktop video/x-mjpeg
xdg-mime default vlc.desktop video/x-mpeg
xdg-mime default vlc.desktop video/x-mpeg2
xdg-mime default vlc.desktop video/x-ms-asf
xdg-mime default vlc.desktop video/x-ms-asf-plugin
xdg-mime default vlc.desktop video/x-ms-asx
xdg-mime default vlc.desktop video/x-msvideo
xdg-mime default vlc.desktop video/x-ms-wm
xdg-mime default vlc.desktop video/x-ms-wmv
xdg-mime default vlc.desktop video/x-ms-wmx
xdg-mime default vlc.desktop video/x-ms-wvx
xdg-mime default vlc.desktop video/x-nsv
xdg-mime default vlc.desktop video/x-theora
xdg-mime default vlc.desktop video/x-theora+ogg
xdg-mime default vlc.desktop video/x-totem-stream
```

To set VLC Media Player as the default audio player on AnduinOS, you can run:

```bash title="Set VLC Media Player as the default audio player"
xdg-mime default vlc.desktop audio/x-vorbis+ogg
xdg-mime default vlc.desktop audio/vorbis
xdg-mime default vlc.desktop audio/x-vorbis
xdg-mime default vlc.desktop audio/x-scpls
xdg-mime default vlc.desktop audio/x-mp3
xdg-mime default vlc.desktop audio/x-mpeg
xdg-mime default vlc.desktop audio/mpeg
xdg-mime default vlc.desktop audio/x-mpegurl
xdg-mime default vlc.desktop audio/x-flac
xdg-mime default vlc.desktop audio/mp4
xdg-mime default vlc.desktop audio/x-it
xdg-mime default vlc.desktop audio/x-mod
xdg-mime default vlc.desktop audio/x-s3m
xdg-mime default vlc.desktop audio/x-stm
xdg-mime default vlc.desktop audio/x-xm
```
