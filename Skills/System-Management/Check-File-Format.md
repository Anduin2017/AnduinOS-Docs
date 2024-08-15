# Check File Format

In some cases, you might need to check if an uploaded file is in the correct format before processing it further.

## Learn basic file formats

Here are some common file formats and their extensions:

- PE (Portable Executable): `.exe`, `.dll`, `.sys`
- ELF (Executable and Linkable Format): `.elf`, `.o`, `.so`
- Mach-O (Mach Object): `.o`, `.dylib`, `.bundle`
- COFF (Common Object File Format): `.obj`, `.lib`

!!! note "File formats and operating systems"

    PE files are used in Windows operating systems, ELF files are used in Unix-like operating systems, Mach-O files are used in macOS, and COFF files are used in Unix-like operating systems and Windows.

## Check file format using `objdump`

You can use `objdump` to check the file format of an uploaded file. `objdump` is a command-line utility that displays information about object files, libraries, and executables.

Here's how you can use `objdump` to check the file format of a file:

```bash title="Check file format using objdump"
objdump -f <file>
```

For example:

```bash title="Check file format of an PE executable"
$ objdump -f /boot/vmlinuz
/boot/vmlinuz:     file format pei-x86-64
architecture: i386:x86-64, flags 0x00000103:
HAS_RELOC, EXEC_P, D_PAGED
start address 0x0000000001d8df84
```

!!! note "Why the Linux kernel is an PE executable?"

    The Linux kernel is not a Windows application, but it is an executable file in the Portable Executable (PE) format. That is to allow it to be booted directly by UEFI firmware on compatible systems.

    The PE format is a file format used in Windows operating systems for executables, object code, and DLLs.

For example:

```bash title="Check file format of an ELF executable"
$ objdump -f /usr/bin/ls
/usr/bin/ls:     file format elf64-x86-64
architecture: i386:x86-64, flags 0x00000150:
HAS_SYMS, DYNAMIC, D_PAGED
start address 0x0000000000006aa0
```

The output shows that the file `/usr/bin/ls` is in the ELF64 format for x86-64 architecture.

For example:

```bash title="Check file format of QQ application"
$ objdump -f ./QQ_9.9.15_240808_x64_01.exe 

./QQ_9.9.15_240808_x64_01.exe:     file format pei-i386
architecture: i386, flags 0x0000012e:
EXEC_P, HAS_LINENO, HAS_DEBUG, HAS_LOCALS, D_PAGED
start address 0x00406f45
```

The output shows that the file `./QQ_9.9.15_240808_x64_01.exe` is in the PE format for i386 architecture.

If the input `exe` file is i386 architecture, the output will be `pei-i386`. If the input `exe` file is x86-64 architecture, the output will be `pei-x86-64`.
