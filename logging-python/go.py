#!/usr/bin/env python3
import re
import json


LOG = "httpd.log"

# example:
# [Tue Aug 20 19:31:56 CEST 2024] 192.0.2.42 /foo5 GET Mozilla/5.0 (something something user-agent)

pattern = r'\[(.*?)\] (\d+\.\d+\.\d+\.\d+) (\S+) (\S+) (.*)'

hits = {}

try:
  with open(LOG, 'r') as f:
    lines = f.readlines()
    for line in lines:
      match = re.match(pattern, line.strip())
      if match:
        ip = match.group(2)
        if ip in hits:
          hits[ip] += 1
        else:
          hits[ip] = 1
except Exception as e:
  print(f"oops: {e}")
  raise

data = {k: v for k, v in sorted(hits.items(), key=lambda item: item[1], reverse=True)}

pretty = json.dumps(data, indent=4)
print(pretty)
