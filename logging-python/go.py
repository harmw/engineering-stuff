#!/usr/bin/env python3
import click
import sys
import re
import json


@click.group()
def cli():
    """Simple log reader"""
    pass


@cli.command()
@click.option("-f", help="name of the file to read", required=True)
def reader(f):
    """Reads the logfile and counts hits per ip"""

    # example:
    # [Tue Aug 20 19:31:56 CEST 2024] 192.0.2.42 /foo5 GET Mozilla/5.0 (something something user-agent)

    pattern = r"\[(.*?)\] (\d+\.\d+\.\d+\.\d+) (\S+) (\S+) (.*)"

    hits = {}

    try:
        with open(f, "r") as log_file:
            lines = log_file.readlines()
            for line in lines:
                match = re.match(pattern, line.strip())
                if match:
                    ip = match.group(2)
                    if ip in hits:
                        hits[ip] += 1
                    else:
                        hits[ip] = 1
    except Exception as e:
        click.secho(f"oops: {e}", fg="red")
        sys.exit()

    data = {
        k: v for k, v in sorted(hits.items(), key=lambda item: item[1], reverse=True)
    }

    pretty = json.dumps(data, indent=4)
    print(pretty)


if __name__ == "__main__":
    cli()
