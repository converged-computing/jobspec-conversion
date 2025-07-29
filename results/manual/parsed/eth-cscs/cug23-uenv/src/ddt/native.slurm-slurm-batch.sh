#!/bin/bash
#SBATCH --output=job.out
#SBATCH --error=job.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=16
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=4

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load cray/22.11
module swap PrgEnv-cray PrgEnv-gnu
module swap gcc/11.2.0 CUDAcore/11.8.0
ddt --connect \
srun --cpus-per-task=16  \
--cpu-bind=verbose,none ./cuda_visible_devices.sh \
./native.exe
