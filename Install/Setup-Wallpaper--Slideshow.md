# Setup Wallpaper Slideshow

If you are tired of fixed wallpapers and want to add some life to your desktop, you can set up a wallpaper slideshow in AnduinOS. This feature allows you to automatically change your wallpaper at regular intervals, giving your desktop a fresh look every time you log in.

!!! info "How to enable wallpaper slideshow?"

    If you want to enable wallpaper slideshow, you can use the following script to set up a wallpaper slideshow on your system.

    ```bash title="Setup wallpaper slideshow (Every 30 minutes)"
    mkdir -p ~/.local
    mkdir -p ~/Pictures/Wallpapers
    cat << 'EOF' > ~/.local/slide.sh
    #!/bin/bash
    DIR="/home/$USER/Pictures/Wallpapers"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$(find $DIR -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.bmp' \) -print0 | shuf -n1 -z)"
    EOF
    chmod +x ~/.local/slide.sh
    (crontab -l ; echo "*/30 * * * * ~/.local/slide.sh") | crontab -
    ```

    Don't forget to replace `~/Pictures/Wallpapers` with the path to the directory containing your wallpapers!

    And the script switches the wallpaper every 30 minutes. If you want to change the interval, you can modify the `*/30` part in the script.

Or even easier, you can install this gnome extension: [wallpaper--switcher](https://extensions.gnome.org/extension/4812/wallpaper-switcher/), which allows you to set up a wallpaper slideshow through the GNOME Shell.
