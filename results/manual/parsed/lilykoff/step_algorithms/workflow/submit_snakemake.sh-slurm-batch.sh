#!/bin/bash
#FLUX: --job-name=snakemake_test
#FLUX: -c=4
#FLUX: -t=18000
#FLUX: --urgency=16

cd /users/lkoffman/step_algos_test
snakemake --cores 1
