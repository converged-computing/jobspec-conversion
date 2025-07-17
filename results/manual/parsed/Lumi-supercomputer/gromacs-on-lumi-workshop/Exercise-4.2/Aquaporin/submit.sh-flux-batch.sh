#!/bin/bash
#FLUX: --job-name=eccentric-chip-2171
#FLUX: -N=4
#FLUX: --exclusive
#FLUX: --queue=small-g
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='7'
export MPICH_GPU_SUPPORT_ENABLED='1'
export GMX_ENABLE_DIRECT_GPU_COMM='1'
export GMX_FORCE_GPU_AWARE_MPI='1'

module use /appl/local/csc/modulefiles
module load gromacs/2023.3-gpu
source ${GMXBIN}/lumi-affinity.sh
export OMP_NUM_THREADS=7
export MPICH_GPU_SUPPORT_ENABLED=1
export GMX_ENABLE_DIRECT_GPU_COMM=1
export GMX_FORCE_GPU_AWARE_MPI=1
num_multi=16
srun --cpu-bind=${CPU_BIND} ./select_gpu \
     gmx_mpi mdrun -multidir sim_{01..16} \
                   -npme 1 \
                   -nb gpu -pme gpu -bonded gpu -update gpu \
                   -g ex4.2_${SLURM_NNODES}N_multi${num_multi}_jID${SLURM_JOB_ID} \
                   -nsteps -1 -maxh 0.017 -resethway -notunepme
