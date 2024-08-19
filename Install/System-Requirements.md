# AnduinOS System Requirements

!!! warning "Turn off Secure Boot"

    If you are using a UEFI system, by default it may enabled Secure Boot, which can prevent the installation of 3rd party operating systems. 

    While AnduinOS's installer ISO doesn't support Secure Boot, the installed system does. You may need to disable Secure Boot in the BIOS settings to install AnduinOS. And you can re-enable Secure Boot after the installation.

Minimum system requirements:

| Component       | Requirement                         |
|-----------------|-------------------------------------|
| Architecture    | x86_64 architecture                 |
| Firmware        | UEFI or BIOS                        |
| Processor       | 2 GHz processor                     |
| RAM             | 4 GB RAM                            |
| Disk Space      | 20 GB disk space                    |
| Screen          | 1024x768 screen resolution          |
| Ports           | USB port or DVD drive               |

System requirements for the best experience:

| Component       | Requirement                         |
|-----------------|-------------------------------------|
| Architecture    | x86_64 architecture                 |
| Firmware        | UEFI firmware                       |
| Processor       | 2.5 GHz quad-core processor         |
| RAM             | 8 GB RAM                            |
| Disk Space      | 50 GB disk space                    |
| Screen          | 2560x1440 resolution 27 inch screen |
| Internet        | Internet access                     |
| Secure Boot     | Secure Boot enabled (Trust 3rd party OS) |

!!! note "Only x86_64 architecture and ACPI-compliant hardware are supported."

    Currently AnduinOS only supports x86_64 architecture. If you are using a different architecture, you will not be able to install AnduinOS. (ARM not supported)

    Currently AnduinOS only supports ACPI-compliant hardware. If you are using non-ACPI-compliant hardware, you will not be able to install AnduinOS. (Legacy hardware not supported)

    AnduinOS supports both UEFI and BIOS boot firmware. Ensure your hardware is ACPI-compliant for proper installation. (U-boot not supported)
