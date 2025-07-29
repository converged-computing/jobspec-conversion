#!/bin/bash
#SBATCH --job-name=gromacs
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:4
#SBATCH --time=2-00:00:00
#SBATCH --partition=ampere

export OMP_NUM_THREADS='$ntomp'

if [ -n "$SLURM_CPUS_PER_TASK" ]; then
   ntomp="$SLURM_CPUS_PER_TASK"
else
   ntomp="1"
fi
export OMP_NUM_THREADS=$ntomp
mpirun gmx_mpi mdrun -ntomp $ntomp -deffnm $1
