# deployer

A simple deployment tool to ship whatever was just build in GitHub. (example https://github.com/harmw/engineering-stuff/pull/2)

The CI process takes place entirely in GitHub, building container(s) and pushing them into some registry.
Workflows in GitHub take care of testing the container, improving trust in what is to be shipped.

The CD process is able to pick any published container and deploy to Nomad.

:warning: This currently fails, likely due my `colima` (Mac+docker) setup:

```
[..]
2024-08-20T21:36:22.744+0200 [DEBUG] client.driver_mgr.docker: failed to start container: driver=docker container_id=493bdc37532d2be97b3af1409f9ab3af3e91be15f661086a910d391dc3fbe139 attempt=5 error="API error (500): driver failed programming external connectivity on endpoint frontend-c071dfff-6611-139c-53d4-45d21fe93cb3 (147566629b8bb51da750e6dc4d231de76d0d60e9b8b3403f75841b4e1576ad30): Error starting userland proxy: listen tcp4 192.168.128.191:8080: bind: cannot assign requested address"
```

## TODO

- [ ] launch the container we create in /
- [ ] limit what the container can do (egress), though no hard requirements are set on that topic yet
- [ ] get consul to work so we can do liveliness checks (ie. launch a new instance if one goes afk)
- [ ] some router component to route to healhty instances
- [ ] canary deployments, where we send in some instances running `newVer` and gradually increase traffic, thus draining the `currentVer` instances and _safely deploying something new_
- [ ] logging?
- [ ] metrics?

