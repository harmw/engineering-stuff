# logging (python)

This implements the [logging bits](../logging) using `python`.

To generate the example log file please use generate.sh from the above location.

```bash
pip3 install -r requirements.txt
```

```bash
python3 go.py reader -f httpd.log
```

Example output:
```
{
    "192.0.2.42": 104,
    "192.0.2.99": 27,
    "192.0.2.26": 2,
    "192.0.2.27": 2,
    "192.0.2.72": 2,
    "192.0.2.81": 2,
[..]
```
