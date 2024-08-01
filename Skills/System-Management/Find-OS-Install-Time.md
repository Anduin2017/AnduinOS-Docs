# How to find the OS install time

To find the OS install time on AnduinOS, you can use the `stat` command:

```bash title="Find OS install time"
stat /
```

And you can filter the `Birth` field to get the OS install time:

```bash title="Find OS install time"
stat / | grep Birth
```

Or even simpler, you can run:

```bash title="Find OS install time"
stat -c %w /
```

That's it!
