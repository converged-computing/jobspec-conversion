#!/bin/bash
#SBATCH --job-name=example
#SBATCH --output=example_%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=development
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=36

export OMPI_MCA_btl='self,sm,openib'
export CP2K_DATA_DIR='/hpc/examples/cp2k/data'

module purge
source /hpc/spack/share/spack/setup-env.sh
spack load --dependencies cp2k
module list
export OMPI_MCA_btl="self,sm,openib"
export CP2K_DATA_DIR=/hpc/examples/cp2k/data
srun cp2k.popt water_pbed3.inp
