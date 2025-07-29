#!/bin/bash
#SBATCH --account=slai
#SBATCH --output=job.out
#SBATCH --error=job.err
#SBATCH --nodes=64
#SBATCH --ntasks=1024
#SBATCH --cpus-per-task=8
#SBATCH --time=1-00:00:00
#SBATCH --partition=dc-cpu
#SBATCH --constraint=ntasks-per-node=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
ml Stages/2022 GCC OpenMPI imkl CMake Boost git
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
srun -n 1024 --threads-per-core=1 ../DEMAGIS/build/examples/driver_scalapack.exe --N 240000 --dim0 32 --dim1 32 --mbsize 500 --nbsize 500 --dmax 80 --epsilon=1e-4 --myDist 0
mv *.bin ../../../data/
