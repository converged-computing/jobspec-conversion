#!/bin/bash
#SBATCH --job-name=slurm_dedalus_examplerun1
#SBATCH --output=slurm_dedalus_examplerun1.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=24,rome,ib

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module -q purge
module -q load modules/2.2-20230808
module -q load gcc/11
module -q load openmpi/4.0.7
module -q load python/3.10.10
module -q load fftw/mpi-3.3.10
module -q load dedalus/3.2302-dev-py3.10.10
module list
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
lscpu
nvidia-smi
numactl -H
mpirun --map-by socket:pe=$OMP_NUM_THREADS -np $SLURM_NTASKS_PER_NODE --report-bindings python3 dedalus_examplefiber.py
