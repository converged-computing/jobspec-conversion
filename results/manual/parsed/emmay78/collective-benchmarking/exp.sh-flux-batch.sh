#!/bin/bash
#FLUX: --job-name=nccl-benchmarking
#FLUX: -N=2
#FLUX: -c=8
#FLUX: --queue=gpu,gpu_test
#FLUX: -t=7200
#FLUX: --urgency=16

export MASTER_PORT='12340'
export WORLD_SIZE='2'
export NUM_NODES='$(scontrol show job $SLURM_JOBID | tr -s ' ' | cut -d ' ' -f 2 | awk '/NumNodes/ {print}' | cut -d '=' -f 2)'
export MASTER_ADDR='$master_addr'
export NCCL_DEBUG='INFO'
export NCCL_DEBUG_SUBSYS='INIT,ENV,NET,TUNING'
export NCCL_IB_CUDA_SUPPORT='1'
export NCCL_TUNING_FILE='${JOB_DIR}/init/tuning.data'
export NCCL_ALGO='Tree'

LOG_DIR="/n/holyscratch01/idreos_lab/Users/emyang/job_logs"
scontrol show job $SLURM_JOBID
JOB_DIR="${LOG_DIR}/$(date +"%Y%m%d")_$(date +"%H%M")"
mkdir -p ${JOB_DIR}/{joblogs,collective,bandwidth,coalesce}
echo "JOB_DIR="${JOB_DIR}
export MASTER_PORT=12340
export WORLD_SIZE=2
export NUM_NODES=$(scontrol show job $SLURM_JOBID | tr -s ' ' | cut -d ' ' -f 2 | awk '/NumNodes/ {print}' | cut -d '=' -f 2)
echo "WORLD_SIZE="${WORLD_SIZE}
echo "NUM_NODES="${NUM_NODES}
echo "JOB ID="${SLURM_JOB_ID}
echo "NODELIST="${SLURM_JOB_NODELIST}
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
echo "Username="$USER
export NCCL_DEBUG='INFO'
export NCCL_DEBUG_SUBSYS='INIT,ENV,NET,TUNING'
export NCCL_IB_CUDA_SUPPORT=1
export NCCL_TUNING_FILE=${JOB_DIR}/init/tuning.data
export NCCL_ALGO='Tree'
COLLECTIVES=("all_reduce")
for collective in ${COLLECTIVES[@]} 
do
    echo $collective
    srun --output ${JOB_DIR}/joblogs/%j_%t.out --error ${JOB_DIR}/joblogs/%j_%t.err python3 benchmark.py --out_dir ${JOB_DIR}/collective --collective $collective
    # srun --output ${JOB_DIR}/joblogs/%j_%t.out --error ${JOB_DIR}/joblogs/%j_%t.err python3 benchmark.py --out_dir ${JOB_DIR}/collective --collective $collective --async_op true
    # srun --output ${JOB_DIR}/joblogs/%j_%t.out --error ${JOB_DIR}/joblogs/%j_%t.err python3 benchmark.py --out_dir ${JOB_DIR}/collective --collective $collective --profile true
    # srun --output ${JOB_DIR}/joblogs/%j_%t.out --error ${JOB_DIR}/joblogs/%j_%t.err python3 benchmark.py --out_dir ${JOB_DIR}/collective --collective $collective --profile true --async_op true 
done
srun --output ${JOB_DIR}/joblogs/%j_%t_bw.out --error ${JOB_DIR}/joblogs/%j_%t_bw.err python3 bw_benchmark_two.py --out_dir ${JOB_DIR}/bandwidth
