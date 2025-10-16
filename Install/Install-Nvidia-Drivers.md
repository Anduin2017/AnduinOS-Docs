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

!!! warning "Remember your username and password before switching to multi-user.target"

    You will need to log in again after switching to the multi-user target. Make sure you remember your username and password, or you will be locked out of your system!

    To query the current target, you can use:

    ```bash
    systemctl get-default
    ```

    To query the current user name, you can use:

    ```bash
    whoami
    ```

If you need to return to the graphical interface later, you can switch back to the graphical target with:

```bash
sudo systemctl set-default graphical.target
```

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

### 0. First Diagnostic: Check Driver Status

Before troubleshooting, open a terminal and run `nvidia-smi`.

If you see a table with your GPU name and driver version, your driver is **working**. If your problem is system lag or choppy animations on a laptop, skip to **point 5**.

If you see an error like `NVIDIA-SMI has failed because it couldn't communicate with the NVIDIA driver`, it means the driver module is **not loaded**. Start troubleshooting from point 1 or 2.

### 1. Black screen or system freeze after reboot

This is the most common failure, usually happening right after installing a driver. It means the `nvidia` kernel module failed to load, often because it conflicts with the open-source `nouveau` driver, or it wasn't correctly registered with the kernel.

To fix this, you must boot into **recovery mode**. From the recovery menu, drop to a **root shell**. In the shell, run `mount -o remount,rw /` to make the system writable.

Then, completely remove the broken driver by running `sudo apt-get purge '*nvidia*'` and `sudo apt autoremove`. After this, type `reboot`. Your system should now boot normally using the `nouveau` driver, and you can attempt to reinstall the NVIDIA driver again.

### 2. Driver mismatch (nvidia-smi fails)

This error means the system is running, but the NVIDIA driver isn't loaded. The most common cause is a **kernel update**. The NVIDIA driver is a kernel module that must be compiled for the *exact* kernel version you are running. When your kernel updates, the driver module (if not set up with DKMS) is left behind, causing a mismatch.

Another common cause is **Secure Boot**, which blocks unsigned modules from loading. See **point 3** for this.

To fix a kernel mismatch, first ensure you have the headers for your current kernel: `sudo apt install linux-headers-$(uname -r)`. If you installed via `apt`, try `sudo dpkg-reconfigure nvidia-dkms-[version]` (e.g., `nvidia-dkms-550`) to force a recompile. If you used a `.run` file, you must re-run the installer.

### 3. Secure Boot issues

Secure Boot is a UEFI feature that prevents untrusted (unsigned) code from running at boot. Since the NVIDIA driver is a third-party kernel module, Secure Boot will block it by default, leading to a "driver not loaded" error.

The simplest solution is to **reboot, enter your PC's BIOS/UEFI setup, and set Secure Boot to "Disabled"**. This is the easiest fix and has minimal security impact for most users.

The "correct" solution is to enroll the driver's key (MOK). During driver installation (both `apt` and `.run`), you should be prompted to create a MOK password. After you set it, you *must* reboot. A blue "MOK management" screen will appear. Select "Enroll MOK," "Continue," and enter the password you just created. This "authorizes" the driver for Secure Boot.

### 4. Updates break the driver

This is related to point 2. If you installed your driver using the official `.run` file from NVIDIA's website, that driver is compiled *only* for your current kernel. **You must re-run the installer file every time AnduinOS updates its kernel.**

To avoid this, we strongly recommend installing drivers from the AnduinOS/Ubuntu repositories (e.g., `sudo apt install nvidia-driver-550`). These packages use **DKMS** (Dynamic Kernel Module Support).

DKMS automatically rebuilds the NVIDIA module every time your kernel is updated, which prevents this problem from happening. It's the "set it and forget it" solution.

### 5. Laptop animations are laggy (PRIME Profiles)

This is a **configuration issue**, not a driver failure. It's common on NVIDIA Optimus laptops (like HP OMEN) that have both Intel (integrated) and NVIDIA (dedicated) graphics. Your `nvidia-smi` will show the driver is working, but your desktop feels slow.

This happens because the system is in **"On-Demand" mode** to save power. The Intel GPU runs your desktop (menus, animations), while the powerful NVIDIA GPU sleeps until you manually run a game on it. If your Intel GPU isn't powerful enough, the desktop will feel laggy.

To fix this, force the NVIDIA GPU to run everything. Open `nvidia-settings` from your terminal. Go to the **"PRIME Profiles"** tab on the left. Change the setting from "NVIDIA On-Demand" to **"NVIDIA (Performance Mode)"**. Apply, and then **reboot your laptop**. Your desktop will now be rendered by the fast NVIDIA GPU and all animations will be smooth. (Note: this uses much more battery).

Or you can do that via:

```bash
sudo apt update
sudo apt install nvidia-prime
sudo prime-select query # Query current mode (will likely show 'on-demand')
sudo prime-select nvidia # Switch to NVIDIA (Performance Mode)
```

You must **reboot your laptop** after running this command for the change to take effect. This does the exact same thing as the `nvidia-settings` GUI method.

To switch back to power-saving mode later (e.g., when on battery), you can run `sudo prime-select on-demand` and reboot again.

## Conclusion

You have now installed the NVIDIA driver on **AnduinOS** (Ubuntu-based) either by using the **automatic** method (recommended for most users) or via the **manual** method (for more specific or newer versions of the driver). Properly installed and configured drivers can significantly improve graphics performance and unlock advanced GPU features. Always remember to keep your drivers and system updated, and ensure that you have a **backup** or **snapshot** strategy when making significant changes to the system (like updating drivers or switching kernels).

Enjoy your enhanced GPU performance!