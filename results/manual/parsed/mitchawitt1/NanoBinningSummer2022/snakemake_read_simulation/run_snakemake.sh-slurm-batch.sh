#!/bin/bash
#FLUX: --job-name=sm_read_simulation
#FLUX: --queue=panda
#FLUX: -t=57600
#FLUX: --urgency=16

source ~/.bashrc
snakemake --cores 1
