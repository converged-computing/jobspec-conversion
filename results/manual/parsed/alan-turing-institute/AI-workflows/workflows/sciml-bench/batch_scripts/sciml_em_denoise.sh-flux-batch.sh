#!/bin/bash
#FLUX: --job-name=sciml_em_denoise
#FLUX: --queue=%partition
#FLUX: -t=43200
#FLUX: --priority=16

module purge
module load %modules
if [ "$SLURM_ARRAY_JOB_ID" ]; then
    job_id="${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
else
    job_id="$SLURM_JOB_ID"
fi
scratch_host="%scratch_host"
scratch="$scratch_host/$job_id"
inputs="datasets/em_graphene_sim"
outputs="output_$job_id"
container="sciml-bench_cu11.sif"
container_command="sciml-bench run em_denoise --output_dir=./output_$job_id --dataset_dir=/scratch_mount/em_graphene_sim"
run_command="singularity exec
  --nv
  --bind $scratch:/scratch_mount
  --pwd /scratch_mount
  $container
  $container_command"
mkdir -p "$scratch"
for item in $inputs; do
    echo "Copying $item to scratch"
    cp -r "$item" "$scratch"
done
nvidia-smi dmon -o TD -s puct -d 1 > "dmon_$job_id".txt &
gpu_watch_pid=$!
start_time=$(date -Is --utc)
$run_command
end_time=$(date -Is --utc)
kill $gpu_watch_pid
echo "executed: $run_command"
echo "started: $start_time"
echo "finished: $end_time"
for item in $outputs; do
    echo "Copying $item from scratch"
    cp -r "$scratch/$item" ./
done
rm -rf "$scratch"
