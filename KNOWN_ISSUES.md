# Known issues

## 1. Issue 1 - Gnome Desktop Manager can not start on Hyper-V Gen 1 VM

When you start AnduinOS on a Hyper-V Gen 1 VM, the Gnome Desktop Manager may not start. It may stuck at the boot screen. This is a known issue and can be reproduced on Ubuntu 22.04. The workaround is to use a Hyper-V Gen 2 VM.

## 2. Issue 2 - Secure Boot may cause boot failure if installed Microsoft's latest updates

In recent Microsoft updates, it revoked the certificate of Canonical shim. This may cause boot failure on some computers. The workaround is to disable Secure Boot in the BIOS settings.

## 3. Issue 3 - The share feature on Gnome Control Center may not work

The share feature on Gnome Control Center may not work. So you can not use the share feature to host a remote desktop session. The workaround is to use the `xrpd` package to host a remote desktop session.
