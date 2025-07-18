#!/bin/bash
#FLUX: --job-name=mos2
#FLUX: --queue=cpu
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module purge
module use /ceph/hpc/data/d2021-135-users/modules
module load YAMBO/5.1.1-FOSS-2022a
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
ncpu=${SLURM_NTASKS}
nthreads=${OMP_NUM_THREADS}
label=MPI${ncpu}_OMP${nthreads}
jdir=run_${label}
cdir=run_${label}.out
filein0=gw.in         # Original file
filein=gw_${label}.in # New file
cp -f $filein0 $filein
cat >> $filein << EOF
DIP_CPU= "1 $ncpu 1"          # [PARALLEL] CPUs for each role
DIP_ROLEs= "k c v"            # [PARALLEL] CPUs roles (k,c,v)
DIP_Threads=  0               # [OPENMP/X] Number of threads for dipoles
X_and_IO_CPU= "1 1 1 $ncpu 1" # [PARALLEL] CPUs for each role
X_and_IO_ROLEs= "q g k c v"   # [PARALLEL] CPUs roles (q,g,k,c,v)
X_and_IO_nCPU_LinAlg_INV=1    # [PARALLEL] CPUs for Linear Algebra (if -1 it is automatically set)
X_Threads=  0                 # [OPENMP/X] Number of threads for response functions
SE_CPU= "1 $ncpu 1"           # [PARALLEL] CPUs for each role
SE_ROLEs= "q qp b"            # [PARALLEL] CPUs roles (q,qp,b)
SE_Threads=  0                # [OPENMP/GW] Number of threads for self-energy
EOF
srun --mpi=pmix -n $ncpu yambo -F $filein -J $jdir -C $cdir
