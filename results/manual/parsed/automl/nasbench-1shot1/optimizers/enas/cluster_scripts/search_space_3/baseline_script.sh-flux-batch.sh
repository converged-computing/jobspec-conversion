#!/bin/bash
#FLUX: --job-name=hanky-malarkey-6735
#FLUX: --priority=16

echo "Workingdir: $PWD"
echo "Started at $(date)"
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION"
source ~/.bashrc
conda activate pytorch1.3
gpu_counter=1
for seed in {1..12}; do
  # Job to perform
  if [ $gpu_counter -eq $SLURM_ARRAY_TASK_ID ]; then
    PYTHONPATH=$PWD python optimizers/enas/enas.py --seed=${seed} --search_space=3 --epochs=100
    exit $?
  fi
  let gpu_counter+=1
done
echo "DONE"
echo "Finished at $(date)"
