#!/bin/bash
#FLUX: --job-name=red-cinnamonbun-1234
#FLUX: --queue=standard
#FLUX: -t=1800
#FLUX: --urgency=16

export PKG_CONFIG_PATH='$PKG_CONFIG_PATH:/opt/cray/pe/mpich/8.0.16/ofi/gnu/9.1/lib/pkgconfig'
export WORK='/work/e681/e681/skailasa'
export TEST='${WORK}/distributed-trees/strong'
export SCRATCH='${TEST}/strong_${SLURM_JOBID}'
export NCRIT='150'
export DEPTH='10'
export OUTPUT='${SCRATCH}/strong_scaling_${SLURM_JOBID}.csv'

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/cray/pe/mpich/8.0.16/ofi/gnu/9.1/lib/pkgconfig
export WORK=/work/e681/e681/skailasa
export TEST=${WORK}/distributed-trees/strong
export SCRATCH=${TEST}/strong_${SLURM_JOBID}
mkdir -p ${SCRATCH}
cd ${SCRATCH}
n_tasks=(1 2 4 8 16 32)
export NCRIT=150
export DEPTH=10
export OUTPUT=${SCRATCH}/strong_scaling_${SLURM_JOBID}.csv
touch ${OUTPUT}
echo "n_processes, n_leaves, runtime, encoding_time, sorting_time" >> ${OUTPUT}
for i in ${!n_tasks[@]}; do
    srun --ntasks=${n_tasks[$i]} --ntasks-per-core=1 --nodes=1 ${TEST}/strong >> ${OUTPUT}
done
