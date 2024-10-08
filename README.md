# random bits

Repo layout:

| folder          | description                                           |
|-----------------|-------------------------------------------------------|
| /               | building, testing and running containers              |
| /deployer       | simple deployment tool to get Nomad to run containers |
| /logging        | request counter for httpd.log                         |
| /logging-python | request counter for httpd.log (python implementation) |
| /iam            | terraform project with some IAM stuff going on        |

## Docker

Some bits around ~~bitcoin~~ and docker.

Assumes `docker` and something like `colima` (mac: `brew install colima docker`).

### Building

```bash
docker build -t bitcoin-core .
```

Linter for the `Dockerfile`, checking style and such:

```bash
hadolint Dockerfile
```

Security-related checks:

```bash
./vuln-scanner.sh docker:bitcoin-core
```

This extracts an SBOM and scans for vulnerabilities.

Current result:

```
   ├── by severity: 0 critical, 0 high, 5 medium, 7 low, 6 negligible
```

## CI

Testing is done using [GitHub actions](./.github/workflows).

### Running (local)

Launch an instance of the new container:

```bash
docker run --rm -it bitcoin-core
```

## Nomad

Installation instructions available [upstream](https://developer.hashicorp.com/nomad/tutorials/get-started/gs-install).

```bash
% nomad -v
Nomad v1.8.3
BuildDate 2024-08-13T07:37:30Z
Revision 63b636e5cbaca312cf6ea63e040f445f05f00478
```

Launch in single-instance dev mode:

```bash
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
nomad agent -dev -bind 0.0.0.0 -network-interface '{{ GetDefaultInterfaces | attr "name" }}'
```

Status:

```bash
% nomad node status
ID        Node Pool  DC   Name                     Class   Drain  Eligibility  Status
2afc4aec  default    dc1  Harms-MacBook-Pro.local  <none>  false  eligible     ready
```

Deployments are outlined in [deployer](./deployer/).
