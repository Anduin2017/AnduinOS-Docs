# Allow sudo without password

Allowing sudo without password is a security risk, but it can be useful in certain situations.

!!! warning "Security Risk"

    Disabling the password requirement for sudo can be a security risk. This may cause some commands running without sudo to have root permissions and potentially break your system.

However, if you prefer to allow sudo without password, you can follow the steps below.

Open the sudoers file with the visudo command:

```bash title="Allow sudo without password"
sudo mkdir -p /etc/sudoers.d
sudo touch /etc/sudoers.d/$USER
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/$USER
```

That's it! You can now run sudo commands without entering your password.

## After installation

---

After installing AnduinOS, you may want to [Install more applications](../Applications/Introduction.md)
