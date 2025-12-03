# Alpine Builder

This repository builds [Alpine Linux](https://alpinelinux.org) container images with customisations to meet the needs of
various [Please](https://please.build)-related workflows on [GitHub Actions](https://github.com/features/actions). The
images are not guaranteed to be useful for any other purpose.

## Changes to upstream

- Images are only built for the `linux/amd64` and `linux/arm64` platforms, since these are the only Linux platforms
  supported by Please.
- By default, commands are executed in the container by the `runner` user (UID 1001), whose primary group is similarly
  `runner` (GID 1001). These match the user and group names and IDs used by the equivalent user in GitHub's official
  Ubuntu runner images. The `runner` user is allowed to run sudo without a password.
- Additional run-time dependencies for Please and the `pleasew` script are installed from the Alpine Linux repositories:
  - `bash`
  - `curl`
  - `git`
- Additional dependencies for Please's [cc-rules plugin](https://github.com/please-build/cc-rules) are installed from
  from the Alpine Linux repositories:
  - `binutils`
  - `file` (for tests only)
  - `gcc`
  - `g++`
  - `musl-dev`
- Additional dependencies for Please's [python-rules plugin](https://github.com/please-build/python-rules) are
  installed from the Alpine Linux repositories:
  - `python3`
  - `python3-dev`
  - `py3-pip`

## Release version numbering

Release version numbers take the form `vX.Y-please.N`, where:

- `X.Y` is the [Alpine Linux branch](https://alpinelinux.org/releases/) on which this release is based;
- `N` is a build revision specific to this repo, which is incremented each time a release is created and is reset to 1
  whenever the images are rebased on a different Alpine Linux branch.
