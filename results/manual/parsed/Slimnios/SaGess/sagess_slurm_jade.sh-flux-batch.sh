#!/bin/bash
#FLUX: --job-name=confused-general-6475
#FLUX: -c=24
#FLUX: --queue=small
#FLUX: -t=259200
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='$SLURM_JOB_GPUS'

export CUDA_VISIBLE_DEVICES=$SLURM_JOB_GPUS
echo "IDs of GPUs available: $CUDA_VISIBLE_DEVICES"
echo "No of GPUs available: $(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)"
echo "No of CPUs available: $SLURM_CPUS_PER_TASK" 
echo "nproc output: $(nproc)"
nvidia-smi
sleep 10
if [ "$SLURM_ARRAY_JOB_ID" ]; then
    job_id="${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
else
    job_id="$SLURM_JOB_ID"
fi
repo="sagess"
dataset="EmailEUCore"
cat configs/dataset/${dataset}.yaml
scratch_host="/raid/local_scratch"
scratch_root="$scratch_host/${USER}/${job_id}"
inputs="."
outputs="outputs"
container="./container/${repo}_ws.sif"
container_command="./hpc_run_script.sh"
run_command="singularity exec
  --nv
  --bind $scratch_root:/scratch_mount
  --pwd /scratch_mount
  --env CUDA_VISIBLE_DEVICES=0
  --env DATASET=${dataset}
  $container
  $container_command"
mkdir -p "$scratch_root"
for item in $inputs; do
    echo "Copying $item to scratch_root"
    cp -r "$item" "$scratch_root"
done
nvidia-smi dmon -o TD -s um -d 1 > "dmon_$job_id".txt &
gpu_watch_pid=$!
start_time=$(date -Is --utc)
$run_command
end_time=$(date -Is --utc)
kill $gpu_watch_pid
echo "executed: $run_command"
echo "started: $start_time"
echo "finished: $end_time"
for item in $outputs; do
    echo "Copying $item from scratch_root"
    cp -r "$scratch_root/$item" ./
done
rm -rf "$scratch_root"
