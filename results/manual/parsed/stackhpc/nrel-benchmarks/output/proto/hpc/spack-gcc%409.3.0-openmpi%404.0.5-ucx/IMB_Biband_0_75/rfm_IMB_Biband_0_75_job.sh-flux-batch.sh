#!/bin/bash
#FLUX: --job-name=rfm_IMB_Biband_0_75_job
#FLUX: -n=24
#FLUX: --exclusive
#FLUX: --queue=hpc
#FLUX: -t=600
#FLUX: --urgency=16

export SLURM_MPI_TYPE='pmix_v3'

export SLURM_MPI_TYPE=pmix_v3
spack load intel-mpi-benchmarks
srun IMB-MPI1 biband -npmin 1
