#!/bin/bash
#FLUX: --job-name=wavprompt
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

export NODELIST='nodelist.$'
export HOROVOD_GPU_ALLREDUCE='MPI'
export HOROVOD_GPU_ALLGATHER='MPI'
export HOROVOD_GPU_BROADCAST='MPI'
export NCCL_DEBUG='DEBUG'
export FAIRSEQ_ROOT='/home/heting/workplace/wavprompt/fairseq'

mkdir -p logs
PYTHON_VIRTUAL_ENVIRONMENT=wavprompt
CONDA_ROOT=/nobackup/users/$(whoami)/espnet/tools/conda
source ${CONDA_ROOT}/etc/profile.d/conda.sh
conda activate $PYTHON_VIRTUAL_ENVIRONMENT
ulimit -s unlimited
export NODELIST=nodelist.$
srun -l bash -c 'hostname' |  sort -k 2 -u | awk -vORS=, '{print $2":4"}' | sed 's/,$//' > $NODELIST
echo " "
echo " Nodelist:= " $SLURM_JOB_NODELIST
echo " Number of nodes:= " $SLURM_JOB_NUM_NODES
echo " GPUs per node:= " $SLURM_JOB_GPUS
echo " Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
export HOROVOD_GPU_ALLREDUCE=MPI
export HOROVOD_GPU_ALLGATHER=MPI
export HOROVOD_GPU_BROADCAST=MPI
export NCCL_DEBUG=DEBUG
echo " Running on multiple nodes/GPU devices"
echo ""
echo " Run started at:- "
date
export FAIRSEQ_ROOT=/home/heting/workplace/wavprompt/fairseq
if [ 0 -eq 0 ]; then
    pids=()
    n_token=0
    freeze_finetune_updates=0
    rfs=(2 4 8 16)
    for i in ${!rfs[@]}; do
    (
        rf=${rfs[$i]}
        echo "${i} th element: ${n_token}"
        srun --ntasks=1 --exclusive --gres=gpu:1 --mem=32G -c 1 ./run.sh \
            --stage 10 --stop-stage 10 \
            --manifest-path "$(pwd)/manifest/librispeech100" --config-name "asr_pretraining" \
            --n-token ${n_token} --reduction-factor ${rf} --freeze_finetune_updates ${freeze_finetune_updates} \
            --save-dir $(pwd)/outputs/wavpromptlsp100rf${rf}ntok${n_token}
    ) &
    pids+=($!)
    done
    i=0; for pid in "${pids[@]}"; do wait ${pid} || ((++i)); done
    [ ${i} -gt 0 ] && echo "$0: ${i} background jobs are failed." && false
fi
echo "Run completed at:- "
date
