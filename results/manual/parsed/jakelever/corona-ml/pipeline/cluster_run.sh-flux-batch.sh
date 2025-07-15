#!/bin/bash
#FLUX: --job-name=coronaPipeline
#FLUX: -t=86400
#FLUX: --priority=16

set -ex
snakemake --cores 1 -p data/coronacentral.json
