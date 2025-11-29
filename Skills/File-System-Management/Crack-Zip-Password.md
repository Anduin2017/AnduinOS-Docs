# Cracking Zip File Passwords

**Disclaimer:** This guide is for security auditing and recovering your own lost passwords. Unauthorized decryption of files is illegal.

## 1\. Prerequisites

The standard repository version of John the Ripper often lacks the `zip2john` utility needed for zip files. We will compile the latest version from source to ensure full compatibility and performance.

Install the necessary build dependencies:

```bash
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev git zlib1g-dev yasm libgmp-dev libpcap-dev libbz2-dev
```

## 2\. Install John the Ripper

Clone the official repository and compile using all available CPU cores.

```bash
# Clone the repository
git clone https://github.com/openwall/john.git

# Navigate to source and compile
cd john/src
./configure
make -s clean && make -s -j $(nproc)
```

*Note: If compilation finishes without errors, the executables will be located in `../run/`.*

## 3\. Extract the Hash

John cannot crack the zip file directly; it requires a hash. Use `zip2john` to extract it.

```bash
# Move to the run directory
cd ../run

# Extract hash (replace target.zip with your file)
./zip2john /path/to/target.zip > hash.txt
```

## 4\. Run the Attack

Use `john` to crack the hash. Below are two common strategies.

### Strategy A: Brute Force (6-Digit PIN)

If you suspect the password is a numeric PIN (e.g., bank statements, simple archives), use this optimized command. It utilizes all CPU cores (`--fork`) and focuses solely on digits.

```bash
./john --incremental=Digits --min-length=6 --max-length=6 --fork=$(nproc) hash.txt
```

### Strategy B: Standard Dictionary Attack

For standard passwords (letters, words), run the default mode. This automatically tests common password variations.

```bash
./john --fork=$(nproc) hash.txt
```

## 5\. View the Password

Once the process finishes (or you see "Session completed"), display the cracked password:

```bash
./john --show hash.txt
```

**Output Example:**
`target.zip:275448:file.pdf:target.zip::target.zip`

The password is **275448**.

-----

## 6\. Cleanup (Optional)

To remove the source code and hash files after recovery:

```bash
cd ~
rm -rf john hash.txt
```
