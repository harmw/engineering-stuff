#!/usr/bin/env sh
set -e

# Reminder: Syft extracts the SBOM, Grype scans for vulnerabilities

# Use versions as used in GitHub workflows:
# https://github.com/anchore/sbom-action/blob/main/src/SyftVersion.ts
# https://github.com/anchore/scan-action/blob/main/GrypeVersion.js
SYFT_TAG=v0.103.1   # Jan 31, 2024
GRYPE_TAG=v0.74.5   # Feb 14, 2024

# Use this to create an SBOM as was done in some past release
SYFT_TAG=v0.105.1   # Feb 2024

SBOM=$(basename ${PWD})_sbom.spdx.json

mkdir -p ~/.grype/cache

if [ -z $1 ]
then
  TARGET="dir:/work/"
  echo "Using default target - alternative argument: docker:<container>"
else
  TARGET="${1}"
  echo "Using target: ${TARGET}"
fi

echo "Extracting SBOM using Syft ${SYFT_TAG}"

docker run \
  --rm \
  -it \
   -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}:/work \
  anchore/syft:${SYFT_TAG} \
    packages \
    ${TARGET} \
    -o spdx-json \
    --file /work/${SBOM}

if [ -f ./grype.config.yaml ]; then
  echo "Using local grype configuration"
else
  cat >./grype.config.yaml <<EOF
ignore:
  - package:
      name: n-o-p-E
EOF
fi

echo "Scanning for vulnerabilities using Grype ${GRYPE_TAG}"

docker run \
  --rm \
  -it \
  -v ${PWD}:/work \
  -v ~/.grype/cache:/.cache/grype \
  anchore/grype:${GRYPE_TAG} \
    sbom:/work/${SBOM} \
    -o sarif \
    --file /work/scan.sarif \
    --config /work/grype.config.yaml
