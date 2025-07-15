#!/bin/bash
#FLUX: --job-name=lovely-peanut-butter-7951
#FLUX: --exclusive
#FLUX: --queue=hpc
#FLUX: -t=259200
#FLUX: --urgency=16

export MALLOC_ARENA_MAX='4'

export MALLOC_ARENA_MAX=4
module load java/default
module load cuda/default
module load matlab/R2019b
module load openmpi/gnu
source ~/OpenFOAM-plus/etc/bashrc
matlab -batch "wheelcase_runSail('nCases',4,'caseStart',11,'gens',6,'config','config1')"
