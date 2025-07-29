#!/bin/bash
#SBATCH --job-name=MPICC
#SBATCH --output=stdout_%J.txt
#SBATCH --error=stderr_%J.txt
#SBATCH --nodes=3
#SBATCH --ntasks=9
#SBATCH --cpus-per-task=1
#SBATCH --partition=debug
#SBATCH --constraint=ntasks-per-node=3

export OMP_NUM_THREADS='1'
export PMIX_MCA_gds='hash'
export OMPI_MCA_btl_vader_single_copy_mechanism='none'

export OMP_NUM_THREADS=1
export PMIX_MCA_gds=hash
export OMPI_MCA_btl_vader_single_copy_mechanism=none
srun apptainer exec mpicc.sif call-procs
