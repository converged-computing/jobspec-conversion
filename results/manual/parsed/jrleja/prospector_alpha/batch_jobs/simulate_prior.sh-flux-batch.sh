#!/bin/bash
#FLUX: --job-name=simulate_prior
#FLUX: --queue=shared,conroy,itc_cluster
#FLUX: -t=345600
#FLUX: --urgency=16

srun -n 1 --mpi=pmi2 python $APPS/prospector_alpha/code/simulate_sfh_prior.py \
--cluster_idx="${SLURM_ARRAY_TASK_ID}" \
--outfile="$APPS"/prospector_alpha/results/priors/
