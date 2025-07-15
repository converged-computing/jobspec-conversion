#!/bin/bash
#FLUX: --job-name=persnickety-bits-7686
#FLUX: --urgency=16

module purge
module load singularity
singularity exec docker://XSEDE/nix-container-sc-benchmark /usr/local/sc-benchmark/rbenchmark.R && /usr/local/sc-benchmark/scratch-dna-go 1000 1048576 10 /usr/local/sc-benchmark/dna
