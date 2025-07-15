#!/bin/bash
#FLUX: --job-name=p128_node128
#FLUX: -N=128
#FLUX: -c=56
#FLUX: --exclusive
#FLUX: --queue=standard-g
#FLUX: -t=7200
#FLUX: --priority=16

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
