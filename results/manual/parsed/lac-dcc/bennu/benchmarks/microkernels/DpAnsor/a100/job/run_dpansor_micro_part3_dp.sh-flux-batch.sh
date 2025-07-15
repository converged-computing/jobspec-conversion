#!/bin/bash
#FLUX: --job-name=dp_part3_dpansor_micro_cuda_a100
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

export TVM_HOME='/mnt/home/gverma/ceph/tvm'
export PYTHONPATH='/mnt/sw/nix/store/i613v246n7m0f6k22a8bwxsj51d1z6gb-llvm-11.1.0/lib/python3/site-packages:/mnt/home/gverma/ceph/tvm/python'

date
hostname
echo "Greetings from $SLURM_ARRAY_TASK_ID!"
module load modules/2.1.1-20230405 
module load cmake/3.25.1  python/3.8.15 cuda/11.8.0  llvm/11.1.0 cudnn/8.4.0.27-11.6   gcc/10.4.0
export TVM_HOME=/mnt/home/gverma/ceph/tvm
export PYTHONPATH=/mnt/sw/nix/store/i613v246n7m0f6k22a8bwxsj51d1z6gb-llvm-11.1.0/lib/python3/site-packages:/mnt/home/gverma/ceph/tvm/python
TOP=(
    1
    10
    25
    50
    100
    200
    300
    1000
)
NAME="a100"
BENCH=(
    depthwise
    pooling
)
for ((j = 0; j < ${#TOP[@]}; j++)); do
    echo "Top-"${TOP[j]}
    RESULT=results/$NAME"_top"${TOP[j]}".csv"
    echo "Top-"${TOP[j]} >> $RESULT
    echo "bench, avg (ms), std (ms), trials, time total (min), ansor exec (ms), ansor tuning, speedup" >> $RESULT
    for ((i = 0; i < ${#BENCH[@]}; i++)); do
        echo "Executing "${BENCH[i]}"..."
        python3 src/dpansor.py -m dpansor -a cuda -l log/$NAME"_"${BENCH[i]}.log -k ${TOP[j]} -b ${BENCH[i]} >> $RESULT
    done
done
date
echo -e "\nCompleted\n"
