# logging

This example generates a dummy httpd logfile and prints a hit counter per ip.

We start with generating a logfile:

```bash
sh generate.sh
```

And next we can print hits per uniq ip:

```bash
cat httpd.log | cut -d ']' -f2 | cut -d ' ' -f2 | sort | uniq -c | sort -nr
```

Or just the top 5:

```bash
cat httpd.log | cut -d ']' -f2 | cut -d ' ' -f2 | sort | uniq -c | sort -nr | head -n 5
```

Example output:

```bash
% cat httpd.log | cut -d ']' -f2 | cut -d ' ' -f2 | sort | uniq -c | sort -nr | head -n 5
 104 192.0.2.42
  27 192.0.2.99
   2 192.0.2.96
   2 192.0.2.92
   2 192.0.2.90
```

