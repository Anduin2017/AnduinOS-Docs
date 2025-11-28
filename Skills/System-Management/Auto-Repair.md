# Auto Repair

AnduinOS includes a powerful auto-repair tool designed to fix broken systems by restoring system files to their original state while preserving your personal data.

## How to use

To start the repair process, open a terminal and run:

```bash
do-anduinos-autorepair
```

Follow the on-screen instructions.

!!! warning "Warning"

    This process will reset many system configurations to their defaults. Please read the section below carefully to understand what will be affected.

## What is KEPT (100% Safe)

*   ✅ **Personal Files**: All your documents, photos, code, and downloads in your `/home` directory are untouched.
*   ✅ **Installed Applications**: Third-party applications are generally kept, unless they conflict with the system repair.

## What will be RESET to Factory Defaults

This script restores the OS to a "clean" state, so the following configurations will be reset:

*   **Desktop Look & Feel**: Wallpaper, Themes, Icons, Fonts, Start Menu (ArcMenu), and Taskbar (Dash to Panel) layouts.
*   **System Preferences**: Custom keyboard shortcuts, mouse/touchpad settings, and power settings (Sleep/Lock timers).
*   **Software Sources**: APT mirrors will be reset to official AnduinOS defaults; custom APT pinnings/preferences will be cleared.
*   **System-wide Modifications**: Any themes or extensions manually installed into `/usr/share/` (instead of your home folder) will be removed.
*   **Flatpak Configuration**: Custom Flatpak remotes might be reset.

In short: It's like "Reset all settings" on a phone, but your photos and files stay exactly where they are.
