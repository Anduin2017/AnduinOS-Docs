# Select best apt source

To select the best APT source for your system, run the following command in the terminal:

```bash title="Select best apt source"
function switchSource() {
  mirrors=(
      "https://archive.ubuntu.com/ubuntu/"
      "https://mirror.aarnet.edu.au/pub/ubuntu/archive/" # Australia
      "https://mirror.fsmg.org.nz/ubuntu/" # New Zealand
      "https://mirrors.neterra.net/ubuntu/archive/" # Bulgaria
      "https://mirror.csclub.uwaterloo.ca/ubuntu/" # Canada
      "https://mirrors.dotsrc.org/ubuntu/" # Denmark
      "https://mirrors.nic.funet.fi/ubuntu/" # Finland
      "https://mirror.ubuntu.ikoula.com/" # France
      "https://mirror.xtom.com.hk/ubuntu/" # Hong Kong
      "https://mirrors.piconets.webwerks.in/ubuntu-mirror/ubuntu/" # India
      "https://ftp.udx.icscoe.jp/Linux/ubuntu/" # Japan
      "https://ftp.kaist.ac.kr/ubuntu/" # Korea
      "https://ubuntu.mirror.garr.it/ubuntu/" # Italy
      "https://ftp.uni-stuttgart.de/ubuntu/" # Germany
      "https://mirror.i3d.net/pub/ubuntu/" # Netherlands
      "https://mirroronet.pl/pub/mirrors/ubuntu/" # Poland
      "https://ubuntu.mobinhost.com/ubuntu/" # Iran
      "http://sg.archive.ubuntu.com/ubuntu/" # Singapore
      "http://ossmirror.mycloud.services/os/linux/ubuntu/" # Singapore
      "https://mirror.enzu.com/ubuntu/" # United States
      "http://jp.archive.ubuntu.com/ubuntu/" # Japan
      "http://kr.archive.ubuntu.com/ubuntu/" # Korea
      "http://us.archive.ubuntu.com/ubuntu/" # United States
      "http://tw.archive.ubuntu.com/ubuntu/" # Taiwan (Province of China)
      "https://mirror.twds.com.tw/ubuntu/" # Taiwan (Province of China)
      "https://ubuntu.mirrors.uk2.net/ubuntu/" # United Kingdom
      "http://mirrors.ustc.edu.cn/ubuntu/" # 中国科学技术大学
      "http://ftp.sjtu.edu.cn/ubuntu/" # 上海交通大学
      "http://mirrors.tuna.tsinghua.edu.cn/ubuntu/" # 清华大学
      "http://mirrors.aliyun.com/ubuntu/" # Aliyun
      "http://mirrors.163.com/ubuntu/" # NetEase
      "http://mirrors.cloud.tencent.com/ubuntu/" # Tencent Cloud
      "http://mirror.aiursoft.cn/ubuntu/" # Aiursoft
      "http://mirrors.anduinos.com/ubuntu/" # AnduinOS
      "http://mirrors.huaweicloud.com/ubuntu/" # Huawei Cloud
      "http://mirrors.zju.edu.cn/ubuntu/" # 浙江大学
      "http://azure.archive.ubuntu.com/ubuntu/" # Azure
  )

  declare -A results

  test_speed() {
      url=$1
      response=$(curl -o /dev/null -s -w "%{http_code} %{time_total}\n" --connect-timeout 1 --max-time 2 "$url")
      http_code=$(echo $response | awk '{print $1}')
      time_total=$(echo $response | awk '{print $2}')

      if [ "$http_code" -eq 200 ]; then
          results["$url"]=$time_total
      else
          echo "Failed to access $url"
          results["$url"]="9999"
      fi
  }

  echo "Testing all mirrors..."
  for mirror in "${mirrors[@]}"; do
      test_speed "$mirror"
  done

  sorted_mirrors=$(for url in "${!results[@]}"; do echo "$url ${results[$url]}"; done | sort -k2 -n)

  echo "Sorted mirrors:"
  echo "$sorted_mirrors"

  fastest_mirror=$(echo "$sorted_mirrors" | head -n 1 | awk '{print $1}')

  echo "Fastest mirror: $fastest_mirror"
  echo "
  deb $fastest_mirror jammy main restricted universe multiverse
  deb $fastest_mirror jammy-updates main restricted universe multiverse
  deb $fastest_mirror jammy-backports main restricted universe multiverse
  deb $fastest_mirror jammy-security main restricted universe multiverse
  " | sudo tee /etc/apt/sources.list
}

sudo apt update
sudo apt install curl apt-transport-https -y
switchSource
```
