# Youtube dl

Youtube dl is a command-line program to download videos from YouTube.com and other video sites.

The source code of Youtube dl is available on [GitHub](https://github.com/ytdl-org/youtube-dl).

By using it may violate the terms of service of the video hosting sites. Please refer to the [YouTube Terms of Service](https://www.youtube.com/static?template=terms) before using it. Please refer the [License](https://github.com/ytdl-org/youtube-dl/blob/master/LICENSE) of Youtube dl before using it. In case of any violation, the user will be responsible for it.

To install Youtube dl on AnduinOS, run the following command:

```bash
sudo apt install python3-pip -y
pip3 install 'git+https://github.com/ytdl-org/youtube-dl.git@master#egg=youtube_dl'
sudo cp ~/.local/bin/youtube-dl /usr/bin/youtube-dl
/usr/bin/youtube-dl --version
```

## Get cookies

Before downloading a video, you need to get the cookies from the browser. In order to extract cookies from browser use any conforming browser extension for exporting cookies. For example, [Get cookies.txt LOCALLY](https://chrome.google.com/webstore/detail/get-cookiestxt-locally/cclelndahbckbenkjhflpdbgdldlbecc) (for Chrome) or [cookies.txt](https://addons.mozilla.org/en-US/firefox/addon/cookies-txt/) (for Firefox).

After installing the extension, you can export the cookies from the browser. Open [https://www.youtube.com](https://www.youtube.com) and click on the extension icon. Then, click on the `Export` button to save the cookies to a file.

By default, the file will be saved into `~/Downloads/www.youtube.com_cookies.txt`.

## Download a video

To download a video, you can run the following command:

```bash
cd ~/Downloads
youtube-dl \
    -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' \
    --cookies './www.youtube.com_cookies.txt' \
    --write-description \
    --write-info-json \
    --write-annotations \
    --write-thumbnail \
    --write-sub \
    --all-subs \
    --merge-output-format mp4 \
    --add-metadata \
    --embed-subs \
    --embed-thumbnail \
    --sleep-interval 10 \
    --max-sleep-interval 20 $url
```

For example, if you need to download `https://www.youtube.com/watch?v=KtekEWk3zDQ`, you can run:

```bash
cd ~/Downloads
youtube-dl \
    -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' \
    --cookies './www.youtube.com_cookies.txt' \
    --write-description \
    --write-info-json \
    --write-annotations \
    --write-thumbnail \
    --write-sub \
    --all-subs \
    --merge-output-format mp4 \
    --add-metadata \
    --embed-subs \
    --embed-thumbnail \
    --sleep-interval 10 \
    --max-sleep-interval 20 https://www.youtube.com/watch?v=KtekEWk3zDQ
```

The video will be saved into `~/Downloads` directory.
