# alpine:3.22.2
FROM alpine@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412

USER root

# Install dependencies for:
RUN apk --no-cache add \
# - Please
    bash curl git \
# - cc-rules (build-time)
    binutils gcc g++ musl-dev \
# - cc-rules (tests only)
    file \
# - python-rules (build-time)
    python3 python3-dev py3-pip

# Create a non-root user (that can still run commands as root if required). The user and group names
# and IDs are identical to those on GitHub's official Ubuntu runner images.
RUN apk --no-cache add sudo && \
    addgroup -g 1001 runner && \
    adduser -u 1001 -G runner -D runner && \
    echo runner:runner | chpasswd && \
    echo 'Defaults:runner !requiretty' > /etc/sudoers.d/runner && \
    echo 'runner ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/runner && \
    chmod 0440 /etc/sudoers.d/runner

# Work around https://github.com/actions/runner/issues/801 on arm64 by not overtly identifying as
# Alpine Linux and installing a musl-linked Node.js interpreter from the Alpine repos for JavaScript
# actions to use.
RUN if [ "$(uname -m)" = aarch64 ]; then \
        sed -i -e '/^ID=/s/alpine/enipla/' /etc/os-release && \
        apk --no-cache add nodejs && \
        mkdir -p /opt/bin && \
        ln -s /usr/bin/node /opt/bin/node; \
    fi

USER runner
WORKDIR /home/runner

CMD ["/bin/bash"]
