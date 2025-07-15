#!/bin/bash
#FLUX: --job-name="rfm_Sysinfo_job"
#FLUX: -n=4
#FLUX: --queue=hpc
#FLUX: -t=600
#FLUX: --priority=16

export SLURM_MPI_TYPE='pmix_v3'

export SLURM_MPI_TYPE=pmix_v3
srun python sysinfo.py
echo Done
