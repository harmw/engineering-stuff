# terraform iam example

This example will create a role/policy/user/group named `bananas`.

Note: a _policy_ with name `bananas-policy` is redundant, hence we suffice with an optional suffix.

Running it:

```bash
make test
make plan
make apply
```

Current plan output:

```bash
[..]

Plan: 5 to add, 0 to change, 0 to destroy.
```

## Notes

AWS authentication has been broken due to no access to _the real thing_. At least this allows us to run the _planning_ stage.

Second, ideally we'd use a remote backend for state storage. This example uses terraform cloud:

```hcl
terraform {
  required_version = ">= 1.1"
  backend "remote" {
    organization = "harmless-industries"
    workspaces {
      name = "engineering-stuff"
    }
  }
}
```
