#!/bin/bash
#SBATCH --job-name=lulesh
#SBATCH --account=csstaff
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=debug
#SBATCH --constraint=ntasks-per-node=8,mc

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export VTK_SILENCE_GET_VOID_POINTER_WARNINGS='1'

module load daint-mc ParaView
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export VTK_SILENCE_GET_VOID_POINTER_WARNINGS=1
cp script.py buildCatalyst/bin/lulesh2.0 $SCRATCH
pushd $SCRATCH
srun ./lulesh2.0 -x script.py -s 30 -p
