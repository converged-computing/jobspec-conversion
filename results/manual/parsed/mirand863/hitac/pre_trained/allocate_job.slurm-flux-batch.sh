#!/bin/bash
#FLUX: --job-name=hello-truffle-3929
#FLUX: --queue=magic
#FLUX: -t=432000
#FLUX: --priority=16

snakemake --unlock
snakemake --profile slurm
