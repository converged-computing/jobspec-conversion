#!/bin/bash
#SBATCH --job-name=p064_node008
#SBATCH --account=Project_462000123
#SBATCH --output=%x-%j.out
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --mem=0
#SBATCH --time=02:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=8

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
CPU_BIND="${CPU_BIND}0x00fe000000000000,"
CPU_BIND="${CPU_BIND}0xfe00000000000000,"
CPU_BIND="${CPU_BIND}0x0000000000fe0000,"
CPU_BIND="${CPU_BIND}0x00000000fe000000,"
CPU_BIND="${CPU_BIND}0x00000000000000fe,"
CPU_BIND="${CPU_BIND}0x000000000000fe00,"
CPU_BIND="${CPU_BIND}0x000000fe00000000,"
CPU_BIND="${CPU_BIND}0x0000fe0000000000"
export SLURM_CPU_BIND="${CPU_BIND}"
srun "$(pwd)/../../../../src/spdyn/spdyn" p064.inp
srun "$(pwd)/../../../../src/spdyn/spdyn" p064.inp 2>&1 | tee p064.node008.mpi08.omp07.gpu08.cray.id000.out
srun "$(pwd)/../../../../src/spdyn/spdyn" p064.inp 2>&1 | tee p064.node008.mpi08.omp07.gpu08.cray.id001.out
srun "$(pwd)/../../../../src/spdyn/spdyn" p064.inp 2>&1 | tee p064.node008.mpi08.omp07.gpu08.cray.id002.out
srun "$(pwd)/../../../../src/spdyn/spdyn" p064.inp 2>&1 | tee p064.node008.mpi08.omp07.gpu08.cray.id003.out
srun "$(pwd)/../../../../src/spdyn/spdyn" p064.inp 2>&1 | tee p064.node008.mpi08.omp07.gpu08.cray.id004.out
