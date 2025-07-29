#!/bin/bash
#SBATCH --job-name=p128_node128
#SBATCH --account=Project_462000123
#SBATCH --output=%x-%j.out
#SBATCH --nodes=128
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=56
#SBATCH --mem=0
#SBATCH --time=02:00:00
#SBATCH --partition=standard-g
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

export PMI_NO_PREINITIALIZE='y'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='true'
export OMP_PLACES='cores'
export SLURM_CPU_BIND='${CPU_BIND}'

export PMI_NO_PREINITIALIZE=y
module load PrgEnv-cray
module load craype-x86-trento
module load craype-accel-amd-gfx90a
module load CrayEnv
module load rocm/5.6.1
module load cray-libsci
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=true
export OMP_PLACES=cores
CPU_BIND="mask_cpu:"
CPU_BIND="${CPU_BIND}0xfefefefefefefefe"
export SLURM_CPU_BIND="${CPU_BIND}"
srun "$(pwd)/../../../../src/spdyn/spdyn" p128.inp
srun "$(pwd)/../../../../src/spdyn/spdyn" p128.inp 2>&1 | tee p128.node128.mpi01.omp56.gpu01.cray.id000.out
srun "$(pwd)/../../../../src/spdyn/spdyn" p128.inp 2>&1 | tee p128.node128.mpi01.omp56.gpu01.cray.id001.out
srun "$(pwd)/../../../../src/spdyn/spdyn" p128.inp 2>&1 | tee p128.node128.mpi01.omp56.gpu01.cray.id002.out
srun "$(pwd)/../../../../src/spdyn/spdyn" p128.inp 2>&1 | tee p128.node128.mpi01.omp56.gpu01.cray.id003.out
srun "$(pwd)/../../../../src/spdyn/spdyn" p128.inp 2>&1 | tee p128.node128.mpi01.omp56.gpu01.cray.id004.out
