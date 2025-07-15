#!/bin/bash
#FLUX: --job-name=gassy-leader-5443
#FLUX: -n=11
#FLUX: --queue=gpu4_short
#FLUX: -t=43200
#FLUX: --urgency=16

export SCRATCH=' # SCRATCH DIRECTORY FOR CLUSTER'

module load matlab/R2017a
export SCRATCH= # SCRATCH DIRECTORY FOR CLUSTER
mkdir -p $SCRATCH/$SLURM_JOB_ID
matlab -nojvm -nodisplay -nodesktop -singleCompThread -r "loc_mvpa_6mm_HPC_parallel('$1'); quit;"
rm -rf $SCRATCH/$SLURM_JOB_ID
