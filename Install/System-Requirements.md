# AnduinOS System Requirements

!!! warning "Adjust Secure boot settings in your BIOS"

    If you are using a UEFI system, by default it may only trust Microsoft-signed operating systems. In this case, you may need to adjust the Secure Boot settings in your BIOS to trust 3rd party operating systems. Please refer to your system's documentation for instructions on how to do this.

    ![Adjust secure boot settings](./seboot.png)

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
