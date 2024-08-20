# Alpine 3.20 (fails)
# FROM alpine@sha256:0a4eaa0eecf5f8c050e5bba433f58c052be7587ee8af3e8b3910ef9ab5fbe9f5

# Ubuntu 24.04
FROM ubuntu@sha256:8a37d68f4f73ebf3d4efafbcf66379bf3728902a8038616808f04e34a9ab63ee

ENV BITCOIN_VERSION 27.0

ARG TARGETPLATFORM

WORKDIR /tmp

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN echo \
  && apt-get update \
  && apt-get -y install --no-install-recommends \
    curl=8.5.\* \
    openssl=3.0.13\* \
    ca-certificates=20240203 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN echo \
  && [[ "${TARGETPLATFORM}" = "linux/arm64" ]] && PLATFORM=aarch64-linux-gnu || PLATFORM=x86_64-linux-gnu \
  && echo "*** Building for ${PLATFORM} ***" \
  && curl -sLO https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-${PLATFORM}.tar.gz \
  && curl -sLO https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/SHA256SUMS \
  && grep bitcoin-${BITCOIN_VERSION}-${PLATFORM}.tar.gz SHA256SUMS | sha256sum -c \
  && mkdir -p /opt/bitcoin \
  && tar -xzf bitcoin-${BITCOIN_VERSION}-${PLATFORM}.tar.gz --directory=/opt/bitcoin \
  && ln -s /opt/bitcoin/bitcoin-${BITCOIN_VERSION} /opt/btc

RUN useradd --create-home --no-log-init -u 1001 btc

# TODO: setup config file
# COPY bitcoin.conf /opt/btc/bitcoin.conf

USER btc

RUN /opt/btc/bin/bitcoind -version | head -n 1

ENTRYPOINT ["/opt/btc/bin/bitcoind"]
