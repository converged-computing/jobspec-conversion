#!/bin/bash
#FLUX: --job-name=crusty-gato-9614
#FLUX: -N=2
#FLUX: -c=2
#FLUX: -t=1800
#FLUX: --urgency=16

module load openjdk/17.0.8.1_1
./nextflow run 3_parallelExample.nf -c configs/slurm.config
