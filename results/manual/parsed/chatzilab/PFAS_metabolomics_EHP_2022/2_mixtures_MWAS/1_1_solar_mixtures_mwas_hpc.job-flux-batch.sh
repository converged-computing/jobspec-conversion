#!/bin/bash
#FLUX: --job-name=carnivorous-underoos-4946
#FLUX: -N=8
#FLUX: --queue=epyc-64
#FLUX: -t=72000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
module load gcc/11.2.0
module load openblas/0.3.18
module load jags
module load openmpi
module load pmix
module load r/4.1.2
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun --mpi=pmix_v2 -n $SLURM_NTASKS Rscript --vanilla 1_1_solar_mixtures_mwas_hpc.R
