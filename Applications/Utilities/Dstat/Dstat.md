# Dstat

!!! tip "AnduinOS Verified App - Open Source"

    Dstat is an AnduinOS verified app and it runs awesome on AnduinOS, with easy installation and automatic updates.

Dstat is a versatile replacement for vmstat, iostat, netstat, nfsstat, and ifstat. Dstat overcomes some of their limitations and adds some extra features, more counters, and flexibility. Dstat is handy for monitoring systems during performance tuning tests, benchmarks, or troubleshooting.

Dstat has two sources, you can:

```bash
sudo apt install dstat
```

Or:

```bash
sudo apt install pcp
```

After installing Dstat, you can run it by typing `dstat` in the terminal.

```bash
sudo dstat
```

Or more options:

```bash
sudo dstat --cpu --mem --disk --net --load --nocolor --noheaders
```
