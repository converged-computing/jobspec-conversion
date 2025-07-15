#!/bin/bash
#FLUX: --job-name=p016_node008
#FLUX: -N=8
#FLUX: -c=28
#FLUX: --exclusive
#FLUX: --queue=standard-g
#FLUX: -t=7200
#FLUX: --urgency=16

export PMI_NO_PREINITIALIZE='y'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='true'
export OMP_PLACES='cores'
export SLURM_CPU_BIND='${CPU_BIND}'

export PMI_NO_PREINITIALIZE=y
module load PrgEnv-gnu
module load craype-x86-trento
module load craype-accel-amd-gfx90a
module load CrayEnv
module load rocm/5.6.1
module load cray-libsci
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=true
export OMP_PLACES=cores
CPU_BIND="mask_cpu:"
CPU_BIND="${CPU_BIND}0xfefe0000fefe0000,"
CPU_BIND="${CPU_BIND}0x0000fefe0000fefe"
export SLURM_CPU_BIND="${CPU_BIND}"
srun "$(pwd)/../../../../src/spdyn/spdyn" p016.inp
srun "$(pwd)/../../../../src/spdyn/spdyn" p016.inp 2>&1 | tee p016.node008.mpi02.omp28.gpu02.gnu.id000.out
srun "$(pwd)/../../../../src/spdyn/spdyn" p016.inp 2>&1 | tee p016.node008.mpi02.omp28.gpu02.gnu.id001.out
srun "$(pwd)/../../../../src/spdyn/spdyn" p016.inp 2>&1 | tee p016.node008.mpi02.omp28.gpu02.gnu.id002.out
srun "$(pwd)/../../../../src/spdyn/spdyn" p016.inp 2>&1 | tee p016.node008.mpi02.omp28.gpu02.gnu.id003.out
srun "$(pwd)/../../../../src/spdyn/spdyn" p016.inp 2>&1 | tee p016.node008.mpi02.omp28.gpu02.gnu.id004.out
