#!/bin/bash
#SBATCH --job-name=hello-mpi
#SBATCH --output=helloF90-%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:01:00
#SBATCH --partition=compute
#SBATCH: --exclusive

export OMPI_MCA_btl_sm_eager_limit='8192'
export OMPI_MCA_btl_vader_eager_limit='8192'
export OMPI_MCA_mpi_show_mca_params='all'

export OMPI_MCA_btl_sm_eager_limit=8192
export OMPI_MCA_btl_vader_eager_limit=8192
export OMPI_MCA_mpi_show_mca_params=all
mpirun --verbose -np $SLURM_NTASKS ./hello
module load likwid
srun --mpi=pmix -n2 likwid-perfctr -C 0-3 -g CLOCK ./hello_world
