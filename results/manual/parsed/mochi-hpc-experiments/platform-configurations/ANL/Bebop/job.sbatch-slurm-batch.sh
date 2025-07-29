#!/bin/bash
#SBATCH --account=MY_PROJECT
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

export PSM2_MULTI_EP='1 # prevents conflict with MPI using PSM2'
export FI_PSM2_DISCONNECT='1 # enables reconnection'

set -eu
export PSM2_MULTI_EP=1 # prevents conflict with MPI using PSM2
export FI_PSM2_DISCONNECT=1 # enables reconnection
echo "Activating env"
. $HOME/spack/share/spack/setup-env.sh
module load gcc/8.2.0-g7hppkz
spack env activate myenv
echo "Starting application"
srun -N 2 -n 4 ...
