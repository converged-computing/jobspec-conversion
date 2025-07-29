#!/bin/bash
#SBATCH --job-name=test_FE
#SBATCH --account=blanca-lundquist
#SBATCH --output=log.fe.%j
#SBATCH --mail-user=misa5952@colorado.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --time=00:30:00
#SBATCH --qos=preemptable
#SBATCH --constraint=ntasks-per-node=1

export I_MPI_FALLBACK='1'
export I_MPI_SHM_LMT='shm'

source /projects/misa5952/FastEddy/FastEddy_model/SRC/FEMAIN/setBeforeCompiling
export I_MPI_FALLBACK=1
export I_MPI_SHM_LMT=shm
module list
nvidia-smi > hhh
hostname
ulimit -s unlimited
FE=$PWD/SRC/FEMAIN/FastEddy
mpirun -np $SLURM_NTASKS $FE NBL_params.in
exit 0
