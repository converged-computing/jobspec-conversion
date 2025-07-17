#!/bin/bash
#FLUX: --job-name=coronaPipeline
#FLUX: --queue=rbaltman
#FLUX: -t=86400
#FLUX: --urgency=16

set -ex
snakemake --cores 1 -p data/coronacentral.json
