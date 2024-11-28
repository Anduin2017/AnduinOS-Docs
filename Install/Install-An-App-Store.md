# Install An App Store

By default, AnduinOS doesn't come with a Software Store pre-installed. You can install a Software Store of your choice to start installing apps.

??? Tip "Why a store is not pre-installed?"

    The decision not to include a pre-installed software store in AnduinOS stems from several key considerations.

    Traditional package management systems each present unique challenges. For instance, Nix, while powerful with its functional approach, can be daunting for the average user to navigate. Arch's AUR, despite its flexibility, is often criticized for its chaotic and hard-to-manage nature. Ubuntu and Debian's `apt` package manager is reliable, but resolving package conflicts can be particularly challenging. Meanwhile, newer industry trends favor solutions like Snap, AppImage, and Flatpak. We believe it makes sense to rely on `apt` for managing core system components while utilizing modern solutions such as Flatpak, Docker, AppImage, or Snap for user-installed graphical applications.

    It’s also evident that preferences for software management vary widely among users today. Some prefer native package managers like `apt` or `dnf`, others appreciate the extensibility of AUR, while many are drawn to newer approaches like Nix, Flatpak, Docker, AppImage, or Snap. The guiding principle for AnduinOS's pre-installed content is straightforward: if it’s not certain that all users need something, it won’t be pre-installed. AnduinOS primarily targets professional users who are proficient in managing their system's software packages, and for most, `apt` alone suffices. Furthermore, the Linux application store ecosystem is highly fragmented, often relying on different underlying package management solutions, such as `dpkg`, AppImage, Flatpak, or Docker.

    Currently, AnduinOS lacks a specific development direction or distinguishing focus. Therefore, apart from `apt`, it doesn’t come pre-configured with any additional software management systems or stores. This design provides flexibility, allowing users to adopt the solutions that best suit their needs. For those seeking a modern graphical app store experience, Flatpak combined with Flathub is highly recommended.

    Additionally, many software license agreements explicitly state that unauthorized distribution is illegal. If we operate our own app store, such software that we lack the rights to distribute cannot be included in the store. We cannot take on this legal risk. For example: Google Chrome, Skype, Zoom, WhatsApp, ElasticSearch, Minecraft, Steam, Epic Store, EA Origin, etc. Therefore, the best option we can provide is to guide users on how to install these applications via their official channels on Linux and organize one-click installation methods through the official channels.

    By omitting a pre-installed software store, AnduinOS empowers users to choose the option that aligns best with their workflow and preferences.

## Option 1 - Install Flatpak and Flathub as a Software Store

Follow these simple steps to start using Flatpak as a Software Store on AnduinOS.

[Install Flatpak and Flathub](../Applications/Store/Flathub/Flathub.md)

## Option 2 - Install Snap Store as a Software Store

Follow these simple steps to start using Snap as a Software Store on AnduinOS.

[Install Snap Store](../Applications/Store/Snap-Store/Snap-Store.md)

## Option 3 - Install Nix as a Software Store

Follow these simple steps to start using Nix as a Software Store on AnduinOS.

[Install Nix](../Applications/Store/Nix/Nix.md)
