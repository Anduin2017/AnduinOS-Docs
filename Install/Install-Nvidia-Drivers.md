# Installing NVIDIA Drivers on AnduinOS

This guide provides a comprehensive approach to installing proprietary NVIDIA drivers on **AnduinOS**. By using NVIDIA's proprietary drivers, you can achieve better performance and gain access to features not available through the open-source Nouveau driver.

---

## Prerequisites

- **AnduinOS** (or any Ubuntu-based distribution).
- A compatible NVIDIA GPU.
- Basic knowledge of using the terminal.
- Internet connection to download drivers and dependencies.
- Backup your system or important data before proceeding with driver installations.

## Automatic Installation (Recommended for Most Users)

For most users, letting **Ubuntu (and thus AnduinOS)** automatically detect and install the recommended NVIDIA drivers is the simplest and quickest method:

```bash
sudo apt update
sudo ubuntu-drivers install
```

1. **Update repositories**: This ensures you have the latest package lists.
2. **Install drivers**: The `ubuntu-drivers install` command automatically detects your NVIDIA GPU and installs the recommended driver.
3. **Reboot** your system to apply the changes.

!!! note "Not Always the Latest Driver"

    The automatically installed driver might **not** be the latest available from NVIDIA. If you require newer drivers—for example, to support newer GPU models or software features—you should proceed with the **Manual Installation** instructions.

!!! warning "Nvidia drivers may have a lot of bugs..."

    The NVIDIA drivers may have a lot of bugs. If you encounter any issues, please report them to the [NVIDIA developer forum](https://forums.developer.nvidia.com/c/linux/). You can also check the [NVIDIA driver release notes](https://www.nvidia.com/en-us/drivers/unix/) for known issues and fixes.

    To mitigate, it is recommended to use an older version of the NVIDIA driver. And use Xorg instead of Wayland.

    To view available NVIDIA driver versions, you can use the following command:

   ```bash title="List available NVIDIA driver versions"
   ubuntu-drivers list --gpgpu
   ```

---

## PPA Installation (Recommended if you need latest drivers)

If you don't want to use the automatic installation method or need a specific version of the NVIDIA driver, you can use a PPA (Personal Package Archive) to install the drivers. This method is useful for getting newer drivers that may not yet be available in the default repositories.

To add the graphics-drivers PPA, run the following commands:

```bash title="Add the graphics-drivers PPA"
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
```

This PPA contains the latest NVIDIA drivers. After adding the PPA, you can install the driver using:

```bash title="Install NVIDIA driver from PPA"
sudo apt install nvidia-graphics-drivers-575 # Replace '575' with the desired driver version
```

Then reboot your system:

```bash
sudo reboot
```

This method is generally safe and recommended for users who want to ensure they have the latest stable drivers without manually downloading and installing them.

---

## Manual Installation (For advanced Users)

The manual installation method allows you to install specific (often newer) NVIDIA drivers, especially if you need features not yet packaged in the default AnduinOS/Ubuntu repositories.

### Step 1: Clean the System of Existing Drivers

Before proceeding, remove any existing or partially installed NVIDIA drivers to avoid conflicts:

```bash
sudo apt remove --purge nvidia-*
sudo apt remove --purge libnvidia-*
sudo apt remove --purge xserver-xorg-video-nvidia-*
sudo apt remove --purge nvidia-settings
sudo apt remove --purge nvidia-prime
sudo apt autoremove --purge
sudo apt autoclean
```

This ensures no leftover packages interfere with the new installation.

---

### Step 2: Download the NVIDIA Driver

1. **Visit the [NVIDIA Drivers Website](https://www.nvidia.com/en-us/drivers/)**.
2. **Locate the correct driver**:
   - Select your GPU model (e.g., GeForce RTX 4090, GTX 1080, etc.).
   - Select the appropriate operating system (Linux 64-bit).
   - Click "Search" and download the appropriate `.run` file.
3. **Make the file executable**. Suppose your file is named `NVIDIA-Linux-x86_64-565.77.run`:

   ```bash
   chmod +x NVIDIA-Linux-x86_64-565.77.run
   ```

!!! note "How to Choose the Correct Driver"

    - **Long Lived Branch (Production Branch)**: Often more stable and tested.
    - **Short Lived Branch**: Provides the latest features and improvements but may be less tested.
    - **Legacy Drivers**: Required for older GPUs that no longer receive current driver support.

---

### Step 3: (Optional) Signing Keys for Secure Boot

Secure Boot ensures your system only loads drivers or kernel modules signed by a trusted key. If **Secure Boot is enabled** in your BIOS/UEFI, you **must** sign the NVIDIA driver module. If Secure Boot is **disabled**, you can skip this step—but it is **strongly recommended** to keep Secure Boot enabled.

1. **Generate a private key and a self-signed certificate**:

   ```bash
   mkdir ~/my-keys
   cd ~/my-keys
   openssl req -new -newkey rsa:2048 -days 36500 -nodes -keyout MOK.key -out MOK.csr
   openssl x509 -req -in MOK.csr -signkey MOK.key -out MOK.crt
   openssl x509 -in MOK.crt -outform DER -out MOK.der
   ```

   - `MOK.key` is your **private key**. 
   - `MOK.crt` is your **public certificate**.
   - `MOK.der` is your certificate in DER format for enrollment.

2. **Enroll your key using `mokutil`**:

   ```bash
   sudo mokutil --import MOK.der
   ```

   You will be prompted to create a password. **Remember this password**, as you will use it after the reboot.

3. **Reboot and enroll your key**:

   ```bash
   sudo reboot
   ```

   - During the boot, **MokManager** appears.
   - Select **"Enroll MOK"**, then **"Continue"**.
   - Enter the password you set previously.
   - Confirm to enroll the key and reboot again.

4. **Verify your key is enrolled**:

   ```bash
   sudo mokutil --list-enrolled
   ```

   The output should list your certificate. If it is listed, Secure Boot should now trust modules signed with your private key.

!!! note "Keep Your Keys Safe"

    - **Never share your private key (`.key`)** with others.
    - Always keep these files in a secure place. If you lose them, you’ll need to re-sign or re-enroll future kernel modules.

---

### Step 4: Blacklist the Nouveau Driver

The open-source Nouveau driver can conflict with NVIDIA’s proprietary driver. To ensure it doesn’t load:

1. **Blacklist Nouveau**:

   ```bash
   sudo vim /etc/modprobe.d/blacklist-nouveau.conf
   ```

   Insert the following lines:

   ```bash
   blacklist amd76x_edac
   blacklist vga16fb
   blacklist nouveau
   blacklist rivafb
   blacklist nvidiafb
   blacklist rivatv
   ```

   (Note: The line `blacklist amd76x_edac` is sometimes recommended on certain systems. If you do not have AMD hardware, it might be unnecessary. However, it’s often included in sample blacklist files.)

2. **Regenerate initramfs**:

   ```bash
   sudo update-initramfs -u -k all
   ```

---

### Step 5: Prepare to Install the NVIDIA Driver

1. **Install necessary build dependencies**:

   ```bash
   sudo apt update
   sudo apt install gcc make build-essential dkms linux-headers-$(uname -r)
   ```

   This ensures that you can compile the NVIDIA kernel module correctly.

2. **Switch to a multi-user (text) target**:  
   Before installing the driver, you must stop the display server (Xorg or Wayland). You can do this by changing the system’s runlevel/target:

   ```bash
   sudo systemctl set-default multi-user.target
   sudo systemctl isolate multi-user.target
   ```

   Your screen will switch to a TTY console. **Log in** with your username and password. (Nothing appears as you type the password—this is normal.)

!!! warning "Be Prepared for a Terminal-Only Environment"

    Once you move to `multi-user.target`, you lose the graphical interface. If something goes wrong, you will need to troubleshoot via the command line.

---

### Step 6: Install the NVIDIA Driver

1. **Navigate to the directory containing the downloaded driver**:

   ```bash
   cd ~/Downloads
   ```

2. **Run the installer** (example filename below):

   ```bash
   sudo ./NVIDIA-Linux-x86_64-565.77.run
   ```

3. **Follow the on-screen prompts**:
   - **License Agreement**: Accept the license.
   - **Installation Path**: The default path is usually fine.
   - **32-bit Compatibility Libraries**: 
     - **Recommended** to install if you run software such as Steam, Wine, or certain games requiring 32-bit libraries.
     - **Not necessary** if you only run 64-bit applications.
   - **Signing the module (if Secure Boot is enabled)**:
     - Provide the **absolute path** to your **private key**: e.g., `/home/anduin/my-keys/MOK.key`.
     - Do **not** use `~/my-keys/MOK.key` (relative paths may cause errors).
     - You must also have your corresponding `.crt` in the same directory for verification.

!!! warning "Provide the Correct Key"

    - **`.key`** = private key  
    - **`.crt`** = public certificate  
    Installing the driver will automatically sign the kernel module with your private key if configured correctly.

---

### Step 7: Reboot and Validate Installation

1. **Reboot** your system:

   ```bash
   sudo reboot
   ```

2. **Check driver status**:

   ```bash
   nvidia-smi
   ```

   If the driver is installed correctly, you should see a table showing your GPU, driver version, and other details.

3. **Secure Boot Verification (if applicable)**:

   ```bash
   sudo mokutil --sb-state
   ```

   - If it shows `SecureBoot enabled`, your driver should be signed and recognized by the system.

!!! note "Kernel Updates"

    **When your kernel updates**, you may need to recompile or re-sign the NVIDIA driver module. If you installed via a .run file, you may have to rerun the installer or rely on DKMS (if configured properly).

---

### Step 8: Adjust Display Server and Resolution

Depending on your system, you may be running **Xorg** or **Wayland**. In many cases, **Xorg** provides better compatibility with NVIDIA’s proprietary drivers.

1. **Check your current session type**:

   ```bash
   echo $XDG_SESSION_TYPE
   ```

   - Returns `x11` (Xorg) or `wayland`.

2. **Switching display servers**:
   - You can select between **Xorg** and **Wayland** at the login screen (Gear icon or session dropdown).
   - Some distributions default to Wayland; if you experience issues, try switching to Xorg.

3. **Adjust your resolution** (example using `xrandr`):

   ```bash
   xrandr
   ```

   This lists available modes. To set a specific resolution and refresh rate:

   ```bash
   xrandr --output HDMI-0 --mode 3840x2160 --rate 144
   ```

   Replace `HDMI-0` with the correct output device name (it can be `DP-0`, `DVI-D-0`, etc.).

---

### Step 9: (Optional) Install NVIDIA Docker Toolkit

If you use **Docker** and want to take advantage of your NVIDIA GPU inside containers (for machine learning, AI workloads, or GPU-accelerated applications), install the **NVIDIA Container Toolkit**. Please refer to the [Docker NVIDIA Container Toolkit documentation](../Applications/Development/Docker/Docker.md) for detailed steps.

---

## Troubleshooting

1. **Black screen or system freeze after reboot**:
   - Boot into a **recovery mode** or use a **Live USB** to revert or remove the NVIDIA driver.
   - Check that **Nouveau** was properly blacklisted and the **initramfs** was updated.
   - Ensure your kernel version matches the **installed kernel headers**.

2. **Driver mismatch**:
   - If `nvidia-smi` says `NVIDIA-SMI has failed because it couldn't communicate with the NVIDIA driver`, then your driver or kernel module may not be correctly installed or signed.

3. **Secure Boot issues**:
   - Make sure the MOK (Machine Owner Key) is enrolled.
   - Confirm your private key and certificate paths are correct when prompted during the `.run` installer.

4. **Updates break the driver**:
   - Using the `.run` file approach means you might need to re-run the installer after a kernel update. Consider using DKMS or the official Ubuntu packaging for automatic module rebuilding.

---

## Conclusion

You have now installed the NVIDIA driver on **AnduinOS** (Ubuntu-based) either by using the **automatic** method (recommended for most users) or via the **manual** method (for more specific or newer versions of the driver). Properly installed and configured drivers can significantly improve graphics performance and unlock advanced GPU features. Always remember to keep your drivers and system updated, and ensure that you have a **backup** or **snapshot** strategy when making significant changes to the system (like updating drivers or switching kernels).

Enjoy your enhanced GPU performance!