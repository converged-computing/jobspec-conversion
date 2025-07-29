#!/bin/bash
#FLUX: --job-name=sample_job
#FLUX: --queue=short
#FLUX: -t=1200
#FLUX: --urgency=16

module purge all
module load namd/2.14-openmpi-4.0.5-intel-19.0.5.281 
srun -n ${SLURM_NNODES} namd2 ++ppn $((${SLURM_NTASKS_PER_NODE}-1)) alanin.conf
