#!/bin/bash
#FLUX: --job-name=sm_CATBAT
#FLUX: --queue=panda
#FLUX: -t=57600
#FLUX: --urgency=16

source ~/.bashrc
cd /athena/ihlab/scratch/miw4007/simulation_test/tools/snakemake_binning_assessment/
snakemake --cores 4
exit
