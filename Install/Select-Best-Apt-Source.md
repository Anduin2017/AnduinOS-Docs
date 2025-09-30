# Select best apt source

By default, AnduinOS may not selected the best APT source for you. You need to set the best APT source for your system to speed up the installation process.

To select the best APT source for your system, run the following command in the terminal:

```bash title="Select best apt source"
#!/usr/bin/env bash
set -euo pipefail

# Check current APT source format status
check_apt_format() {
    local old_format=false
    local new_format=false
    
    # Check old format (.list)
    if [ -f "/etc/apt/sources.list" ]; then
        if grep -v '^#' /etc/apt/sources.list | grep -q '[^[:space:]]'; then
            old_format=true
        fi
    fi
    
    # Check for ubuntu.sources file in new format
    if [ -f "/etc/apt/sources.list.d/ubuntu.sources" ]; then
        if grep -v '^#' /etc/apt/sources.list.d/ubuntu.sources | grep -q '[^[:space:]]'; then
            new_format=true
        fi
    fi
    
    # Return status
    if $old_format && $new_format; then
        echo "both"
    elif $old_format; then
        echo "old"
    elif $new_format; then
        echo "new"
    else
        echo "none"
    fi
}

# Find the fastest mirror
find_fastest_mirror() {
    # Redirect all output to stderr
    echo "Testing mirror speeds..." >&2
    
    # Get current Ubuntu codename
    codename=$(lsb_release -cs)
    
    # Define list of potential mirrors
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
        "http://mirrors.ustc.edu.cn/ubuntu/"                # USTC
        "http://ftp.sjtu.edu.cn/ubuntu/"                    # SJTU
        "http://mirrors.tuna.tsinghua.edu.cn/ubuntu/"       # Tsinghua
        "http://mirrors.aliyun.com/ubuntu/"                 # Aliyun
        "http://mirrors.163.com/ubuntu/"                    # NetEase
        "http://mirrors.cloud.tencent.com/ubuntu/"          # Tencent Cloud
        "http://mirrors.huaweicloud.com/ubuntu/"            # Huawei Cloud
        "http://mirrors.zju.edu.cn/ubuntu/"                 # Zhejiang University
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
    
    # Test speed of each mirror
    for mirror in "${mirrors[@]}"; do
        echo "Testing $mirror ..." >&2
        response="$(curl -o /dev/null -s -w "%{http_code} %{time_total}\n" \
                  --connect-timeout 1 --max-time 3 "${mirror}dists/${codename}/Release")"
        
        http_code=$(echo "$response" | awk '{print $1}')
        time_total=$(echo "$response" | awk '{print $2}')
        
        if [ "$http_code" -eq 200 ]; then
            results["$mirror"]="$time_total"
            echo "  Success: $time_total seconds" >&2
        else
            echo "  Failed: HTTP code $http_code" >&2
            results["$mirror"]="9999"
        fi
    done
    
    # Sort mirrors by response time
    sorted_mirrors="$(
        for url in "${!results[@]}"; do
            echo "$url ${results[$url]}"
        done | sort -k2 -n
    )"
    
    echo >&2
    echo "=== Mirrors sorted by response time (ascending) ===" >&2
    echo "$sorted_mirrors" >&2
    echo >&2
    
    # Choose the fastest mirror
    fastest_mirror="$(echo "$sorted_mirrors" | head -n 1 | awk '{print $1}')"
    
    if [[ "$fastest_mirror" == "" || "${results[$fastest_mirror]}" == "9999" ]]; then
        echo "No usable mirror found, using default mirror" >&2
        fastest_mirror="http://archive.ubuntu.com/ubuntu/"
    fi
    
    echo "Fastest mirror found: $fastest_mirror" >&2
    echo >&2
    
    # Only this line will be returned to caller, without >&2
    echo "$fastest_mirror"
}

# Generate old format source list
generate_old_format() {
    local mirror="$1"
    local codename="$2"
    
    echo "Generating old format source list /etc/apt/sources.list"
    
    sudo tee /etc/apt/sources.list >/dev/null <<EOF
deb $mirror $codename main restricted universe multiverse
deb $mirror $codename-updates main restricted universe multiverse
deb $mirror $codename-backports main restricted universe multiverse
deb $mirror $codename-security main restricted universe multiverse
EOF
    
    echo "Old format source list updated"
}

# Generate new format source list
generate_new_format() {
    local mirror="$1"
    local codename="$2"
    
    echo "Generating new format source list /etc/apt/sources.list.d/ubuntu.sources"
    
    sudo tee /etc/apt/sources.list.d/ubuntu.sources >/dev/null <<EOF
Types: deb
URIs: $mirror
Suites: $codename
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb
URIs: $mirror
Suites: $codename-updates
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb
URIs: $mirror
Suites: $codename-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb
URIs: $mirror
Suites: $codename-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOF
    
    echo "New format source list updated"
}

# Main function
main() {
    # Ensure required packages are installed
    sudo apt update
    sudo apt install -y curl lsb-release
    
    # Get current source format
    format=$(check_apt_format)
    echo "Current APT source format status: $format"
    
    # Get Ubuntu codename
    codename=$(lsb_release -cs)
    echo "Ubuntu codename: $codename"
    
    # Find the fastest mirror
    echo "Searching for the fastest mirror..."
    fastest_mirror=$(find_fastest_mirror)
    
    # Decide update strategy based on format
    case "$format" in
        "none")
            echo "No valid APT source found, generating old format source list"
            generate_old_format "$fastest_mirror" "$codename"
            ;;
        "old")
            echo "System uses traditional format, updating old format source list"
            generate_old_format "$fastest_mirror" "$codename"
            ;;
        "new")
            echo "System uses modern format, updating new format source list"
            generate_new_format "$fastest_mirror" "$codename"
            ;;
        "both")
            echo "System uses both formats, old format will be removed, only new format will be retained"
            sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
            echo "Old format source list backed up to /etc/apt/sources.list.bak"
            generate_new_format "$fastest_mirror" "$codename"
            ;;
    esac
    
    # Update package list
    echo "Updating package list..."
    sudo apt update
    
    echo "APT source optimization completed!"

    aptVersion=$(apt --version | head -n 1 | awk '{print $2}')
    echo "Current APT version: $aptVersion"

    apt_major_version=$(echo "$aptVersion" | cut -d. -f1)
    
    # If current APT version is 3.0 or higher, and using old format or none, convert to new format
    # sudo apt modernize-sources
    if [[ $apt_major_version -ge 3 && ( "$format" == "old" || "$format" == "none" ) ]]; then
        echo "APT version is 3.0 or higher, converting to new format"
        sudo apt modernize-sources -y
        echo "APT sources converted to new format"
    fi

}

# Execute main function
main
```
