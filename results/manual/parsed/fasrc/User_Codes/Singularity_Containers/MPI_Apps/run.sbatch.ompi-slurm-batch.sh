#!/bin/bash
#SBATCH --job-name=mpi_test
#SBATCH --output=mpi_test.out
#SBATCH --error=mpi_test.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000
#SBATCH --time=00:30:00
#SBATCH --partition=test

export UCX_TLS='ib'
export PMIX_MCA_gds='hash'

export UCX_TLS=ib
export PMIX_MCA_gds=hash
module load gcc/10.2.0-fasrc01 
module load openmpi/4.1.1-fasrc01
srun -n 8 --mpi=pmix singularity exec openmpi_test.simg /home/mpitest.x
