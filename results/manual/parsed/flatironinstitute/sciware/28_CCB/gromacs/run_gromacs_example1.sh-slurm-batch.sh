#!/bin/bash
#SBATCH --job-name=slurm_gromacs_examplerun1
#SBATCH --output=slurm_gromacs_examplerun1.log
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=ccb
#SBATCH --constraint=ntasks-per-node=120,rome,ib

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module -q purge
module -q load modules/2.2-20230808
module -q load openmpi/cuda-4.0.7
module -q load gromacs/mpi-2023.1
module list
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
lscpu
nvidia-smi
numactl -H
mpirun --map-by socket:pe=$OMP_NUM_THREADS gmx_mpi mdrun -v -deffnm gromacs_examplerun1
