#!/bin/bash
#SBATCH --job-name=lulesh+catalyst
#SBATCH --account=csstaff
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=debug
#SBATCH --constraint=ntasks-per-node=8,gpu

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export VTK_SILENCE_GET_VOID_POINTER_WARNINGS='1'

module load daint-gpu ParaView
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export VTK_SILENCE_GET_VOID_POINTER_WARNINGS=1
cp catalyst.py ../buildCatalyst/bin/lulesh2.0 $SCRATCH
pushd $SCRATCH
srun ./lulesh2.0 -x catalyst.py -s 30 -p
