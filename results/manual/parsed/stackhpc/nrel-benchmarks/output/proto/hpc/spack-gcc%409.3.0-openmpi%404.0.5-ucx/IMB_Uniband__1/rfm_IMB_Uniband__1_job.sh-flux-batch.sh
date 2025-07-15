#!/bin/bash
#FLUX: --job-name="rfm_IMB_Uniband__1_job"
#FLUX: -n=2
#FLUX: --exclusive
#FLUX: --queue=hpc
#FLUX: -t=600
#FLUX: --priority=16

export SLURM_MPI_TYPE='pmix_v3'

export SLURM_MPI_TYPE=pmix_v3
spack load intel-mpi-benchmarks
srun IMB-MPI1 uniband -npmin 1
