#!/bin/bash
#FLUX: --job-name=ofa-test
#FLUX: --queue=standard
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.d/http_proxy.sh  # required for internet on the Great Lakes cluster
time snakemake --profile config/slurm --latency-wait 90 --configfile config/config_test.yaml
