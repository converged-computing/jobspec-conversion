#!/bin/bash
#SBATCH --account=PHY20010
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

ml
source $SPACK_DIR/share/spack/setup-env.sh
spack load gcc@11.2.0
spack load cuda@11.5.2
ibrun ./cactus_CarpetX-cuda qc0.par
