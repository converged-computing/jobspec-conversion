#!/bin/bash
#SBATCH --account=slai
#SBATCH --output=job.out
#SBATCH --error=job.err
#SBATCH --nodes=16
#SBATCH --ntasks=256
#SBATCH --cpus-per-task=8
#SBATCH --time=01:30:00
#SBATCH --constraint=ntasks-per-node=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
ml Stages/2022 GCC OpenMPI imkl CMake Boost git
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
srun -n 256 --threads-per-core=1 ../DEMAGIS/build/examples/driver_scalapack.exe --N 120000 --dim0 16 --dim1 16 --mbsize 500 --nbsize 500 --dmax 40 --epsilon=1e-4 --myDist 0
mv *.bin ../../../data/
