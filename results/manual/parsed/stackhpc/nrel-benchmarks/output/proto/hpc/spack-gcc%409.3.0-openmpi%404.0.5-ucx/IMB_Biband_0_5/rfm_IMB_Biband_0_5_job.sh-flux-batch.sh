#!/bin/bash
#FLUX: --job-name="rfm_IMB_Biband_0_5_job"
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: --queue=hpc
#FLUX: -t=600
#FLUX: --priority=16

export SLURM_MPI_TYPE='pmix_v3'

export SLURM_MPI_TYPE=pmix_v3
spack load intel-mpi-benchmarks
srun IMB-MPI1 biband -npmin 1
