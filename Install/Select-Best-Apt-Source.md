# Select best apt source

By default, AnduinOS may not selected the best APT source for you. You need to set the best APT source for your system to speed up the installation process.

To select the best APT source for your system, run the following command in the terminal:

```bash title="Select best apt source"
#!/usr/bin/env bash
# Step 1: Ensure required packages are installed
sudo apt update
sudo apt install -y curl apt-transport-https lsb-release

function switchSource() {
  # Get current Ubuntu codename (e.g., jammy, focal, bionic)
  codename=$(lsb_release -cs)
  
  # Define a list of potential mirrors
  mirrors=(
    "https://archive.ubuntu.com/ubuntu/"
    "https://mirror.aarnet.edu.au/pub/ubuntu/archive/" # Australia
    "https://mirror.fsmg.org.nz/ubuntu/"               # New Zealand
    "https://mirrors.neterra.net/ubuntu/archive/"       # Bulgaria
    "https://mirror.csclub.uwaterloo.ca/ubuntu/"        # Canada
    "https://mirrors.dotsrc.org/ubuntu/"                # Denmark
    "https://mirrors.nic.funet.fi/ubuntu/"              # Finland
    "https://mirror.ubuntu.ikoula.com/"                 # France
    "https://mirror.xtom.com.hk/ubuntu/"                # Hong Kong
    "https://mirrors.piconets.webwerks.in/ubuntu-mirror/ubuntu/" # India
    "https://ftp.udx.icscoe.jp/Linux/ubuntu/"           # Japan
    "https://ftp.kaist.ac.kr/ubuntu/"                   # Korea
    "https://ubuntu.mirror.garr.it/ubuntu/"             # Italy
    "https://ftp.uni-stuttgart.de/ubuntu/"              # Germany
    "https://mirror.i3d.net/pub/ubuntu/"                # Netherlands
    "https://mirroronet.pl/pub/mirrors/ubuntu/"         # Poland
    "https://ubuntu.mobinhost.com/ubuntu/"              # Iran
    "http://sg.archive.ubuntu.com/ubuntu/"              # Singapore
    "http://ossmirror.mycloud.services/os/linux/ubuntu/" # Singapore
    "https://mirror.enzu.com/ubuntu/"                   # United States
    "http://jp.archive.ubuntu.com/ubuntu/"              # Japan
    "http://kr.archive.ubuntu.com/ubuntu/"              # Korea
    "http://us.archive.ubuntu.com/ubuntu/"              # United States
    "http://tw.archive.ubuntu.com/ubuntu/"              # Taiwan
    "https://mirror.twds.com.tw/ubuntu/"                # Taiwan
    "https://ubuntu.mirrors.uk2.net/ubuntu/"            # United Kingdom
    "http://mirrors.ustc.edu.cn/ubuntu/"                # 中国科学技术大学
    "http://ftp.sjtu.edu.cn/ubuntu/"                    # 上海交通大学
    "http://mirrors.tuna.tsinghua.edu.cn/ubuntu/"       # 清华大学
    "http://mirrors.aliyun.com/ubuntu/"                 # 阿里云
    "http://mirrors.163.com/ubuntu/"                    # 网易
    "http://mirrors.cloud.tencent.com/ubuntu/"          # 腾讯云
    "http://mirror.aiursoft.cn/ubuntu/"                 # Aiursoft
    "http://mirrors.huaweicloud.com/ubuntu/"            # 华为云
    "http://mirrors.zju.edu.cn/ubuntu/"                 # 浙江大学
    "http://azure.archive.ubuntu.com/ubuntu/"           # Azure
    "https://mirrors.isu.net.sa/apt-mirror/"            # Saudi Arabia
    "https://mirror.team-host.ru/ubuntu/"               # Russia
    "https://labs.eif.urjc.es/mirror/ubuntu/"           # Spain
    "https://mirror.alastyr.com/ubuntu/ubuntu-archive/" # Turkey
    "https://ftp.acc.umu.se/ubuntu/"                    # Sweden
    "https://mirror.kku.ac.th/ubuntu/"                  # Thailand
    "https://mirror.bizflycloud.vn/ubuntu/"             # Vietnam
  )

  declare -A results

  # Function to test speed of a single mirror
  test_speed() {
    url="$1"
    # Attempt to do a quick GET and measure total time
    response="$(curl -o /dev/null -s -w "%{http_code} %{time_total}\n" \
                --connect-timeout 1 --max-time 2 "$url")"
    
    http_code=$(echo "$response" | awk '{print $1}')
    time_total=$(echo "$response" | awk '{print $2}')

    # If HTTP code == 200, mark the measured time; otherwise use a large value
    if [ "$http_code" -eq 200 ]; then
      results["$url"]="$time_total"
    else
      echo "Failed to access $url (HTTP code: $http_code)"
      results["$url"]="9999"
    fi
  }

  echo "Testing all mirrors for Ubuntu '$codename'..."
  for mirror in "${mirrors[@]}"; do
    test_speed "$mirror"
  done

  # Sort mirrors by time_total
  # Example of sorted_mirrors entry: "https://archive.ubuntu.com/ubuntu/ 0.034"
  sorted_mirrors="$(
    for url in "${!results[@]}"; do
      echo "$url ${results[$url]}"
    done | sort -k2 -n
  )"

  echo
  echo "=== Sorted mirrors by response time (ascending) ==="
  echo "$sorted_mirrors"
  echo

  # Pick the top (fastest) mirror from the sorted list
  fastest_mirror="$(echo "$sorted_mirrors" | head -n 1 | awk '{print $1}')"

  echo "Fastest mirror found: $fastest_mirror"
  echo "Updating /etc/apt/sources.list..."

  # Update /etc/apt/sources.list with the fastest mirror
  sudo tee /etc/apt/sources.list >/dev/null <<EOF
deb $fastest_mirror $codename main restricted universe multiverse
deb $fastest_mirror $codename-updates main restricted universe multiverse
deb $fastest_mirror $codename-backports main restricted universe multiverse
deb $fastest_mirror $codename-security main restricted universe multiverse
EOF

  # Final check
  sudo apt update
  echo "All done!"
}

# Call the main function
switchSource
```
