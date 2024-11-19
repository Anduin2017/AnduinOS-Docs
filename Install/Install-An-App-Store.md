# Install An App Store

By default, AnduinOS doesn't come with a Software Store pre-installed. You can install a Software Store of your choice to start installing apps.

??? Tip "Why a store is not pre-installed?"

    The choice not to pre-install a software store on AnduinOS is driven by several considerations. 

    Traditional package management systems each come with their own set of challenges. Nix, known for its functional modules, can be difficult for the average user to grasp, while Arch's AUR, though powerful, is often regarded as chaotic and hard to manage effectively. Ubuntu and Debian's apt package manager works well, but when package conflicts arise, they can be particularly difficult to resolve. Current industry trends lean towards newer solutions like Snap, AppImage, and Flatpak. We believe it makes sense to continue using apt for managing core system components while adopting Flatpak, Docker, AppImage, or Snap for user-installed graphical applications.

    However, it's also evident that user preferences for software management vary widely today. Some users prefer using native package managers like apt or dnf, others appreciate the flexibility of AUR, while some are drawn to solutions such as Nix or Flatpak/Docker/AppImage/Snap.

    AnduinOS currently does not have a definitive development direction or distinguishing focus. As a result, beyond apt, it does not come pre-configured with any user software management system or store. This provides flexibility, allowing users to choose their preferred solution. Flatpak, combined with Flathub, is highly recommended for those seeking a modern graphical app store experience.

    So, AnduinOS does not come with a pre-installed Software Store. This allows you to choose the Software Store that best fits your needs.

## Option 1 - Install Flatpak and Flathub as a Software Store

Follow these simple steps to start using Flatpak as a Software Store on AnduinOS.

[Install Flatpak and Flathub](../Applications/Store/Flathub/Flathub.md)

## Option 2 - Install Snap Store as a Software Store

Follow these simple steps to start using Snap as a Software Store on AnduinOS.

[Install Snap Store](../Applications/Store/Snap-Store/Snap-Store.md)

## Option 3 - Install Nix as a Software Store

Follow these simple steps to start using Nix as a Software Store on AnduinOS.

[Install Nix](../Applications/Store/Nix/Nix.md)
