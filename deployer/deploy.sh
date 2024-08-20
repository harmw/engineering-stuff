#!/usr/bin/env bash
set -e

JOB=${1-job.hcl}

quit() {
  echo Error: "$1"
  exit 1
}

[[ ! -f ${JOB} ]] && quit file_not_found 

echo Deploying from $JOB

nomad job run job.hcl

if [ $? = 0 ]]; then
  echo Success
else
  echo Failed
fi
