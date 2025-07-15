#!/bin/bash
#FLUX: --job-name=noiserdd
#FLUX: --queue=hns,normal,stat
#FLUX: -t=86400
#FLUX: --urgency=16

ml load gmp
ml load mpfr
ml load R/4.0.2
ml load julia/1.6.2
Rscript simulation.R $SLURM_ARRAY_TASK_ID
