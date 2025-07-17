#!/bin/bash
#FLUX: --job-name=misunderstood-diablo-1973
#FLUX: -N=2
#FLUX: --queue=regular
#FLUX: -t=3600
#FLUX: --urgency=16

export PATH='$PATH:/global/homes/m/mingkuan/torque/deps/quartz/external/HiGHS/build/bin'
export MPICH_GPU_SUPPORT_ENABLED='1'

module load nccl
conda activate torque
export PATH=$PATH:/global/homes/m/mingkuan/torque/deps/quartz/external/HiGHS/build/bin
export MPICH_GPU_SUPPORT_ENABLED=1
strings=("ae" "dj" "ghz" "graphstate" "ising" "qft" "qpeexact" "qsvm" "su2random" "vqc" "wstate" "bv")
for str in "${strings[@]}"; do
    # Execute the command with the current string
    srun -u \
         --ntasks="$(( SLURM_JOB_NUM_NODES ))" \
         --ntasks-per-node=1\
         /global/homes/m/mingkuan/torque/build/examples/mpi-based/simulate --import-circuit ${str} --n 31 --local 28 --device 4 --use-ilp > /global/homes/m/mingkuan/result-srun/torque-new/${str}_31.log
done
